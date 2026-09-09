-- 1. Заполнение ролей
INSERT INTO "РОЛИ" ("id_роли", "Название") VALUES 
(1, 'admin'),
(2, 'decan'),
(3, 'teacher'),
(4, 'student')
ON CONFLICT ("id_роли") DO NOTHING;

-- 2. Добавление тестовых пользователей
INSERT INTO "ПОЛЬЗОВАТЕЛИ" ("ник", "пароль", "id_роли") VALUES 
('admin', 'admin', 1),
('decan', 'decan', 2),
('teacher', 'teacher', 3),
('student', 'student', 4)
ON CONFLICT DO NOTHING;