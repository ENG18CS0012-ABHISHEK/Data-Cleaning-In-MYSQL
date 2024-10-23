#Layoffs Data Analysis using MySQL
This project focuses on analyzing layoffs data, sourced from Kaggle, using MySQL for data cleaning and structuring. The dataset consists of various key columns: company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, and funds_raised_millions.

#Key Features:
Data Extraction: The dataset was imported into MySQL Workbench.
Data Cleaning: Three tables were created for this process:
layoffs (raw data),
layoffs_stagging (intermediate stage),
layoffs_stagging_2 (final cleaned data).
Cleaning Operations: This involved handling missing values, formatting dates, normalizing location and company names, and ensuring consistency in the dataset.
Final Clean Data: The cleaned data is stored in the layoffs_stagging_2 table, ready for further analysis or visualization.
