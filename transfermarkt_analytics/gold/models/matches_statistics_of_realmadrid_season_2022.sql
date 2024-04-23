with matches_competition as (
	select
		game_id
		, season 
		, date
		, home_club_name  
		, away_club_name 
		, home_club_goals 
		, away_club_goals
		, name
		, CASE
	     	WHEN home_club_goals > away_club_goals THEN 3
			WHEN home_club_goals < away_club_goals THEN 0
	        ELSE 1
	     END AS home_club_points,
	     CASE
	        WHEN away_club_goals > home_club_goals THEN 3
		    WHEN away_club_goals < home_club_goals THEN 0
	        ELSE 1
	     END AS away_club_points,
	     CASE WHEN home_club_id = 418 THEN 1 ELSE 0 END as sum_home_points,
	     CASE WHEN away_club_id = 418 THEN 1 ELSE 0 END as sum_away_points
	from {{ source("bronze", "raw_games")}} gd 
	join {{ source("bronze", "raw_competitions")}} cd 
	on gd.competition_id = cd.competition_id
	where home_club_id = 418 or away_club_id = 418
),
aggregated as (
    SELECT
        matches_competition.name,
        matches_competition.season,
        if ((sum_home_points * home_club_points + sum_away_points * away_club_points) = 3, 1, 0) as win,
        if ((sum_home_points * home_club_points + sum_away_points * away_club_points) = 0, 1, 0) as lost,
        if ((sum_home_points * home_club_points + sum_away_points * away_club_points) = 1, 1, 0) as draw
    FROM matches_competition
	where matches_competition.season = 2022 
),
total_match as (
	SELECT 
		name,
        sum(aggregated.win) as total_win,
        sum(aggregated.lost) as total_lost,
        sum(aggregated.draw) as total_draw
    FROM aggregated   
    GROUP BY aggregated.name, aggregated.win, aggregated.lost, aggregated.draw
),
final as (
	select 
		total_match.name,
		sum(total_match.total_win) as win,
		sum(total_match.total_lost) as lost,
		sum(total_match.total_draw) as draw
	from total_match 
	group by total_match.name
)
select * from final