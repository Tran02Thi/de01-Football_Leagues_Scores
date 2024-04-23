{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key='game_event_id'
    )
}}


SELECT 
    game_event_id
    , date 
    , game_id 
    , minute 
    , type 
    , club_id 
    , player_id 
    , description 
    , player_in_id 
    , player_assist_id 
FROM de_mysql.leagues_scorers.game_events