# Data Cleaning SQL Script for Nashville Housing Dataset
### Project Overview

This SQL script is designed to clean and standardize the data within the Nashville Housing table in the [Portfolio Project].dbo database. It focuses on standardizing date formats, filling in missing values, and updating existing records for improved consistency and accuracy.

### Data Sources

Housing data - The primary dataset used for this analysis is the "Nashville_Housing.csv", containing information about the Nashville housing company. 

### Tools

- Excel - Data cleaning
- SQL - Data Analysis

### Data Cleaning / Preparations

In the initial data preparation phase I performed the following tasks:
1. Converted the Saledate column into a standard Date format.
2. Ensured that missing or null values are appropriately filled or managed.
3. Applied corrections and updates to existing records.

### Exploratoty Data Analysis

EDA involved exploring the housing data to answer key questions, such as ;

- What is the average, median, and range of housing prices.
- Which key factors are affecting prices (e.g., location, square footage).
- What are the trends in the housing market over time.


### Data Analysis

The script includes the following data cleaning operations:
#### 1. Standardize Date Formats
Loading dataset in the server
```sql
SELECT * FROM [Portfolio Project].dbo.[Nashville Housing]
```
Convert the Saledate column into a standard Date format.
```sql
SELECT SaleDateConverted, CONVERT(Date, Saledate)
FROM [Portfolio Project].dbo.[Nashville Housing]
```
