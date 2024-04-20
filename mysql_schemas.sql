DROP TABLE IF EXISTS competitions;
CREATE TABLE competitions (
    competition_id VARCHAR(155) NOT NULL,
    competition_code VARCHAR(155),
    name VARCHAR(155),
    sub_type VARCHAR(155),
    type VARCHAR(155),
    country_id INT,
    country_name VARCHAR(155),
    domestic_league_code VARCHAR(155),
    confederation VARCHAR(155),
    url text,
    is_major_national_league BOOLEAN,

	PRIMARY KEY (competition_id)
    );

DROP TABLE IF EXISTS games;
CREATE TABLE games (
    game_id INT NOT NULL,
    competition_id VARCHAR(155),
    season INT,
    round VARCHAR(155),
    date date,
    home_club_id INT,
    away_club_id INT,
    home_club_goals INT,
    away_club_goals INT,
    home_club_position INT,
    away_club_position INT,
    home_club_manager_name VARCHAR(155),
    away_club_manager_name VARCHAR(155),
    stadium VARCHAR(155),
    attendance INT,
    referee VARCHAR(155),
    url text,
    home_club_formation VARCHAR(155),
    away_club_formation VARCHAR(155),
    home_club_name VARCHAR(155),
    away_club_name VARCHAR(155),
    aggregate VARCHAR(155),
    competition_type VARCHAR(155),

    PRIMARY KEY (game_id),
	FOREIGN KEY (competition_id) REFERENCES competitions(competition_id)
    );

DROP TABLE IF EXISTS clubs;
CREATE TABLE clubs (
    club_id INT NOT NULL,
    club_code VARCHAR(155),
    name VARCHAR(155),
    domestic_competition_id VARCHAR(155),
    total_market_value DOUBLE,
    squad_size INT,
    average_age decimal(10,5),
    foreigners_number INT,
    foreigners_percentage decimal(10,5),
    national_team_players INT,
    stadium_name VARCHAR(155),
    stadium_seats INT,
    net_transfer_record VARCHAR(155),
    coach_name DOUBLE,
    last_season INT,
    filename VARCHAR(155),
    url text,

    PRIMARY KEY (club_id),
	FOREIGN KEY (domestic_competition_id) REFERENCES competitions(competition_id)
    );

DROP TABLE IF EXISTS club_games;
CREATE TABLE club_games (
    game_id INT NOT NULL,
    club_id INT NOT NULL,
    own_goals INT,
    own_position DOUBLE,
    own_manager_name VARCHAR(155),
    opponent_id INT,
    opponent_goals INT,
    opponent_position DOUBLE,
    opponent_manager_name VARCHAR(155),
    hosting VARCHAR(155),
    is_win INT,

    PRIMARY KEY (game_id, club_id),
	FOREIGN KEY (game_id) REFERENCES games(game_id),
	FOREIGN KEY (club_id) REFERENCES clubs(club_id)
    );

DROP TABLE IF EXISTS players;
CREATE TABLE players (
    player_id INT NOT NULL,
    first_name VARCHAR(155),
    last_name VARCHAR(155),
    name VARCHAR(155),
    last_season INT,
    current_club_id INT,
    player_code VARCHAR(155),
    country_of_birth VARCHAR(155),
    city_of_birth VARCHAR(155),
    country_of_citizenship VARCHAR(155),
    date_of_birth VARCHAR(155),
    sub_position VARCHAR(155),
    position VARCHAR(155),
    foot VARCHAR(155),
    height_in_cm DOUBLE,
    contract_expiration_date datetime,
    agent_name VARCHAR(155),
    image_url text,
    url text,
    current_club_domestic_competition_id VARCHAR(155),
    current_club_name VARCHAR(155),
    market_value_in_eur INT,
    highest_market_value_in_eur INT,

    PRIMARY KEY (player_id),
	FOREIGN KEY (current_club_id) REFERENCES clubs(club_id),
	FOREIGN KEY (current_club_domestic_competition_id ) REFERENCES competitions(competition_id)
    );

DROP TABLE IF EXISTS appearances;
CREATE TABLE appearances (
    appearance_id VARCHAR(155) NOT NULL,
    game_id INT,
    player_id INT,
    player_club_id INT,
    player_current_club_id INT,
    date date,            
    player_name VARCHAR(155),
    competition_id VARCHAR(155),
    yellow_cards INT,
    red_cards INT,
    goals INT,
    assists INT,
    minutes_played INT,

    PRIMARY KEY (appearance_id),
	FOREIGN KEY (game_id) REFERENCES games(game_id)
    );

DROP TABLE IF EXISTS player_valuations;
CREATE TABLE player_valuations (
    player_id INT NOT NULL,
    date date,
    market_value_in_eur INT,
    current_club_id INT,
    player_club_domestic_competition_id VARCHAR(155),

    PRIMARY KEY (player_id, date),
	FOREIGN KEY (player_id) REFERENCES players(player_id)
    );

DROP TABLE IF EXISTS game_events;
CREATE TABLE game_events (
    game_event_id VARCHAR(155) NOT NULL,
    date date,
    game_id INT,
    minute INT,
    type VARCHAR(155),
    club_id INT,
    player_id INT,
    description VARCHAR(155),
    player_in_id DOUBLE,
    player_assist_id DOUBLE,

    PRIMARY KEY (game_event_id),
	FOREIGN KEY (game_id) REFERENCES games(game_id),
	FOREIGN KEY (club_id) REFERENCES clubs(club_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id)
    );

