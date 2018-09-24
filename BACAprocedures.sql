USE BACA
GO
CREATE PROCEDURE countPoints @submitId INT -- procedura uaktualniaj¹ca liczbê punktów danego submitu
AS
	DECLARE @exerciseId INT = (SELECT exercise_exercise_id FROM submit WHERE submit_id = @submitId)
	DECLARE @submitDate DATETIME = (SELECT send_date FROM submit WHERE submit_id = @submitId)
	DECLARE @endDate DATETIME = (SELECT end_date FROM exercise WHERE exercise_id = @exerciseId )
	DECLARE @lastDate DATETIME = (SELECT last_date FROM exercise WHERE exercise_id = @exerciseId )
	DECLARE @decreaseFunction INT = (SELECT decrease_function_function_id FROM exercise WHERE exercise_id = @exerciseId ) 
	DECLARE @timeRatio FLOAT = DATEDIFF(SECOND, @endDate, @submitDate) * 1.0 / DATEDIFF(SECOND, @endDate, @lastDate)
	IF ( @submitDate < @endDate )
		SET @timeRatio = 0
	UPDATE submit
	SET points_number = dbo.countPolynomialValById ( @decreaseFunction, @timeRatio ) * 
	( SELECT SUM(T.points_number) FROM tests AS T 
	JOIN submit_details AS S ON T.test_id = S.tests_test_id 
	JOIN status AS ST ON S.status_status_id = ST.status_id
	WHERE S.submit_submit_id = @submitId AND ST.is_pass = 1 )
	WHERE submit_id = @submitId
GO

EXEC countPoints 2

GO

CREATE PROCEDURE extendExerciseDate @exerciseId int, @timeH int
AS
	UPDATE exercise
	SET end_date = DATEADD(HOUR,@timeH,end_date), last_date = DATEADD(HOUR,@timeH,last_date)
GO

GO
CREATE PROCEDURE changePoints @submitID INT, @newPoints INT  -- zmiana iloœci punktów przez prowadz¹cego
AS 
	UPDATE submit 
	SET submit.points_number = @newPoints WHERE submit.submit_id = @submitID
GO

GO
CREATE PROCEDURE rejectSubmit @submitID INT  --rêczne odrzucenie submitu i zmiana punktów w tabeli submit
AS
	UPDATE submit_details
	SET submit_details.status_status_id = 6 WHERE submit_details.submit_submit_id = @submitID
	UPDATE submit
	SET submit.points_number = 0 WHERE submit.submit_id = @submitID
GO
