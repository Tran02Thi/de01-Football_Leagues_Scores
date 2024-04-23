{{
    config(
        materialized='incremental'
    )
}}
select 
    g.player_name,
    sum(g.assists) as total_assists
from {{ source("silver", "player_contribute_assists") }} g
where (g.player_club_id = 418 and g.player_current_club_id = 418) and (g.season = 2022)
group by g.player_name
order by total_assists
