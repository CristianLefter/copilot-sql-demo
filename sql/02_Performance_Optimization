USE SalesDB;
GO

DROP TABLE IF EXISTS demoperf;
GO

CREATE TABLE demoperf(itemid int not null, itemname varchar(64) not null);
GO

DECLARE @i int = 1;

SET NOCOUNT ON;

WHILE @i < 1000
BEGIN
  INSERT INTO demoperf(itemid, itemname) VALUES (@i, 'item' + cast(@i as varchar(4));
  SET @i += 1;
END
GO


SELECT itemname FROM demoperf WHERE itemid = 700;
