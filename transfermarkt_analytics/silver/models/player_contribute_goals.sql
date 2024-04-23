{{
    config(
        materialized='incremental'
    )
}}
select 
    a.player_name
    , a.goals
    , a.player_club_id
    , a.player_current_club_id
    , g.season
from {{ source("bronze", "raw_appearances") }} a 
join {{ source("bronze", "raw_players") }} p 
on a.player_id = p.player_id 
join {{ source("bronze", "raw_games") }} g
on g.game_id = a.game_id
where (a.goals >= 1)