USE BACA
GO

CREATE TABLE decrease_function (
    function_id     NUMERIC(7) IDENTITY(1,1) NOT NULL,
    fuction_name    VARCHAR(40) NOT NULL,
    coefficients    xml NOT NULL,
    users_user_id   NUMERIC(7) NOT NULL,
    degree          INTEGER NOT NULL
)

ALTER TABLE Decrease_Function ADD constraint decrease_function_pk PRIMARY KEY CLUSTERED (function_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE exercise (
    exercise_id                         NUMERIC(7) IDENTITY(1,1) NOT NULL,
    users_user_id                       NUMERIC(7) NOT NULL,
    subject_subject_id                  NUMERIC(7) NOT NULL,
    exercise_essence                    text NOT NULL,
    start_date                          datetime NOT NULL,
    end_date                            datetime NOT NULL,
    last_date                           datetime NOT NULL,
    "memory_limit(MB)"                  INTEGER,
    programming_languages_language_id   NUMERIC(7) NOT NULL,
    decrease_function_function_id       NUMERIC(7) NOT NULL
)

ALTER TABLE Exercise ADD constraint exercise_pk PRIMARY KEY CLUSTERED (exercise_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE logs (
    login_id        NUMERIC(7) IDENTITY(1,1) NOT NULL,
    login_date      datetime NOT NULL,
    country         VARCHAR(20),
    ip              VARCHAR(20),
    users_user_id   NUMERIC(7) NOT NULL
)

ALTER TABLE Logs ADD constraint logs_pk PRIMARY KEY CLUSTERED (login_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE messages (
    message_id           NUMERIC(7) IDENTITY(1,1) NOT NULL,
    message_essence      text NOT NULL,
    subject_subject_id   NUMERIC(7) NOT NULL,
    message_date         datetime NOT NULL,
    users_user_id        NUMERIC(7) NOT NULL
)

ALTER TABLE Messages ADD constraint messages_pk PRIMARY KEY CLUSTERED (message_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE participant (
    subject_subject_id   NUMERIC(7) NOT NULL,
    users_user_id        NUMERIC(7) NOT NULL,
    role                 VARCHAR(18) NOT NULL,
    is_active            bit NOT NULL
)

ALTER TABLE Participant ADD constraint participant_pk PRIMARY KEY CLUSTERED (Users_user_id, Subject_subject_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE programming_languages (
    language_id       NUMERIC(7) IDENTITY(1,1) NOT NULL,
    language_name     VARCHAR(30) NOT NULL,
    version           bigint NOT NULL,
                      system_commands   text
)

ALTER TABLE Programming_Languages ADD constraint programming_languages_pk PRIMARY KEY CLUSTERED (language_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE questions (
    question_id            NUMERIC(7) IDENTITY(1,1) NOT NULL,
    question_essence       text NOT NULL,
    question_date          datetime NOT NULL,
    exercise_exercise_id   NUMERIC(7) NOT NULL,
    users_user_id          NUMERIC(7) NOT NULL
)

ALTER TABLE Questions ADD constraint questions_pk PRIMARY KEY CLUSTERED (question_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE reply (
    reply_id                NUMERIC(7) IDENTITY(1,1) NOT NULL,
    reply_essence           text NOT NULL,
    reply_date              datetime NOT NULL,
    questions_question_id   NUMERIC(7) NOT NULL,
    users_user_id           NUMERIC(7) NOT NULL
)

ALTER TABLE Reply ADD constraint reply_pk PRIMARY KEY CLUSTERED (reply_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE status (
    status_id     NUMERIC(7) IDENTITY(1,1) NOT NULL,
    status_name   VARCHAR(30) NOT NULL,
    is_pass       bit NOT NULL
)


ALTER TABLE Status ADD constraint status_pk PRIMARY KEY CLUSTERED (status_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE subject (
    subject_id     NUMERIC(7) IDENTITY(1,1) NOT NULL,
    subject_name   VARCHAR(40) NOT NULL,
    year           INTEGER NOT NULL
)


ALTER TABLE Subject ADD constraint subject_pk PRIMARY KEY CLUSTERED (subject_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE submit (
    submit_id              NUMERIC(7) IDENTITY(1,1) NOT NULL,
    send_date              datetime NOT NULL,
    program_code           text,
    users_user_id          NUMERIC(7) NOT NULL,
    exercise_exercise_id   NUMERIC(7) NOT NULL,
    points_number          INTEGER NOT NULL
)


ALTER TABLE Submit ADD constraint submit_pk PRIMARY KEY CLUSTERED (submit_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE submit_details (
    status_status_id   NUMERIC(7) NOT NULL,
    tests_test_id      NUMERIC(7) NOT NULL,
    user_output        text NOT NULL,
    submit_submit_id   NUMERIC(7) NOT NULL
)


ALTER TABLE Submit_Details ADD constraint submit_details_pk PRIMARY KEY CLUSTERED (Tests_test_id, Status_status_id, Submit_submit_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE tests (
    test_id                NUMERIC(7) IDENTITY(1,1) NOT NULL,
    input                  text NOT NULL,
    output                 text NOT NULL,
    "time_execution(ms)"   INTEGER NOT NULL,
    exercise_exercise_id   NUMERIC(7) NOT NULL,
    points_number          INTEGER NOT NULL
)


ALTER TABLE Tests ADD constraint tests_pk PRIMARY KEY CLUSTERED (test_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE tips (
    tips_id                NUMERIC(7) IDENTITY(1,1) NOT NULL,
    tips_essence           text NOT NULL,
    display_date           datetime NOT NULL,
    exercise_exercise_id   NUMERIC(7) NOT NULL
)


ALTER TABLE Tips ADD constraint tips_pk PRIMARY KEY CLUSTERED (tips_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

	 USE BACA
	 GO
CREATE TABLE users

(
    user_id   NUMERIC(7) IDENTITY(1,1) NOT NULL,
    name      nvarchar (20) NOT NULL , 
     surname NVARCHAR (20) NOT NULL , 
     login_name VARCHAR (20) NOT NULL , 
     password VARCHAR (30) NOT NULL , 
     is_admin BIT NOT NULL , 
     is_active BIT NOT NULL , 
     register_date DATETIME NOT NULL 
    )

ALTER TABLE users ALTER COLUMN password VARCHAR(30) NOT NULL

ALTER TABLE Users ADD constraint users_pk PRIMARY KEY CLUSTERED (user_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


ALTER TABLE Decrease_Function
    ADD CONSTRAINT decrease_function_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Exercise
    ADD CONSTRAINT exercise_decrease_function_fk FOREIGN KEY ( decrease_function_function_id )
        REFERENCES decrease_function ( function_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Exercise
    ADD CONSTRAINT exercise_programming_languages_fk FOREIGN KEY ( programming_languages_language_id )
        REFERENCES programming_languages ( language_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Exercise
    ADD CONSTRAINT exercise_subject_fk FOREIGN KEY ( subject_subject_id )
        REFERENCES subject ( subject_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Exercise
    ADD CONSTRAINT exercise_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Logs
    ADD CONSTRAINT logs_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Messages
    ADD CONSTRAINT messages_subject_fk FOREIGN KEY ( subject_subject_id )
        REFERENCES subject ( subject_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Messages
    ADD CONSTRAINT messages_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Participant
    ADD CONSTRAINT participant_subject_fk FOREIGN KEY ( subject_subject_id )
        REFERENCES subject ( subject_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Participant
    ADD CONSTRAINT participant_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Questions
    ADD CONSTRAINT questions_exercise_fk FOREIGN KEY ( exercise_exercise_id )
        REFERENCES exercise ( exercise_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Questions
    ADD CONSTRAINT questions_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Reply
    ADD CONSTRAINT reply_questions_fk FOREIGN KEY ( questions_question_id )
        REFERENCES questions ( question_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Reply
    ADD CONSTRAINT reply_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Submit_Details
    ADD CONSTRAINT submit_details_status_fk FOREIGN KEY ( status_status_id )
        REFERENCES status ( status_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Submit_Details
    ADD CONSTRAINT submit_details_submit_fk FOREIGN KEY ( submit_submit_id )
        REFERENCES submit ( submit_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Submit_Details
    ADD CONSTRAINT submit_details_tests_fk FOREIGN KEY ( tests_test_id )
        REFERENCES tests ( test_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Submit
    ADD CONSTRAINT submit_exercise_fk FOREIGN KEY ( exercise_exercise_id )
        REFERENCES exercise ( exercise_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Submit
    ADD CONSTRAINT submit_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Tests
    ADD CONSTRAINT tests_exercise_fk FOREIGN KEY ( exercise_exercise_id )
        REFERENCES exercise ( exercise_id )
ON DELETE NO ACTION 
    ON UPDATE no action 

ALTER TABLE Tips
    ADD CONSTRAINT tips_exercise_fk FOREIGN KEY ( exercise_exercise_id )
        REFERENCES exercise ( exercise_id )
ON DELETE NO ACTION 
    ON UPDATE no action 



