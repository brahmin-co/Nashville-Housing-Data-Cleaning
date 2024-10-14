# Data Cleaning SQL Script for Nashville Housing Dataset
### Project Overview

This SQL script is designed to clean and standardize the data within the Nashville Housing table in the [Portfolio Project].dbo database. It focuses on standardizing date formats, filling in missing values, and updating existing records for improved consistency and accuracy.

### Data Sources

Housing data - The primary dataset used for this analysis is the "Nashville_Housing.csv", containing information about the Nashville housing company. 

### Tools

- Excel - Data cleaning
- SQL - Data Analysis

## Files

- **Data Cleaning.sql**: This SQL file contains all the queries used for cleaning the Nashville Housing dataset, including:
  - Standardizing the `Saledate` field.
  - Adding a new column for storing the converted date.
  - Updating the table with cleaned date values.
  - Potentially handling other data inconsistencies.

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

The following steps are included in the cleaning process:

1. **Standardizing Date Formats**: Converts the `Saledate` field to a standard `Date` format and stores it in a new column `SaleDateConverted`.
2. **Populating New Columns**: Updates the newly added column with cleaned and standardized date values.
3. **Table Alterations**: Modifies the existing table structure to accommodate the cleaned data.

## Example Queries

Some of the key operations in the `Data Cleaning.sql` file include:

- **Standardizing Date Format**:
  ```sql
  UPDATE [Portfolio Project].dbo.[Nashville Housing]
  SET SaleDateConverted = CONVERT(Date, Saledate);
