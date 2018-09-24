CREATE FUNCTION userActiveSubjects (@userID INT)
RETURNS TABLE
AS
RETURN
	SELECT A.subject_id, A.subject_name, A.year, P.role FROM Active_Subjects AS A JOIN participant AS P
	ON A.subject_id = P.subject_subject_id
	WHERE P.users_user_id = @userID
GO 
SELECT * FROM userActiveSubjects (2)

GO
CREATE FUNCTION userPoints (@userID INT, @subjectID INT)
RETURNS TABLE
AS
RETURN
	SELECT e.exercise_id, MAX(s.points_number) AS points_number FROM exercise AS E JOIN submit AS S
	ON e.exercise_id = s.exercise_exercise_id
	WHERE S.users_user_id = @userID AND E.subject_subject_id = @subjectID
	GROUP BY e.exercise_id  
GO
SELECT * FROM userPoints( 4, 3 )
GO
CREATE FUNCTION subjectRanking (@subjectID INT) 
RETURNS TABLE
AS
RETURN
	SELECT A.users_user_id, SUM(A.points_number) AS total_points_number FROM (
	SELECT S.users_user_id, E.exercise_id, MAX(s.points_number) AS points_number 
	FROM exercise AS E JOIN submit AS S
	ON e.exercise_id = s.exercise_exercise_id
	WHERE E.subject_subject_id = @subjectID
	GROUP BY S.users_user_id, E.exercise_id ) AS A  
	GROUP BY A.users_user_id
GO
SELECT * FROM exercise WHERE subject_subject_id = 3
SELECT * FROM subjectRanking (3)
ORDER BY total_points_number DESC
GO
CREATE FUNCTION getPolynomialCoeffs(@id int)
RETURNS @rtnTable TABLE(
	id INT NOT NULL,
	coeff INT NOT NULL
)
AS
BEGIN
	DECLARE @degree INT = (SELECT coefficients.value('(/polynomial/degree)[1]','integer') FROM decrease_function WHERE function_id = @id)
	DECLARE @i INT = 1
	WHILE @i <= @degree + 1
	BEGIN
		--INSERT INTO @rtnTable SELECT coefficients.value('(/polynomial/coeff)['+CAST(@i AS VARCHAR(2))+']','integer') FROM decrease_function WHERE function_id = @id
		INSERT INTO @rtnTable SELECT @i-1, coefficients.value('(/polynomial/coeff)[sql:variable("@i")][1]','integer') FROM decrease_function WHERE function_id = @id
		SET @i = @i + 1;
	END
	RETURN
END

GO
CREATE FUNCTION countPolynomialVal (@coeffs tableCoeffs READONLY, @x FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @val FLOAT = 0
	DECLARE @degree INT = (SELECT MAX(id) FROM @coeffs)
	DECLARE @i INT = @degree
	WHILE @i >= 0
	BEGIN
		SET @val = @val * @x + (SELECT coeff FROM @coeffs WHERE id = @i)
		SET @i = @i - 1
	END
	RETURN @val
END
GO


CREATE TYPE tableCoeffs AS TABLE (
	id INT NOT NULL,
	coeff INT NOT NULL
)
GO


CREATE FUNCTION countPolynomialValById( @id INT, @x FLOAT )
RETURNS FLOAT
AS
BEGIN
	DECLARE @coeffs tableCoeffs
	INSERT INTO @coeffs SELECT id, coeff FROM getPolynomialCoeffs( @id )
	RETURN dbo.countPolynomialVal ( @coeffs, @x )
END
GO
PRINT dbo.countPolynomialValById ( 1, 0.25 )
GO


CREATE FUNCTION userLogin(@userId INT, @password VARCHAR(20)) --pamiêtaj, ¿eby przy deklarowaniu zmiennej varchar deklarowaæ rozmiar, bo domyœlnie jest 1 w tym siele szatana
RETURNS BIT
AS
BEGIN
	IF EXISTS (SELECT password FROM users WHERE user_id = @userId)
		BEGIN
		IF (SELECT password FROM users WHERE user_id = @userId) = CONVERT(VARCHAR,HASHBYTES('SHA',@password),2)
			RETURN 1
		END
	RETURN 0
END
GO
--Przyk³ad jak wypisywaæ - cholera jasna, spêdzi³em 30 minut nad tym, ¿eby dojœæ do tego, ¿e do wywo³ania funkcji trzeba dopisaæ dbo. - grrrrrrrrr...
IF (SELECT password FROM users WHERE user_id = 1) = CONVERT(VARCHAR,HASHBYTES('SHA','wonsyomom12'),2)
	PRINT 'Zgodne'
PRINT dbo.userLogin(1,'wonsyomom12')
PRINT dbo.userLogin(1,'qwerty1234')
GO

CREATE FUNCTION showTopic (@questionId INT)
RETURNS TABLE
AS
	RETURN
	SELECT 'q' AS type, question_id AS id, question_data AS date, question_essence AS text, users_user_id, U.login_name
	FROM questions AS Q JOIN users AS U ON Q.users_user_id=U.user_id 
	WHERE question_id = @questionId
	UNION ALL
	SELECT 'r', reply_id, reply_date, reply_essence, users_user_id, U.login_name
	FROM reply AS R JOIN users AS U ON R.users_user_id=U.user_id 
	WHERE questions_question_id = @questionId
GO

SELECT * FROM showTopic (1)
GO

-- Karol tutaj zacz¹³ pisaæ :)

GO
CREATE FUNCTION userEndSubjects (@userID INT)  --zakoñczone przedmioty u¿ytkownika
RETURNS TABLE 
AS
RETURN 
	SELECT P.* FROM subject AS S join participant AS P
	ON S.subject_id = P.subject_subject_id
	WHERE P.users_user_id = @userID AND NOT EXISTS (SELECT A.subject_id FROM Active_Subjects A WHERE A.subject_id = S.subject_id)
GO

SELECT * FROM userEndSubjects(11)


GO
CREATE FUNCTION subjectExercises (@subjectID INT)
RETURNS TABLE
AS
RETURN
	SELECT E.* FROM Exercises E WHERE E.SubjectID = @subjectID
GO

SELECT * FROM subjectExercises(2)


GO
CREATE FUNCTION submitNumber (@exerciseID INT, @userID INT)
RETURNS INT
AS
BEGIN
	IF EXISTS (SELECT COUNT(S.users_user_id) AS SubmitCount FROM  submit S WHERE S.exercise_exercise_id = @exerciseID AND S.users_user_id = @userID GROUP BY S.exercise_exercise_id)
		BEGIN
		IF ((SELECT COUNT(S.users_user_id) AS SubmitCount FROM  submit S WHERE S.exercise_exercise_id = @exerciseID AND S.users_user_id = @userID GROUP BY S.exercise_exercise_id) != 0)
			 RETURN (SELECT COUNT(S.users_user_id) AS SubmitCount FROM  submit S WHERE S.exercise_exercise_id = @exerciseID AND S.users_user_id = @userID GROUP BY S.exercise_exercise_id)
		END
	RETURN 0 
END
GO

SELECT dbo.submitNumber(1, 4)



