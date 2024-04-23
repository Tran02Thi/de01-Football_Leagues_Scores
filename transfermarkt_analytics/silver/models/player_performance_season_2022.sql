{{
    config(
        materialized='incremental'
    )
}}
select 
    a.player_name
    , a.goals
    , a.assists
    , a.player_club_id
    , a.player_current_club_id
    , a.minutes_played
    , p.market_value_in_eur 
from {{ source("bronze", "raw_appearances") }} a 
join {{ source("bronze", "raw_players") }} p  
on a.player_id = p.player_id 
join {{ source("bronze", "raw_games") }} g
on g.game_id = a.game_id
where p.last_season >= 2022 and g.season = 2022