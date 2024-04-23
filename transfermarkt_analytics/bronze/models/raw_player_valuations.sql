{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key=['player_id','date']
    )
}}


SELECT 
    player_id
    , date 
    , market_value_in_eur 
    , current_club_id 
    , player_club_domestic_competition_id 
FROM de_mysql.leagues_scorers.player_valuations