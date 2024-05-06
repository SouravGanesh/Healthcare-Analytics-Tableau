# Healthcare Analytics Dashboard with Tableau

## Overview
Designed PostgreSQL data models for a healthcare dataset, optimizing the database for seamless management of records. Developed efficient SQL queries for business requirements and created Tableau dashboards for data visualization from transformed data, identifying key performance indicators (KPIs) for successful analytics outcomes.

### Dataset
The dataset was downloaded from [Synthea](https://synthetichealth.github.io/synthea/), available in text format.

### PostgreSQL Setup
1. Create tables in PostgreSQL using the code available in 'SQL Queries - DDL'.
2. Import data from flat files using the import wizard.

### Business Requirements
**Objectives:** 
Come up with a flu shots dashboard for 2022 that does the following:

1. Total % of patients getting flu shots stratified by:
   - Age
   - Race
   - County (On a Map)
   - Overall
2. Running Total of Flu Shots over the course of 2022.
3. Total number of Flu shots given in 2022.
4. A list of Patients that show whether or not they received the flu shots.

**Requirements:**
- Patients must have been "Active at our hospital".
- Age to receive shot is 6 months or older.

### SQL Queries
Refer to 'Table Queries - DQL' for efficient SQL queries to meet the business requirements.

### Tableau Visualization
1. Download the filtered data from query output.
2. Import it into Tableau Public.
3. Design the sheets.
4. Use them all to create the dashboard.

### Published Dashboard
You can view my published dashboard [here](https://public.tableau.com/app/profile/sourav.ganesha/viz/FluShotsDashboard_17149365319030/Dashboard1).

![Main Diagram](Architecture/architecture.png "Main Diagram")
