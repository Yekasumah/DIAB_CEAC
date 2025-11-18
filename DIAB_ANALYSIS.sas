proc import datafile="/home/u64333484/diabetes_cost_effectiveness_synthetic (1).csv"
    out=diab
    dbms=csv
    replace;
    getnames=yes;
run;

proc print data=diab(obs=5); 
run;

proc print data=diab(obs=10);
run;

/* Convert Therapy into a numeric categorical variable */
data diab_clean;
    set diab;
    if Therapy = "A" then Therapy_Group = 1;
    else if Therapy = "B" then Therapy_Group = 2;
    else if Therapy = "C" then Therapy_Group = 3;
run;

/* Check dataset */
proc means data=diab_clean mean std min max;
run;

proc reg data=diab_clean;
    model Total_Cost = Adherence_Rate QALY_Gain HbA1c_Improvement Therapy_Group;
run;
quit;

proc means data=diab_clean mean;
    class Therapy;
    var Total_Cost QALY_Gain;
    output out=summary mean=Mean_Cost Mean_QALY;
run;

proc print data=summary;
run;

data icer;
    set summary;
    retain CostA QALYA CostB QALYB CostC QALYC;

    /* Store group means */
    if Therapy = "A" then do; CostA = Mean_Cost; QALYA = Mean_QALY; end;
    if Therapy = "B" then do; CostB = Mean_Cost; QALYB = Mean_QALY; end;
    if Therapy = "C" then do; CostC = Mean_Cost; QALYC = Mean_QALY; end;
run;

/* Create final ICER table manually */
data icer_final;
    set icer end=last;

    if last then do;
        ICER_BA = (CostB - CostA) / (QALYB - QALYA);
        ICER_CA = (CostC - CostA) / (QALYC - QALYA);
        ICER_CB = (CostC - CostB) / (QALYC - QALYB);
        output;
    end;
run;

proc print data=icer_final;
run;

/* Create synthetic time-to-complication */
data diab_surv;
    set diab_clean;
    Time_To_Complication = rand("Uniform") * 365;
    Event = (Complications > 0);
run;

proc lifetest data=diab_surv plots=survival;
    time Time_To_Complication * Event(0);
    strata Therapy;
run;

proc glm data=diab_clean;
    class Therapy;
    model Total_Cost = Therapy QALY_Gain Adherence_Rate Hospitalizations / solution;
run;
quit;

proc sgplot data=diab_clean;
    scatter x=QALY_Gain y=Total_Cost / group=Therapy;
    xaxis label="QALYs Gained";
    yaxis label="Total Cost ($)";
run;

data icer_summary;
    set icer_final;
    Therapy_Comparison = "B vs A"; ICER = ICER_BA; output;
    Therapy_Comparison = "C vs A"; ICER = ICER_CA; output;
    Therapy_Comparison = "C vs B"; ICER = ICER_CB; output;
run;

proc print data=icer_summary label;
    label Therapy_Comparison = "Comparison"
          ICER = "Incremental Cost-Effectiveness Ratio ($/QALY)";
    title "ICER Summary Table";
run;

ods pdf file="/home/u64333484/DIAB_RESULT .pdf";

/* Insert the summary analyses */
title "Diabetes Cost-Effectiveness Analysis Summary Report";
proc means data=diab_clean mean std n;
    class Therapy;
    var Total_Cost QALY_Gain Adherence_Rate;
run;

proc print data=icer_summary;
run;

proc reg data=diab_clean;
    model Total_Cost = Adherence_Rate QALY_Gain HbA1c_Improvement Therapy_Group;
run;

ods pdf close;



