USE BACA
GO
--Ten fragment czysci wszystkie tabele z danych
EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'DELETE FROM ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
GO

DBCC CHECKIDENT('users', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('exercise', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('logs', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('messages', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('programming_languages', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('questions', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('reply', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('status', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('subject', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('submit', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('tests', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('tips', RESEED, 0)   --resetuje identity na podan¹ wartoœæ
DBCC CHECKIDENT('decrease_function', RESEED, 0)   --resetuje identity na podan¹ wartoœæ


INSERT INTO users 
(name, surname, login_name, password, is_admin, is_active, register_date)
VALUES
('Jacek', 'Placek', 'jacpla', 'wonsyomom12', 1, 1, GETDATE()),
('Stefan', 'Zaj¹c', 'stezaj', 'qwerty1234', 1, 1, GETDATE()),
('Ola', 'Nowak', 'olanow', 'kochamkrystiana12', 0, 1, GETDATE()),
('Stefan', 'Fyda', 'miszczBacy', 'asfafsafa213', 0, 1, GETDATE()),
('Kinga', 'Paw³owska', 'qui eeee', 'lottekeewqe', 0, 1, GETDATE()),
('Anna', 'Mucha', 'annmuc', 'zxcvbnm1234', 0, 0, GETDATE()),
('Martyna', 'Kowalska', 'szlachtaniepracuje', 'stefan123456', 0, 1, GETDATE()),
('Monika', 'Wilk', 'monique', 'admin123', 0, 1, GETDATE()),
('Andrzej', 'Nowak', 'endriu', 'coscoscos12', 0, 1, GETDATE()),
('£ucja', 'Monako', 'luckyluck', 'fortepian1578', 0, 1, GETDATE()),
('Antonina', 'Prusak', 'toska', 'lkjhgfdsa321', 0, 1, GETDATE())


INSERT INTO subject
(subject_name, year)
VALUES
('Systemy Operacyjne', 2016),
('Systemy Operacyjne', 2015),
('Programowanie 1', 2016),
('Programowanie 2', 2016),
('Programowanie 1', 2017),
('Metody Programowania', 2016)

INSERT INTO participant
(subject_subject_id, users_user_id, role, is_active)
VALUES
(1, 1, 'moderator', 1),
(2, 1, 'moderator', 1),
(3, 1, 'moderator', 1),
(4, 1, 'moderator', 1),
(5, 1, 'moderator', 1),
(6, 1, 'moderator', 1),
(3, 2, 'moderator', 1),
(5, 2, 'moderator', 1),
(2, 3, 'uczestnik', 1),
(2, 4, 'uczestnik', 1),
(4, 3, 'uczestnik', 1),
(4, 4, 'uczestnik', 1),
(1, 5, 'uczestnik', 1),
(1, 6, 'uczestnik', 1),
(1, 7, 'uczestnik', 1),
(1, 8, 'uczestnik', 1),
(1, 9, 'uczestnik', 1),
(1, 10, 'uczestnik', 1),
(1, 11, 'uczestnik', 1),
(3, 5, 'uczestnik', 1),
(3, 6, 'uczestnik', 1),
(3, 7, 'uczestnik', 1),
(3, 8, 'uczestnik', 1),
(3, 9, 'uczestnik', 1),
(3, 10, 'uczestnik', 1),
(3, 11, 'uczestnik', 1),
(6, 7, 'uczestnik', 1),
(6, 8, 'uczestnik', 1),
(6, 9, 'uczestnik', 1),
(6, 10, 'uczestnik', 1),
(6, 11, 'uczestnik', 1)



INSERT INTO messages
(message_essence, subject_subject_id, message_date, users_user_id)
VALUES
('Termin zadania zostal zwiekszony o trzy dni.', 1, GETDATE(), 1),
('Termin zadania zostal zwiekszony o trzy dni.', 2, GETDATE(), 1),
('Termin zadania zostal zwiekszony o trzy dni.', 3, GETDATE(), 1),
('Termin zadania zostal zwiekszony o trzy dni.', 4, GETDATE(), 1),
('Termin zadania zostal zwiekszony o trzy dni.', 5, GETDATE(), 1),
('Termin zadania zostal zwiekszony o trzy dni.', 3, GETDATE(), 2),
('Termin zadania zostal zwiekszony o trzy dni.', 5, GETDATE(), 2),
('Zakaz uzywania stosu i kolejki.', 5, GETDATE(), 2),
('W zadaniu pierwszym wkradl sie blad. Poprawna odpowiedz w tescie 1 to 123.1241.', 5, GETDATE(), 2),
('Podstawowym i kardynalnym obowiazkiem jest wyczyszczenie pamieci. Prosze pamietac o tym w zadaniu 3.', 3, GETDATE(), 1),
('W zadaniu 5 dodatkowo zabronione jest uzycie slowa int, a takze liter angielskiego alfabetu. Powodzenia.', 3, GETDATE(), 1),
('I tak nie zdacie!', 3, GETDATE(), 1)



INSERT INTO logs
(login_date, country, ip, users_user_id)
VALUES
(GETDATE(), 'Poland', '84.4.69.138', 1),
(GETDATE(), 'Poland', '84.4.69.138', 1),
(GETDATE(), 'Poland', '85.4.69.138', 2),
(GETDATE(), 'Poland', '86.4.69.138', 10),
(GETDATE(), 'Poland', '81.4.69.138', 11),
(GETDATE(), 'Poland', '84.5.54.138', 10)



INSERT INTO decrease_function
(fuction_name, coefficients, users_user_id, degree)
VALUES
('spadek1', '<polynomial><degree>3</degree><coeff>1</coeff><coeff>0</coeff><coeff>-3</coeff><coeff>2</coeff></polynomial>', 1, 3)-- ,
INSERT INTO decrease_function
(fuction_name, coefficients, users_user_id, degree)
VALUES
('spadek2', '<polynomial><degree>1</degree><coeff>1</coeff><coeff>-1</coeff></polynomial>', 2, 1)
INSERT INTO decrease_function
(fuction_name, coefficients, users_user_id, degree)
VALUES
('spadek3', '<polynomial><degree>3</degree><coeff>1</coeff><coeff>0</coeff><coeff>-3</coeff><coeff></coeff></polynomial>', 1, 3)-- ,

/*,

('spadek3', 'xml2', 2, 4),
('spadek4', 'xml3', 2, 5),
('spadek5', 'xml4', 2, 2),
('spadek6', 'xml5', 1, 2)
SELECT * FROM logs
*/


INSERT INTO programming_languages
(language_name, version, system_commands)
VALUES
('JAVA', 7, 'komenda1'),
('JAVA', 8, 'komenda1'),
('JAVA', 9, 'komenda1'),
('C++', 98, 'komenda2'),
('C++', 11, 'komenda2'),
('C++', 14, 'komenda'),
('BRAINFUCK', 1, NULL)


INSERT INTO exercise
(users_user_id, subject_subject_id, exercise_essence, start_date, end_date, last_date, [memory_limit(MB)], programming_languages_language_id, decrease_function_function_id)
VALUES
(2, 3, 'TrescZadania2', '2018-01-13 15:34:32.187', '2018-01-20 15:34:32.187', '2018-01-27 15:34:32.187', 30, 3, 1),
(2, 3, 'TrescZadania2', '2018-01-13 15:34:32.187', '2018-01-20 15:34:32.187', '2018-01-27 15:34:32.187', 30, 6, 1),
(2, 3, 'TrescZadania2', '2018-01-13 15:34:32.187', '2018-01-20 15:34:32.187', '2018-01-27 15:34:32.187', 30, 7, 1),
(2, 3, 'TrescZadania1', '2017-12-01 15:34:32.187', '2017-12-15 15:34:32.187', '2017-12-27 15:34:32.187', 30, 3, 2),
(2, 5, 'TrescZadania1', '2017-12-05 15:34:32.187', '2017-12-14 15:34:32.187', '2017-12-21 15:34:32.187', 30, 1, 2),
(1, 2, 'TrescZadania1', '2017-11-05 15:34:32.187', '2017-11-14 15:34:32.187', '2017-11-21 15:34:32.187', 30, 3, 2),
(1, 2, 'TrescZadania2', '2017-12-05 15:34:32.187', '2017-12-14 15:34:32.187', '2017-12-21 15:34:32.187', 30, 3, 2),
(1, 2, 'TrescZadania3', '2018-01-13 15:34:32.187', '2018-01-20 15:34:32.187', '2018-01-27 15:34:32.187', 30, 3, 2)
 
 
 INSERT INTO tips
 (tips_essence, display_date, exercise_exercise_id)
 VALUES
 ('Uzyj wasow!','2018-01-20 15:34:32.187' , 1),
 ('Uzyj wasow!','2018-01-20 15:34:32.187' , 2),
 ('Uzyj wasow!','2018-01-20 15:34:32.187' , 3),
 ('Cormen str.112','2018-01-20 15:34:32.187' , 6),
 ('Cormen str.1212','2018-01-20 15:34:32.187' , 7),
 ('Cormen str.456','2018-01-20 15:34:32.187' , 8)

 
 INSERT INTO questions
 (question_essence, question_date, exercise_exercise_id, users_user_id)
 VALUES
 ('tresc1', '2018-01-13 18:34:32.187', 1, 4)  ,
 ('tresc2', '2017-11-14 15:34:32.187', 6, 10),
 ('tresc3', '2017-11-14 20:34:32.187', 6, 11)



 INSERT INTO reply
 (reply_essence, reply_date, questions_question_id, users_user_id)
 VALUES
 ('tresc1', '2018-01-14 18:34:32.187', 1, 1),
 ('tresc2', '2018-01-14 20:34:32.187', 1, 4),
 ('tresc3', '2018-01-15 10:34:32.187', 1, 1),
 ('tresc4', '2017-11-16 15:34:32.187', 2, 1)




 INSERT INTO submit
 (send_date, program_code, users_user_id, exercise_exercise_id, points_number)
 VALUES
 ('2018-01-14 15:34:32.187','kod1', 4, 1, 0),
 ('2018-01-15 15:34:32.187','kod2', 4, 1, 2),
 ('2018-01-16 15:34:32.187','kod3', 4, 1, 5),
 ('2018-01-16 23:34:32.187','kod4', 4, 1, 10),
 ('2018-01-17 23:34:32.187','kod5', 7, 1, 10),
 ('2018-01-18 10:34:32.187','kod6', 8, 1, 10),
 ('2018-01-18 20:34:32.187','kod7', 9, 1, 10),
 ('2017-12-14 15:34:32.187','kod8', 4, 4, 0),
 ('2017-12-14 15:35:32.187','kod9', 6, 4, 0),
 ('2018-01-18 15:34:32.187','kod10', 7, 8, 1.1)
 USE BACA
 GO
 INSERT INTO submit
  (send_date, program_code, users_user_id, exercise_exercise_id, points_number)
 VALUES
 ('2018-01-16 23:34:32.187','kod4', 4, 2, 10) 

 INSERT INTO tests
 (input, output, [time_execution(ms)], exercise_exercise_id, points_number)
 VALUES
 ('input1','output1', 2, 1, 2),
 ('input2','output2', 3, 1, 2),
 ('input3','output3', 4, 1, 2),
 ('input4','output4', 5, 1, 2),
 ('input5','output5', 10, 1, 2),
 ('input1','output1', 20, 3, 5),
 ('input2','output2', 25, 3, 5),
 ('input1','output1', 500, 5, 5)




 INSERT INTO status
 (status_name, is_pass)
 VALUES
 ('blad kompilacji', 0),
 ('blad wykonania', 0),
 ('bledna odpowiedz', 0),
 ('przekroczony czas', 0),
 ('zaakceptowano', 1),
 ('rêcznie odrzucone',0)


 INSERT INTO submit_details
 (status_status_id, tests_test_id, user_output, submit_submit_id)
 VALUES
 (1, 1, 'output1', 1),
 (2, 2, 'output2', 1),
 (3, 3, 'output3', 1),
 (4, 4, 'output4', 1),
 (5, 5, 'output5', 1),
 (5, 5, 'output6', 2),
 (2, 2, 'output7', 3),
 (3, 6, 'output8', 3),
 (5, 5, 'output9', 4),
 (2, 7, 'output10', 5)

 /*
 --test na usuwanie admina z bazy
 SELECT * FROM users
 UPDATE users SET is_admin = 0 WHERE user_id = 2
 DELETE FROM users WHERE user_id = 1

 */
 