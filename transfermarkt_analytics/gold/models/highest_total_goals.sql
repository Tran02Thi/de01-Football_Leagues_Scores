{{
    config(
        materialized='incremental'
    )
}}
select 
    g.player_name,
    sum(g.goals) as total_goals
from {{ source("silver", "player_contribute_goals") }} g
where (g.player_club_id = 418 and g.player_current_club_id = 418) and (g.season = 2022)
group by g.player_name
order by total_goals
