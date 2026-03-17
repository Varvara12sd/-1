USE PraktLabBD;
GO

INSERT INTO Positions (PositionID, Title, BaseSalary, Description) VALUES
(1, N'Менеджер', 25000.00, N'Керування'),
(2, N'Розробник', 30000.00, N'Код'),
(3, N'Тестувальник', 20000.00, N'QA'),
(4, N'Дизайнер', 22000.00, N'UI/UX'),
(5, N'Аналітик', 27000.00, N'Дані');
GO

INSERT INTO Allowances (AllowanceID, Name, DefaultAmount, AllowanceType, Description) VALUES
(1, N'Стаж', 1000, N'сума', N'За роки'),
(2, N'Бонус', 15, N'відсоток', N'KPI'),
(3, N'Премія', 5000, N'сума', N'Monthly'),
(4, N'Овертайм', 10, N'відсоток', N'Extra'),
(5, N'Мови', 2000, N'сума', N'English');
GO

DECLARE @i INT = 1;
DECLARE @FN NVARCHAR(50), @LN NVARCHAR(50), @SN NVARCHAR(50), @Str NVARCHAR(50);

DECLARE @FNames TABLE (ID INT IDENTITY, V NVARCHAR(50));
INSERT INTO @FNames VALUES (N'Олександр'),(N'Андрій'),(N'Дмитро'),(N'Сергій'),(N'Марія'),(N'Олена'),(N'Тетяна'),(N'Іван'),(N'Олег'),(N'Анна');
DECLARE @LNames TABLE (ID INT IDENTITY, V NVARCHAR(50));
INSERT INTO @LNames VALUES (N'Мельник'),(N'Шевченко'),(N'Коваленко'),(N'Бондаренко'),(N'Ткаченко'),(N'Кравченко'),(N'Олійник'),(N'Мороз'),(N'Павлюк'),(N'Кушнір');
DECLARE @SNames TABLE (ID INT IDENTITY, V NVARCHAR(50));
INSERT INTO @SNames VALUES (N'Іванович'),(N'Петрович'),(N'Олегович'),(N'Миколайович'),(N'Сергійович'),(N'Андріївна'),(N'Ігорівна'),(N'Василівна');
DECLARE @Streets TABLE (ID INT IDENTITY, V NVARCHAR(50));
INSERT INTO @Streets VALUES (N'Хрещатик'),(N'Соборна'),(N'Шевченка'),(N'Незалежності'),(N'Миру'),(N'Київська'),(N'Садова'),(N'Перемоги');

WHILE @i <= 1001
BEGIN
    SELECT @FN = V FROM @FNames WHERE ID = (ABS(CHECKSUM(NEWID())) % 10) + 1;
    SELECT @LN = V FROM @LNames WHERE ID = (ABS(CHECKSUM(NEWID())) % 10) + 1;
    SELECT @SN = V FROM @SNames WHERE ID = (ABS(CHECKSUM(NEWID())) % 8) + 1;
    SELECT @Str = V FROM @Streets WHERE ID = (ABS(CHECKSUM(NEWID())) % 8) + 1;

    INSERT INTO Employees (EmployeeID, Name, BirthDate, PositionID, Phone, Email, HireDate, Address)
    VALUES (
        @i,
        @LN + N' ' + @FN + N' ' + @SN,
        DATEADD(day, -(7300 + (ABS(CHECKSUM(NEWID())) % 10000)), GETDATE()),
        (ABS(CHECKSUM(NEWID())) % 5) + 1,
        '+380' + CAST(670000000 + @i AS VARCHAR(15)),
        'emp' + CAST(@i AS VARCHAR(10)) + '@company.ua',
        DATEADD(day, -(ABS(CHECKSUM(NEWID())) % 2000), GETDATE()),
        N'вул. ' + @Str + N', ' + CAST((ABS(CHECKSUM(NEWID())) % 200) + 1 AS NVARCHAR(5))
    );

    INSERT INTO EmployeeAllowances (AssignmentID, EmployeeID, AllowanceID, AssignedAmount, StartDate)
    VALUES (@i, @i, (ABS(CHECKSUM(NEWID())) % 5) + 1, 1000 + (ABS(CHECKSUM(NEWID())) % 2000), '2024-01-01');

    SET @i = @i + 1;
END;
GO

SELECT * FROM Employees;
GO
