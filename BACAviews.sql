USE BACA 
GO
CREATE VIEW Admins
AS
SELECT * FROM users
WHERE is_admin = 1 AND is_active = 1
GO

SELECT * FROM Admins
GO

CREATE VIEW ActiveSubjects
AS
SELECT * FROM subject AS S
WHERE GETDATE() BETWEEN DATEFROMPARTS(S.year,10,1) AND DATEFROMPARTS(S.year+1,9,15)
GO


CREATE VIEW Exercises
AS
SELECT E.exercise_id,
(SELECT U.login_name  FROM users U WHERE U.user_id = E.users_user_id) Author,
(SELECT S.subject_name FROM subject S WHERE S.subject_id = E.subject_subject_id ) Subject,
(SELECT P.language_name FROM programming_languages P WHERE P.language_id = E.programming_languages_language_id) Language,
(SELECT SUM(points_number) FROM tests T WHERE T.exercise_exercise_id = E.exercise_id) Points
FROM exercise E
GO
SELECT * FROM Exercises

GO 
CREATE VIEW Exercise_Points_Average
AS
SELECT
(SELECT  B.subject_name
FROM (SELECT E.subject_subject_id, E.exercise_id, subject.subject_name FROM exercise E
LEFT JOIN subject ON
E.subject_subject_id = subject.subject_id) AS B
WHERE B.exercise_id = A.exercise_exercise_id) AS Subject_Name,
A.exercise_exercise_id,
ROUND ( AVG ( CAST(A.points_number as float)),2) AS Average
FROM ( SELECT S.users_user_id, S.exercise_exercise_id, MAX(S.points_number) points_number
FROM submit S
GROUP BY S.exercise_exercise_id, S.users_user_id ) AS A
GROUP BY A.exercise_exercise_id
GO
SELECT * FROM Exercise_Points_Average

GO 
CREATE VIEW Last_Logs
AS
SELECT L.users_user_id,
(SELECT U.login_name FROM users U WHERE U.user_id = L.users_user_id) AS Login,
MAX(L.login_date) AS Date
FROM logs L
GROUP BY L.users_user_id
GO
SELECT * FROM Last_Logs