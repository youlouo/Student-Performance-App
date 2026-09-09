-- 1. Справочник ролей
CREATE TABLE "РОЛИ" (
    "id_роли" SERIAL PRIMARY KEY,
    "Название" VARCHAR(100) NOT NULL
);

-- 2. Пользователи
CREATE TABLE "ПОЛЬЗОВАТЕЛИ" (
    "id_пользователя" SERIAL PRIMARY KEY,
    "id_роли" INT NOT NULL REFERENCES "РОЛИ"("id_роли") ON DELETE RESTRICT,
    "ник" VARCHAR(50) NOT NULL UNIQUE,
    "пароль" VARCHAR(255) NOT NULL
);

-- 3. Журнал логов
CREATE TABLE "ЛОГИ" (
    "id_записи_лога" SERIAL PRIMARY KEY,
    "id_пользователя" INT NOT NULL REFERENCES "ПОЛЬЗОВАТЕЛИ"("id_пользователя") ON DELETE CASCADE,
    "действие" VARCHAR(255) NOT NULL,
    "название_сущности" VARCHAR(100),
    "время_действия" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 4. Преподаватели (связь 1:1 с пользователями)
CREATE TABLE "ПРЕПОДАВАТЕЛИ" (
    "id_преподавателя" SERIAL PRIMARY KEY,
    "id_пользователя" INT UNIQUE REFERENCES "ПОЛЬЗОВАТЕЛИ"("id_пользователя") ON DELETE SET NULL,
    "ФИО" VARCHAR(150) NOT NULL,
    "Институт" VARCHAR(150),
    "Должность" VARCHAR(100),
    "Ученая_степень" VARCHAR(100),
    "Контакты" VARCHAR(255)
);

-- 5. Учебные группы
CREATE TABLE "ГРУППЫ" (
    "id_группы" SERIAL PRIMARY KEY,
    "id_Куратора" INT REFERENCES "ПРЕПОДАВАТЕЛИ"("id_преподавателя") ON DELETE SET NULL,
    "Название" VARCHAR(50) NOT NULL,
    "Специальность" VARCHAR(150),
    "Курс" INT,
    "Форма_обучения" VARCHAR(50),
    "Год_набора" INT
);

-- 6. Студенты (связь 1:1 с пользователями)
CREATE TABLE "СТУДЕНТЫ" (
    "id_студента" SERIAL PRIMARY KEY,
    "id_группы" INT REFERENCES "ГРУППЫ"("id_группы") ON DELETE SET NULL,
    "id_пользователя" INT UNIQUE REFERENCES "ПОЛЬЗОВАТЕЛИ"("id_пользователя") ON DELETE SET NULL,
    "ФИО" VARCHAR(150) NOT NULL,
    "Дата_рождения" DATE,
    "Пол" VARCHAR(10),
    "Контакты" VARCHAR(255),
    "Форма_обучения" VARCHAR(50),
    "Дата_поступления" DATE,
    "Статус" VARCHAR(50)
);

-- 7. Дисциплины / Предметы
CREATE TABLE "ПРЕДМЕТЫ" (
    "id_предмета" SERIAL PRIMARY KEY,
    "Название" VARCHAR(150) NOT NULL,
    "описание" TEXT,
    "Часы_лекций" INT DEFAULT 0,
    "Часы_практик" INT DEFAULT 0,
    "Часы_лабораторных" INT DEFAULT 0,
    "Форма_контроля" VARCHAR(50)
);

-- 8. Поток (связующая таблица для группы, предмета и преподавателя)
CREATE TABLE "ПОТОК" (
    "id_потока" SERIAL PRIMARY KEY,
    "id_группы" INT NOT NULL REFERENCES "ГРУППЫ"("id_группы") ON DELETE CASCADE,
    "id_предмета" INT NOT NULL REFERENCES "ПРЕДМЕТЫ"("id_предмета") ON DELETE CASCADE,
    "id_преподавателя" INT REFERENCES "ПРЕПОДАВАТЕЛИ"("id_преподавателя") ON DELETE SET NULL,
    "Семестр" INT NOT NULL,
    "Учебный_год" VARCHAR(20) NOT NULL
);

-- 9. Оценки студентов
CREATE TABLE "ОЦЕНКИ" (
    "id_оценки" SERIAL PRIMARY KEY,
    "id_студента" INT NOT NULL REFERENCES "СТУДЕНТЫ"("id_студента") ON DELETE CASCADE,
    "id_потока" INT NOT NULL REFERENCES "ПОТОК"("id_потока") ON DELETE CASCADE,
    "Тип_оценки" VARCHAR(50),
    "Оценка" VARCHAR(20) NOT NULL,
    "Вес_оценки" NUMERIC(3,2),
    "Дата_выставления" DATE DEFAULT CURRENT_DATE
);

-- 10. Посещаемость занятий
CREATE TABLE "ПОСЕЩАЕМОСТЬ" (
    "id_посещаемости" SERIAL PRIMARY KEY,
    "id_студента" INT NOT NULL REFERENCES "СТУДЕНТЫ"("id_студента") ON DELETE CASCADE,
    "id_дисциплины_группы" INT NOT NULL REFERENCES "ПОТОК"("id_потока") ON DELETE CASCADE,
    "дата_занятия" DATE NOT NULL DEFAULT CURRENT_DATE,
    "статус" VARCHAR(50) NOT NULL
);