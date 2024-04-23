{{
    config(
        materialized='incremental'
    )
}}
select
	g.player_name
	, sum(g.goals) as total_goal
	, sum(g.assists) as total_assist
	, sum(g.minutes_played) as total_minute_played
	, g.market_value_in_eur
from {{ source("silver", "player_performance_season_2022")}} g
where g.player_club_id = 418 and g.player_current_club_id = 418
group by g.player_name, g.market_value_in_eur
order by total_minute_played

