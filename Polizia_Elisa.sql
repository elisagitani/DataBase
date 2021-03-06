USE [master]
GO
/****** Object:  Database [Polizia_Elisa]    Script Date: 14/05/2021 12:52:02 ******/
CREATE DATABASE [Polizia_Elisa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Polizia_Elisa', FILENAME = N'C:\Users\utente\Polizia_Elisa.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Polizia_Elisa_log', FILENAME = N'C:\Users\utente\Polizia_Elisa_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Polizia_Elisa] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Polizia_Elisa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Polizia_Elisa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET ARITHABORT OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Polizia_Elisa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Polizia_Elisa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Polizia_Elisa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Polizia_Elisa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Polizia_Elisa] SET  MULTI_USER 
GO
ALTER DATABASE [Polizia_Elisa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Polizia_Elisa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Polizia_Elisa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Polizia_Elisa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Polizia_Elisa] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Polizia_Elisa] SET QUERY_STORE = OFF
GO
USE [Polizia_Elisa]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Polizia_Elisa]
GO
/****** Object:  UserDefinedFunction [dbo].[Eta]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Eta] 
(
	-- Add the parameters for the function here
	@dataNascita date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = ((10000*year(getdate())+100*month(getdate())+day(getdate()))-(year(@dataNascita)*10000+month(@dataNascita)*100+day(@dataNascita)))/10000

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  Table [dbo].[Agenti]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agenti](
	[IdAgente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[CodiceFiscale] [nchar](16) NOT NULL,
	[DataNascita] [date] NOT NULL,
	[AnniServizio] [int] NULL,
 CONSTRAINT [PK_Agenti] PRIMARY KEY CLUSTERED 
(
	[IdAgente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CodiceFiscale] UNIQUE NONCLUSTERED 
(
	[CodiceFiscale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appartenenza]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appartenenza](
	[IdAgente] [int] NOT NULL,
	[IdArea] [int] NOT NULL,
 CONSTRAINT [IX_Appartenenza] UNIQUE NONCLUSTERED 
(
	[IdAgente] ASC,
	[IdArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aree_Metropolitane]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aree_Metropolitane](
	[IdArea] [int] IDENTITY(1,1) NOT NULL,
	[CodiceArea] [nchar](5) NOT NULL,
	[Rischio] [int] NOT NULL,
 CONSTRAINT [PK_Aree_Metropolitane] PRIMARY KEY CLUSTERED 
(
	[IdArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Aree_Metropolitane] UNIQUE NONCLUSTERED 
(
	[CodiceArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appartenenza]  WITH CHECK ADD  CONSTRAINT [FK_Appartenenza_Agenti] FOREIGN KEY([IdAgente])
REFERENCES [dbo].[Agenti] ([IdAgente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Appartenenza] CHECK CONSTRAINT [FK_Appartenenza_Agenti]
GO
ALTER TABLE [dbo].[Appartenenza]  WITH CHECK ADD  CONSTRAINT [FK_Appartenenza_Aree_Metropolitane] FOREIGN KEY([IdArea])
REFERENCES [dbo].[Aree_Metropolitane] ([IdArea])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Appartenenza] CHECK CONSTRAINT [FK_Appartenenza_Aree_Metropolitane]
GO
ALTER TABLE [dbo].[Agenti]  WITH CHECK ADD  CONSTRAINT [CK_EtaAgenti] CHECK  (([dbo].[Eta]([DataNascita])>=(18)))
GO
ALTER TABLE [dbo].[Agenti] CHECK CONSTRAINT [CK_EtaAgenti]
GO
ALTER TABLE [dbo].[Agenti]  WITH CHECK ADD  CONSTRAINT [CK_LunghezzaCodiceFiscale] CHECK  ((len([CodiceFiscale])=(16)))
GO
ALTER TABLE [dbo].[Agenti] CHECK CONSTRAINT [CK_LunghezzaCodiceFiscale]
GO
ALTER TABLE [dbo].[Aree_Metropolitane]  WITH CHECK ADD  CONSTRAINT [CK_CodiceArea] CHECK  ((len([CodiceArea])=(5)))
GO
ALTER TABLE [dbo].[Aree_Metropolitane] CHECK CONSTRAINT [CK_CodiceArea]
GO
ALTER TABLE [dbo].[Aree_Metropolitane]  WITH CHECK ADD  CONSTRAINT [CK_Rischio] CHECK  (([Rischio]=(0) OR [Rischio]=(1)))
GO
ALTER TABLE [dbo].[Aree_Metropolitane] CHECK CONSTRAINT [CK_Rischio]
GO
/****** Object:  StoredProcedure [dbo].[AgentiRischioEAnni]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AgentiRischioEAnni] 
	
AS
BEGIN
	
	SELECT        dbo.Agenti.Nome, dbo.Agenti.Cognome, dbo.Aree_Metropolitane.Rischio, dbo.Agenti.AnniServizio
FROM            dbo.Agenti INNER JOIN
                         dbo.Appartenenza ON dbo.Agenti.IdAgente = dbo.Appartenenza.IdAgente INNER JOIN
                         dbo.Aree_Metropolitane ON dbo.Appartenenza.IdArea = dbo.Aree_Metropolitane.IdArea
WHERE        (dbo.Aree_Metropolitane.Rischio = 1) AND (dbo.Agenti.AnniServizio < 3)

END
GO
/****** Object:  StoredProcedure [dbo].[EliminaAgente]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--rimuovere agente attraverso l'ID
CREATE PROCEDURE [dbo].[EliminaAgente] 
	-- Add the parameters for the stored procedure here
	@idAgente int  	
AS
BEGIN
	delete from Agenti where Agenti.IdAgente=@idAgente 
	
END
GO
/****** Object:  StoredProcedure [dbo].[InserimentoAgente]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Inserisci dati di un nuovo agente
CREATE PROCEDURE [dbo].[InserimentoAgente] 
	-- Add the parameters for the stored procedure here
	@nome nvarchar(30), 
	@cognome nvarchar(50),
	@codiceFiscale nchar(16),
	@dataNascita date,
	@anniServizio int
AS
BEGIN
	
	begin tran
	
	begin try
		insert into Agenti values (@nome, @cognome,@codiceFiscale,@dataNascita,@anniServizio)
		
		commit
	end try
	begin catch
		select ERROR_MESSAGE()
		rollback
	end catch	
    return @@rowcount
END
GO
/****** Object:  StoredProcedure [dbo].[InserimentoAreaMetropolitana]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Inserisci area
CREATE PROCEDURE [dbo].[InserimentoAreaMetropolitana]
	-- Add the parameters for the stored procedure here
	@codiceArea nchar(5), 
	@rischio int
AS
BEGIN
	begin tran
	
	begin try
		insert into Aree_Metropolitane values (@codiceArea, @rischio)
		commit
	end try
	begin catch
		select ERROR_MESSAGE()
		rollback
	end catch	
    return @@rowcount
END
GO
/****** Object:  StoredProcedure [dbo].[NumeroAgentiInUnaDataArea]    Script Date: 14/05/2021 12:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Numero Agenti che appartengono ad una determinata area
CREATE PROCEDURE [dbo].[NumeroAgentiInUnaDataArea]
	
AS
BEGIN
	SELECT        dbo.Aree_Metropolitane.CodiceArea, COUNT(dbo.Appartenenza.IdAgente) AS NumeroAgenti
FROM            dbo.Agenti INNER JOIN
                         dbo.Appartenenza ON dbo.Agenti.IdAgente = dbo.Appartenenza.IdAgente FULL OUTER JOIN
                         dbo.Aree_Metropolitane ON dbo.Appartenenza.IdArea = dbo.Aree_Metropolitane.IdArea
GROUP BY dbo.Aree_Metropolitane.CodiceArea
END
GO
USE [master]
GO
ALTER DATABASE [Polizia_Elisa] SET  READ_WRITE 
GO
