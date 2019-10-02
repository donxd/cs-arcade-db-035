/*Please add ; after each select statement*/
CREATE PROCEDURE soccerGameSeries()
BEGIN
    SELECT 
          SUM(IF(first_team_score > second_team_score, 1, 0))
        , SUM(IF(second_team_score > first_team_score, 1, 0))
    INTO
          @t1wins
        , @t2wins
    FROM scores;

    SELECT 
          SUM(first_team_score)
        , SUM(second_team_score)
    INTO
          @t1goals
        , @t2goals
    FROM scores;

    SELECT 
          SUM(IF(match_host = 2, first_team_score, 0))
        , SUM(IF(match_host = 1, second_team_score, 0))
    INTO 
          @t1diff
        , @t2diff
    FROM scores;

        SELECT 
            CASE 
                WHEN @t1wins > @t2wins THEN 1
                WHEN @t1wins < @t2wins THEN 2
                WHEN @t1goals > @t2goals THEN 1
                WHEN @t1goals < @t2goals THEN 2
                WHEN @t1diff > @t2diff THEN 1
                WHEN @t1diff < @t2diff THEN 2
                ELSE 0
            END as winner;
END