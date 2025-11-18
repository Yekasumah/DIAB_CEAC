# DIAB_CEAC
Diabetes Therapy Cost-Effectiveness Analysis
Overview

This project evaluates the cost-effectiveness of different diabetes therapy strategies using SAS Studio. The analysis uses a synthetic dataset that includes treatment costs, hospitalization events, QALYs gained, adherence levels, and clinical outcomes such as HbA1c improvement and complications. The goal is to understand how therapy choice and adherence influence both costs and long-term patient outcomes.

Methods
Cost Modeling

A regression model was developed to understand how total healthcare costs are influenced by adherence rates, QALY gains, clinical improvement, and therapy group.

ICER Calculation

Incremental Cost-Effectiveness Ratios (ICERs) were computed to compare therapies.
The formula used:

𝐼
𝐶
𝐸
𝑅
=
𝐶
𝑜
𝑠
𝑡
𝑇
𝑥
−
𝐶
𝑜
𝑠
𝑡
𝐶
𝑜
𝑚
𝑝
𝑎
𝑟
𝑎
𝑡
𝑜
𝑟
𝑄
𝐴
𝐿
𝑌
𝑇
𝑥
−
𝑄
𝐴
𝐿
𝑌
𝐶
𝑜
𝑚
𝑝
𝑎
𝑟
𝑎
𝑡
𝑜
𝑟
ICER=
QALY
Tx
	​

−QALY
Comparator
	​

Cost
Tx
	​

−Cost
Comparator
	​

	​

Survival Analysis

A time-to-complication model was created using synthetic time-to-event data. Kaplan–Meier curves were generated to compare the risk of complications across therapy groups.

Summary Output

A summary of descriptive statistics, regression results, and cost-effectiveness outcomes was produced using SAS output tables and procedures.

Key Findings

Therapies with higher adherence produced better QALY gains and lower long-term healthcare costs.

Early adherence-focused therapies, although initially more expensive, reduced hospitalization and complication-related costs.

ICER results showed that therapies with better adherence and clinical outcomes delivered more value per QALY gained.

Higher adherence was associated with longer time to complications, demonstrating both clinical and economic benefits.

Author

Onyeka Asumah
Health Economics | Pharmacy | Data Analysis
