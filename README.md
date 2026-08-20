# 📊 Human Resources Workforce Analytics & Attrition Dashboard

An end-to-end Human Resources (HR) Data Analytics solution utilizing **PostgreSQL** for database management and relational querying, and **Power BI** for interactive data modeling, DAX measure creation, and visual reporting.

---

## 🛠️ Tech Stack & Tools
* **Database Management**: PostgreSQL / MySQL
* **Business Intelligence & Visualization**: Power BI Desktop
* **Data Modeling & Analytics**: Power Query (M), Data Analysis Expressions (DAX), SQL
* **Data Source**: `Human_Resources.csv`

---

## 📌 1. Problem Statement
Human Resource managers and corporate leaders frequently struggle to maintain real-time visibility into workforce dynamics, diversity metrics, and retention patterns. Without a centralized analytics platform, organizations encounter major operational hurdles:
* **High Employee Turnover**: Inability to isolate specific departments, job titles, or tenures experiencing disproportionate attrition.
* **Lack of Diversity Visibility**: Difficulty tracking gender, racial, and ethnic distribution across roles and business units.
* **Geographic & Work-Mode Disconnect**: Challenges in managing and assessing performance metrics across remote workers versus headquarter-based staff.
* **Predictive Growth Planning**: Inability to measure historical hiring trends, yearly terminations, and net workforce expansion over time.

---

## 📁 2. Dataset Architecture & Data Cleansing

### Dataset Overview (`Human_Resources.csv`)
The dataset contains transactional HR employee records including demographic traits, employment histories, and termination dates.

| Column Name | SQL Type | Power BI Type | Description |
| :--- | :--- | :--- | :--- |
| `id` | `TEXT` | Text | Unique Identifier for each employee |
| `first_name` | `TEXT` | Text | Employee First Name |
| `last_name` | `TEXT` | Text | Employee Last Name |
| `birthdate` | `DATE` | Date | Employee Date of Birth |
| `gender` | `TEXT` | Text | Gender Identity |
| `race` | `TEXT` | Text | Racial/Ethnic Background |
| `department` | `TEXT` | Text | Assigned Department |
| `jobtitle` | `TEXT` | Text | Specific Job Role/Title |
| `location` | `TEXT` | Text | Work Mode (`Headquarters` / `Remote`) |
| `hire_date` | `DATE` | Date | Official Hire Date |
| `termdate` | `TEXT` / `DATE` | Date / DateTime | Termination Date (`NULL` / blank if active) |
| `location_city` | `TEXT` | Text | Office City |
| `location_state` | `TEXT` | Text | Office State |

### Data Preprocessing & Cleaning Steps:
1. **Date Format Normalization**: Standardized mixed-delimiter date strings (slashes `/` vs. hyphens `-`, 2-digit vs 4-digit years, and UTC timestamps) in `birthdate`, `hire_date`, and `termdate` into uniform `YYYY-MM-DD` date objects.
2. **Handling Active Status**: Filtered and flagged active employees vs. departed employees using `termdate IS NULL` logic.

---

## 🛢️ 3. SQL Database Analysis (`PostgreSQL Project - HR.sql`)

The PostgreSQL database script creates the table structure and executes key relational queries to answer core business questions:

### Table Creation Schema
```sql
CREATE TABLE human_resources (
    id TEXT,
    first_name TEXT,
    last_name TEXT,
    birthdate DATE,
    gender TEXT,
    race TEXT,
    department TEXT,
    jobtitle TEXT,
    location TEXT,
    hire_date DATE,
    termdate TEXT,
    location_city TEXT,
    location_state TEXT
);
