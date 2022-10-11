
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/11/2022 22:24:55
-- Generated from EDMX file: D:\WorkSpace\Learning\ReposGithub\CSharp-MVC\EFDemo01\Demo02 ModelFirst\Model1stModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Model1stDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_StudentStudentBookOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentBookOrderSet] DROP CONSTRAINT [FK_StudentStudentBookOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_StudentBookOrderBook_StudentBookOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentBookOrderBook] DROP CONSTRAINT [FK_StudentBookOrderBook_StudentBookOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_StudentBookOrderBook_Book]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentBookOrderBook] DROP CONSTRAINT [FK_StudentBookOrderBook_Book];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[StudentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentSet];
GO
IF OBJECT_ID(N'[dbo].[BookSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BookSet];
GO
IF OBJECT_ID(N'[dbo].[StudentBookOrderSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentBookOrderSet];
GO
IF OBJECT_ID(N'[dbo].[StudentBookOrderBook]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentBookOrderBook];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'StudentSet'
CREATE TABLE [dbo].[StudentSet] (
    [No] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [Age] smallint  NULL
);
GO

-- Creating table 'BookSet'
CREATE TABLE [dbo].[BookSet] (
    [Id] uniqueidentifier  NOT NULL,
    [BookName] nvarchar(30)  NULL,
    [Price] decimal(4,0)  NOT NULL
);
GO

-- Creating table 'StudentBookOrderSet'
CREATE TABLE [dbo].[StudentBookOrderSet] (
    [Id] uniqueidentifier  NOT NULL,
    [Amount] decimal(4,0)  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [StudentNo] int  NOT NULL
);
GO

-- Creating table 'StudentBookOrderBook'
CREATE TABLE [dbo].[StudentBookOrderBook] (
    [StudentBookOrder_Id] uniqueidentifier  NOT NULL,
    [Book_Id] uniqueidentifier  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [No] in table 'StudentSet'
ALTER TABLE [dbo].[StudentSet]
ADD CONSTRAINT [PK_StudentSet]
    PRIMARY KEY CLUSTERED ([No] ASC);
GO

-- Creating primary key on [Id] in table 'BookSet'
ALTER TABLE [dbo].[BookSet]
ADD CONSTRAINT [PK_BookSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'StudentBookOrderSet'
ALTER TABLE [dbo].[StudentBookOrderSet]
ADD CONSTRAINT [PK_StudentBookOrderSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [StudentBookOrder_Id], [Book_Id] in table 'StudentBookOrderBook'
ALTER TABLE [dbo].[StudentBookOrderBook]
ADD CONSTRAINT [PK_StudentBookOrderBook]
    PRIMARY KEY CLUSTERED ([StudentBookOrder_Id], [Book_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [StudentNo] in table 'StudentBookOrderSet'
ALTER TABLE [dbo].[StudentBookOrderSet]
ADD CONSTRAINT [FK_StudentStudentBookOrder]
    FOREIGN KEY ([StudentNo])
    REFERENCES [dbo].[StudentSet]
        ([No])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StudentStudentBookOrder'
CREATE INDEX [IX_FK_StudentStudentBookOrder]
ON [dbo].[StudentBookOrderSet]
    ([StudentNo]);
GO

-- Creating foreign key on [StudentBookOrder_Id] in table 'StudentBookOrderBook'
ALTER TABLE [dbo].[StudentBookOrderBook]
ADD CONSTRAINT [FK_StudentBookOrderBook_StudentBookOrder]
    FOREIGN KEY ([StudentBookOrder_Id])
    REFERENCES [dbo].[StudentBookOrderSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Book_Id] in table 'StudentBookOrderBook'
ALTER TABLE [dbo].[StudentBookOrderBook]
ADD CONSTRAINT [FK_StudentBookOrderBook_Book]
    FOREIGN KEY ([Book_Id])
    REFERENCES [dbo].[BookSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StudentBookOrderBook_Book'
CREATE INDEX [IX_FK_StudentBookOrderBook_Book]
ON [dbo].[StudentBookOrderBook]
    ([Book_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------