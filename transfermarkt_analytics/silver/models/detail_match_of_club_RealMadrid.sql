{{
    config(
        materialized='incremental'
    )
}}
select *
from {{ source("bronze", "raw_games") }} g
where g.home_club_id = 418 or g.away_club_id = 418
order by g.date asc