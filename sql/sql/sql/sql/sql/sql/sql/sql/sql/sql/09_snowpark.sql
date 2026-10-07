-- MetroPulse360
-- 09 - Snowpark Python
-- Station-level demand analysis

USE DATABASE METRO_DB;
USE SCHEMA ANALYTICS;
USE WAREHOUSE METRO_WH;

CREATE OR REPLACE PROCEDURE CALCULATE_STATION_DEMAND()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.10'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'main'
AS
$$
from snowflake.snowpark import Session
from snowflake.snowpark.functions import col, count

def main(session: Session):

    trips = session.table("METRO_DB.DW.FACT_TRIPS")

    station_demand = (
        trips
        .group_by(col("ENTRY_STATION_ID"))
        .agg(
            count("*").alias("TOTAL_TRIPS")
        )
        .sort(col("TOTAL_TRIPS").desc())
    )

    station_demand.write.mode("overwrite").save_as_table(
        "METRO_DB.ANALYTICS.STATION_DEMAND_SNOWPARK"
    )

    return "Station demand analysis completed successfully."
$$;


-- Execute Snowpark procedure

CALL CALCULATE_STATION_DEMAND();


-- View results

SELECT *
FROM STATION_DEMAND_SNOWPARK
ORDER BY TOTAL_TRIPS DESC;
