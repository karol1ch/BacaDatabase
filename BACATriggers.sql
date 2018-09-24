USE BACA
GO
CREATE TRIGGER Tr2 ON submit
INSTEAD OF INSERT
AS
	INSERT INTO submit 
	SELECT I.send_date, I.program_code, I.users_user_id, I.exercise_exercise_id, I.points_number FROM inserted AS I
	WHERE I.send_date >= (SELECT start_date FROM exercise WHERE exercise_id = I.exercise_exercise_id) 
	AND I.send_date <= (SELECT last_date FROM exercise WHERE exercise_id = I.exercise_exercise_id)
	
	IF EXISTS (SELECT * FROM inserted AS I
	WHERE I.send_date < (SELECT start_date FROM exercise WHERE exercise_id = I.exercise_exercise_id) 
	OR I.send_date > (SELECT last_date FROM exercise WHERE exercise_id = I.exercise_exercise_id))
		RAISERROR('Nie dodano submitu. Submit wys³ano poza dat¹ obowiazywania zadania',16,1)
GO

CREATE TRIGGER Tr4 ON questions
INSTEAD OF INSERT
AS
	INSERT INTO questions
	SELECT I.question_essence, I.question_date, I.exercise_exercise_id, I.users_user_id FROM inserted AS I
	WHERE I.question_date >= (SELECT start_date FROM exercise WHERE exercise_id = I.exercise_exercise_id) 
	AND I.question_date <= (SELECT last_date FROM exercise WHERE exercise_id = I.exercise_exercise_id)
	
	IF EXISTS (SELECT * FROM inserted AS I
	WHERE I.question_date < (SELECT start_date FROM exercise WHERE exercise_id = I.exercise_exercise_id) 
	OR I.question_date > (SELECT last_date FROM exercise WHERE exercise_id = I.exercise_exercise_id))
		RAISERROR('Nie dodano pytania. Pytanie wys³ano poza dat¹ obowiazywania zadania',16,1)
GO

CREATE TRIGGER Tr6 ON users
AFTER UPDATE
AS
	IF UPDATE(is_admin)
	BEGIN
		IF NOT EXISTS(SELECT * FROM users WHERE is_admin = 1 AND user_id NOT IN (SELECT user_id FROM deleted) )
		BEGIN
			RAISERROR('Nie mo¿na usun¹æ ostatniego administratora',16,1)
			ROLLBACK
		END 
	END
GO


CREATE TRIGGER Tr6a ON users
AFTER DELETE
AS
	IF NOT EXISTS (SELECT * FROM users WHERE is_admin = 1)
		BEGIN
			RAISERROR('Nie mo¿na usun¹æ ostatniego administratora',16,1)
			ROLLBACK
		END
GO

CREATE TRIGGER Tr8 ON users
INSTEAD OF INSERT
AS
	INSERT INTO users
	SELECT I.name, I.surname, I.login_name, CONVERT(VARCHAR,HASHBYTES('SHA',I.password),2), I.is_admin, I.is_active, GETDATE() FROM inserted AS I
GO

CREATE TRIGGER Tr10 ON decrease_function --todo: Dzia³a tylko przy dodawaniu pojedynczego wiersza. Mo¿e trzeba u¿yæ kursora
AFTER INSERT
AS
	DECLARE @id INT = (SELECT function_id FROM inserted)
	DECLARE @degree INT = (SELECT coefficients.value('(/polynomial/degree)[1]','integer') FROM inserted)
	DECLARE @i INT = 1
	WHILE @i <= @degree
	BEGIN
		IF EXISTS  (SELECT coefficients.value('(/polynomial/coeff)[sql:variable("@i")][1]','integer') FROM inserted)
			SET @i = @i + 1
		ELSE
		BEGIN
			SET @i = 0
			BREAK
		END
	END	
		IF (@i < @degree OR NOT dbo.countPolynomialValById ( @id, 0 ) = 1 OR NOT dbo.countPolynomialValById ( @id, 1 ) = 0 )
		BEGIN 
			RAISERROR('Nieprawidlowy wielomian!',16,1)
			ROLLBACK
		END
GO


GO
CREATE TRIGGER T1 ON tips  --wskazówka musi pojawiæ siê nie póŸniej ni¿ koniec zadania
INSTEAD OF INSERT
AS
	INSERT INTO tips
	SELECT I.tips_essence, I.display_date, I.exercise_exercise_id  FROM inserted AS I 
	WHERE I.display_date < (SELECT E.last_date FROM exercise AS E WHERE E.exercise_id = I.exercise_exercise_id)
	
	IF EXISTS ( SELECT * FROM inserted AS I 
	WHERE I.display_date >= (SELECT E.last_date FROM exercise AS E WHERE E.exercise_id = I.exercise_exercise_id))
		RAISERROR('Nie dodano wskazówki. Data wyœwietlenia wskzówki przekracza ostateczy termin zadania.', 16, 1)
GO


GO
CREATE TRIGGER T3 ON messages   --komunikat musi pojawiæ siê w terminie aktywnoœci przedmiotu
INSTEAD OF INSERT
AS
	INSERT INTO messages
	SELECT I.message_essence, I.subject_subject_id, I.message_date, I.users_user_id FROM inserted AS I
	JOIN subject S ON I.subject_subject_id = S.subject_id
	WHERE I.message_date BETWEEN DATEFROMPARTS(S.year,10,1) AND DATEFROMPARTS(S.year+1,9,15)
	
	IF EXISTS ( SELECT * FROM inserted AS I
	JOIN subject S ON I.subject_subject_id = S.subject_id
	WHERE  NOT(I.message_date BETWEEN DATEFROMPARTS(S.year,10,1) AND DATEFROMPARTS(S.year+1,9,15)))
		RAISERROR('Nie dodano komunikatu. Przedmiot nie jest aktywny.', 16, 1)
GO


CREATE TRIGGER T5 ON reply  --odpowiedŸ musi pojawiæ siê po zadaniu pytania i przed zakoñczeniem zadania 
INSTEAD OF INSERT
AS
	INSERT into reply
	SELECT I.reply_essence, I.reply_date, I.questions_question_id, I.users_user_id FROM inserted I
	WHERE I.reply_date > (SELECT Q.question_data FROM questions Q WHERE Q.question_id = I.questions_question_id)
	AND I.reply_date < (SELECT E.last_date FROM exercise E WHERE E.exercise_id = 
	(SELECT Q1.exercise_exercise_id FROM questions Q1 WHERE Q1.question_id = I.questions_question_id))

	IF EXISTS (SELECT * FROM inserted AS I
	WHERE I.reply_date <= (SELECT Q.question_data FROM questions Q WHERE Q.question_id = I.questions_question_id)
	OR I.reply_date >= (SELECT E.last_date FROM exercise E WHERE E.exercise_id = 
	(SELECT Q1.exercise_exercise_id FROM questions Q1 WHERE Q1.question_id = I.questions_question_id)))
		RAISERROR('Nie dodano odpowiedzi.Data odpowiedzi jest spoza zakresu.', 16, 1)
GO