Siin on andmetarkuse kursuse materjalid

# Sales Report 
A Power BI file for a Sales Report: https://github.com/rainerkoorem/andmetarkus2026/blob/main/Sales%20Report.pbix
The file can be opened in Power BI Desktop
Next, the steps of the analysis are explained.

## Overview of the company
A dataset created by OpenAI.

## Data cleaning
Cleaned the data using Power Query.

## Analysis
Created various dashboards to visualize and analyze the data.

## Recommendations
Presented the recommendations to the stakeholders to improve the company.


# Employee Report

## Problem Statement
HR Department needs an overview of the employee satisfaction survey.

## Plan
A Power BI report will be created to give the overview.

## Data
HR Department has shared two files:
- Employee Satisfaction Survey: https://github.com/virverani/andmetarkus_2026_kevad/raw/refs/heads/main/Day4/Employee_Satisfaction_Survey.xlsx
- HR Dataset: https://raw.githubusercontent.com/virverani/andmetarkus_2026_kevad/refs/heads/main/Day4/HR_dataset.csv

### Data Cleaning
Checked the data for uniqueness, format and outliers.  

  
Survey dataset didn't have a unique key, so two columns "Question Round" and "Answer ID" were merged to create one called "AnswerKey".  

  
From the HR Dataset, the personal information columns "First Name", "Last Name" and "Email" were removed. Also, the "Employement Status" column was removed due to not being up to date.
