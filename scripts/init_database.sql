
-- =====================================================
-- CRIAÇÃO DO BANCO DE DADOS - DATA WAREHOUSE
-- Arquitetura Medallion: Bronze, Silver e Gold
-- =====================================================

-- Seleciona o banco de dados master para executar
-- operações administrativas no SQL Server.
USE master;
GO

-- Verifica se já existe um banco chamado 'DataWarehouse'.
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    -- Define o banco em modo SINGLE_USER, permitindo
    -- apenas uma conexão por vez.
    -- ROLLBACK IMMEDIATE encerra conexões existentes
    -- e desfaz transações que ainda estão em andamento.
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Exclui o banco de dados existente.
    -- ATENÇÃO: Todos os dados serão perdidos!
    DROP DATABASE DataWarehouse;
END;
GO

-- Cria um novo banco de dados chamado DataWarehouse.
-- Executado independentemente da existência anterior.
CREATE DATABASE DataWarehouse;
GO

-- Define o DataWarehouse como banco ativo.
USE DataWarehouse;
GO

-- =====================================================
-- CRIAÇÃO DOS SCHEMAS - ARQUITETURA MEDALLION
-- =====================================================

-- BRONZE: Camada de dados brutos (Raw Data).
-- Armazena os dados extraídos das fontes originais,
-- preservando sua estrutura e informações de origem.
CREATE SCHEMA bronze;
GO

-- SILVER: Camada de dados tratados (Cleaned Data).
-- Contém dados após limpeza, padronização,
-- validação, deduplicação e transformações.
CREATE SCHEMA silver;
GO

-- GOLD: Camada de dados de negócio (Business Data).
-- Contém dados modelados e preparados para consumo
-- analítico, relatórios, dashboards e indicadores.
CREATE SCHEMA gold;
GO
