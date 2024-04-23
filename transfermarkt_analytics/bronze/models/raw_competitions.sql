{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key='competition_id'
    )
}}


SELECT 
    competition_id
    , competition_code 
    , name 
    , sub_type 
    , type 
    , country_id 
    , country_name 
    , domestic_league_code 
    , confederation 
    , url 
    , is_major_national_league 
FROM de_mysql.leagues_scorers.competitions