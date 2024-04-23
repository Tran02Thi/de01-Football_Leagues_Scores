{{
    config(
        materialized='incremental'
    )
}}
select 
    *
    ,   CASE 
            WHEN dmor.home_club_id = 418 THEN dmor.home_club_position
            ELSE dmor.away_club_position 
        END as position
from {{ source("silver", "detail_match_of_club_RealMadrid") }} dmor
where dmor.competition_id = 'ES1' and dmor.season = 2022

