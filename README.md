# World-Layoffs 2020-2023 Analysis

![](layoffs_image.webp)
---

## Introduction

This is a Power BI project that focuses on global layoffs from 2020 to 2023, aiming to analyze and extract actionable insights. The goal is to answer key questions and support stakeholders in making data-driven decisions based on trends and patterns in workforce reductions across various industries and countries.

## Problem Statement

The global workforce has experienced significant layoffs from 2020 to 2023, driven by unprecedented factors such as the COVID-19 pandemic, economic instability, and technological advancements. These events caused widespread layoffs across many industries and countries, affecting thousands of workers and changing the job market significantly.

 This project analyzes layoff trends across industries and countries, highlighting key insights that can help business leaders, policymakers, and investors understand the landscape of workforce reductions and plan for future workforce changes.

By analyzing data from multiple sources, this analysis aims to provide a detailed understanding of when and where layoffs happened, how large they were, and the sectors that were most affected. The ultimate goal is to offer actionable insights to help organizations and policymakers reduce the negative impacts of layoffs while preparing for the future.

## Project Objectives

- Identify layoff trends over the 2020–2023 period across industries and country. 
- Understand the drivers behind major layoff events. 
- Provide actionable insights for businesses, governments, and investors to prepare for future workforce changes.
- Highlight potential sectors at risk of further layoffs based on current trends.

## Data Collection and Preparation

Dataset used for the analysis can be found here https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv.

## Data Structure
- The dataset used for the analysis contains 9 columns and 2,361 rows.
- Time periods covered: (2020-2023).
- Industries involved (e.g, consumer,healthcare,Marketing, retail, finance, etc.)

## Data Cleaning
Tool used for transforming and data cleaning (MYSQL)

Handling missing data:
- Blank spaces were set to null values.
- 348 null values that were not useful for the analysis were deleted from the data.

  
Transforming data:
 - 22 duplicates were deleted from the data, leaving 2,339 unique values.
 - The date column data type was changed from a string  data type to a date format.
- White spaces were trimmed from the data.
- Misspelled values were corrected.


 ## Executive Summary
 
## Overview and Findings

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/world_layoff_202-2023_Dashboard.PNG)
---


- In total, there are 383,320 layoffs from the year 2020 to 2023.
- Layoff trends saw significant changes over the years, with the largest increases occurring in 2022 and 2023. These rises were closely tied to the global pandemic economic uncertainty, 
affecting many industries.
 - The consumer and retail sectors were the most affected by layoffs, especially in 2022, driven by rapid changes in economic uncertainty, change in consumer behavior and technology which replaced many traditional roles in these sectors.
 - Geographically, layoffs were concentrated in the United States, Europe, and Asia, with each region facing unique industry-specific challenges, such as layoffs in the consumer and retail sector in  United States and the healthcare industry having the second highest layoffs in Europe.




## Insights Deep Dive



## Total Layoffs Over Time:

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoff_by_year.PNG)
---

The data spans three years and shows fluctuations in layoffs from March 2020 to March 2023. This analysis show the increase and decrease in layoffs over time.
- From our analysis we can infer that 2020, the onset of the COVID-19 pandemic triggered massive layoffs with a total of 80,998 layoffs globally.
- Layoffs decreased significantly in 2021 with a total of 15,823 total layoffs, indicating potential seasonal trends or economic adjustments
- From our analysis 2022 turns to be the year with the highest layoffs globally, with total layoffs of 160,322, possibly reflecting ongoing economic instability or industry adjustments.
- Although our analysis for 2023 shows layoff for only three months, 2023 shows total layoffs of 125,677, indicating the year with the second highest layoffs globally.




## Total Layoffs By Month

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoffs_by_month.PNG)
---

The data reveals that January has the highest layoffs from 2020 to 2023 at 92,037. November also sees a significant spike at 55,699 and September experiences the lowest layoffs at 6,451.




## Total Layoffs By Country

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoff_%20by_country.PNG)

- The United States has the highest in total layoffs by a significant margin, with 256,420 employees laid off from 2020 to 2023 with its highest layoff in the consumer and retail industry. This is far higher than any other country, indicating that  United States experienced the most severe layoffs during this period.
- This might be due to the large size of the United States economy, its workforce, and the high concentration of major industries, such as consumer and retail which were hit hard during the pandemic and economic downturn.

- The top five countries (United States, India, Netherlands, Sweden, and Brazil) account for a large portion of global layoffs. With India having 35,793, Netherlands 17,220, Sweden 11,264 and Brazil 10,391 total layoffs globally.
- In all,  North America leads in layoffs, followed by Asia and Europe, while Africa and Oceania experienced fewer layoffs.




## Total Layoffs By Industry


![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoffs_by_industry.PNG)
---

This analysis seeks to compare the number of layoffs across industries.
- The top three most affected industries by global layoff from 2020 and 2023 are the Consumer (45,182 layoffs), Retail (43,613 layoffs), and Other (36,209 layoffs). This is as a result of a shift to e-commerce and AI, changes in consumer behavior etc.
- From our data we can observe that the Manufacturing industry had the lowest layoffs overall, with only 20 layoffs.
- In 2020, Transportation and Travel saw the highest impact due to global lockdowns and restrictions.
- In 2021, consumer and real estate industry experienced the highest total layoff globally, in 2022 the retail and consumer industry and lastly in 2023 the consumer and retail industry were the most affected industries.




## Total Layoffs By Company Stage

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoffs_by_company_stage.PNG)
---


- From the analysis we can observe that Post-IPO companies had the highest number of layoffs,which is 204,073 of total layoff globally, which is significantly higher than any other company stage.
- Companies with an unknown stage reported 40,716, which is a large number, even though it is unclear what stage these companies are in.
- Companies in the Acquired stage were significantly affected which accounted to a 27,496 in the total layoff.
- Companies in Series C, Series D, Series E , and Series F  also saw significant layoffs globally.





## Total Layoffs By Funds Raised By Companies

![](https://github.com/Judithkyerewaa/World-Layoffs/blob/main/layoffs_by_funds_raised.PNG)
---

 This analysis uncover the correlation between the funds raised by companies and the total number of layoffs. 
- Companies that raised relatively low fund reported varying levels of layoffs.
- Companies that raised higher funds also reported a significant layoffs. This indicates that raising higher funds does not necessarily protect companies from layoffs.	
- From our analysis we can observe that there is no  clear connection between how much money a company raises and how many layoffs it has. This shows that other things like the industry they are in and changes in the market have a bigger impact on layoffs than just the amount of money they have.





## Recommendations

Based on the insights and findings above, we would recommend companies to consider the following:

- We recommend that companies that focused too much on one sector, like consumer or retail, should adopt diversify workforce strategies. Employees should be helped to learn a variety of skills and work in different departments so they can adjust more easily to changes. This will help employees with a broad range of skills transition between departments or roles more easily if a particular sector faces a downturn. This will help companies to better respond to changes in market conditions and industry shifts.
- As technology and automation take over traditional jobs, companies need to plan how they use these new tools. By helping employees learn new skills and ensuring technology works alongside them, businesses can avoid job losses and improve overall efficiency.
- Companies should foster flexible work models like remote or hybrid that allow them to remain productive while minimizing the need for downsizing during economic challenges.
- Companies should invest in risk management strategies to predict and handle potential financial challenges. By preparing for economic changes, they can avoid layoffs by having better control over financial risks and uncertainties. This will help the company stay stable during tough times without needing to reduce the workforce.
- Stakeholders should encourage good work ethics by empowering employees to follow strong ethical standards. This helps the business run efficiently and reduces the chance of layoffs caused by performance-related issues.




## Challenges And Limitations

- Classifying companies into a broad "Other" category instead of their actual industries creates problems for our analysis. It makes it harder to spot trends for specific industries, reduces the accuracy of comparisons, and could lead to the "Other" category being overestimated while leaving some industries underrepresented.
- Placing companies into an "Unknown" category for their stage also makes the analysis difficult. Without knowing what stage these companies are in, it's harder to understand how layoffs affected them, which leads to unclear trends in the data.
- Not having data on the total number of employees for each company is another limitation. Without this information, it's harder to calculate the true impact of layoffs because we can't compare companies of different sizes effectively. This limits our ability to understand the full scale of the layoffs.




## Conclusion

The analysis of global layoffs from 2020 to 2023 highlights how much the COVID-19 pandemic, economic instability, and technological changes have affected workers. Layoffs were especially high in sectors like consumer and retail, with the biggest increases happening in 2022. The United States., Europe, and Asia experienced the most significant workforce reductions, particularly in industries struggling with technological changes and market shifts.

This project offers important insights into layoff trends, helping business leaders, policymakers, and investors prepare for future layoffs in the job market.The findings suggest that companies should create flexible workforce plans and work together with other industries. This will help lessen the negative effects of mass layoffs and build a stronger and more resilient job market as we face ongoing challenges.

