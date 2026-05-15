/*
	Arquivo com instruções para cirar o banco de dados que receberá
	as tabelas fato e dimensões
*/

--Acesso para testes
usuário: rafael
password: 123456

--Execute o comando para criar o banco
CREATE DATABASE nexora_digital; 

--Depois de criado o banco conecte nele e execute os comando abaixo para criar as tabelas

--dim_cliente
CREATE TABLE dim_cliente (
    id_cliente SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    type_of_user VARCHAR(50),
    country VARCHAR(50),
    cluster VARCHAR(50),
    segment_comission VARCHAR(50),
    first_date_comission DATE,
    data_ini DATE NOT NULL,
    data_fim DATE,
    atual BOOLEAN DEFAULT TRUE,
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP
);

--dim_area
CREATE TABLE dim_area (
    id_area SERIAL PRIMARY KEY,
    consulting INT,
    new_business INT,
    office VARCHAR(50),
    data_ini DATE NOT NULL,
    data_fim DATE,
    atual BOOLEAN DEFAULT TRUE,
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP
);

--dim_dim_tempo
CREATE TABLE dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    period DATE NOT NULL,
    ano INT,
    mes INT,
    dia INT,
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP
);

--dim_origem
CREATE TABLE dim_origem (
    id_origem SERIAL PRIMARY KEY,
    origin VARCHAR(100),
    data_ini DATE NOT NULL,
    data_fim DATE,
    atual BOOLEAN DEFAULT TRUE,
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP
);

--fato_comissao
CREATE TABLE fato_comissao (
    id_fato SERIAL PRIMARY KEY,
    user_id INT,
    period DATE,
    period_comission_brl NUMERIC(15,2),
    lifetime_commission_brl NUMERIC(15,2),
    churn INT,
	-- Chaves estrangeiras
    id_cliente INT,
    id_area INT,
    id_tempo INT,
    id_origem INT,
	
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP,
	
	-- Trecho para garnatir integridade referencial
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
    CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES dim_area(id_area),
    CONSTRAINT fk_tempo FOREIGN KEY (id_tempo) REFERENCES dim_tempo(id_tempo),
    CONSTRAINT fk_origem FOREIGN KEY (id_origem) REFERENCES dim_origem(id_origem)
);