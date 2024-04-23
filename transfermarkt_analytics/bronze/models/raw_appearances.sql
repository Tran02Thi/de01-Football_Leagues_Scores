{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key="appearance_id"
    )
}}

SELECT 
    appearance_id
    , game_id
    , player_id
    , player_club_id
    , player_current_club_id
    , date
    , player_name
    , competition_id
    , yellow_cards
    , red_cards
    , goals
    , assists
    , minutes_played
FROM de_mysql.leagues_scorers.appearances