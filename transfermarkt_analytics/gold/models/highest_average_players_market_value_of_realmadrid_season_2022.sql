{{
    config(
        materialized='incremental'
    )
}}
select 
	p.player_id
	, p.name
	, ( p.highest_market_value_in_eur + p.market_value_in_eur ) / 2 as Highest_Average
from {{ source("silver", "player_club_RealMadrid_season_2022") }} p
order by Highest_Average asc

