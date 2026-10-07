# MetroPulse360 🚇

## Intelligent Metro Ridership, Operations & Disruption Analytics Platform

MetroPulse360 is an end-to-end data engineering and analytics project built using **Azure, Snowflake, Snowpark Python, SQL, and Power BI**.

The platform ingests metro trip data from Azure, processes it through Snowflake using automated and incremental data pipelines, applies data quality and deduplication logic, and provides business analytics through Power BI.

---

## 🏗️ Architecture

```text
Metro Data Sources
        │
        ▼
   Azure ADLS Gen2
        │
        ▼
Snowflake Storage Integration
        │
        ▼
     Snowpipe
        │
        ▼
     RAW Layer
        │
        ▼
  Streams + Tasks
        │
        ▼
   STAGING Layer
        │
        ▼
Data Quality & Deduplication
        │
        ▼
Data Warehouse / Star Schema
        │
        ├───────────────┐
        ▼               ▼
Dynamic Tables     Snowpark Python
        │               │
        └───────┬───────┘
                ▼
        Analytics Views
                │
                ▼
          Power BI
