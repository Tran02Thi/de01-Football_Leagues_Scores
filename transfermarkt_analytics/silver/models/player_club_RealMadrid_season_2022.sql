{{
    config(
        materialized='incremental'
    )
}}
select *
from {{ source("bronze", "raw_players") }} p 
where p.current_club_id = 418 and p.last_season >= 2022