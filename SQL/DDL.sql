CREATE TABLE Pessoa(
	
      CPF VARCHAR(11) PRIMARY KEY,
      Nome VARCHAR(100),
      Nascimento DATE,
      Email VARCHAR(100),
      Telefone VARCHAR(20)
);

CREATE TABLE Staff(

	CPF VARCHAR(11) PRIMARY KEY,
	FOREIGN KEY (CPF) REFERENCES Pessoa(CPF)
);

CREATE TABLE Jogador(

	CPF VARCHAR(11) PRIMARY KEY,
	Status VARCHAR(50),
	FOREIGN KEY (CPF) REFERENCES Pessoa(CPF)
);

CREATE TABLE Patrocinador(
	
      CNPJ VARCHAR(14) PRIMARY KEY,
	Nome VARCHAR(100),
	Valor DECIMAL(12,2)
);

CREATE TABLE Organizacao(

	CNPJ VARCHAR(14) PRIMARY KEY,
	Nome VARCHAR(100),
	Sigla VARCHAR(10),
	Sub_CNPJ VARCHAR(14),
	FOREIGN KEY (Sub_CNPJ) REFERENCES Organizacao(CNPJ)

);

CREATE TABLE Jogo(

	Jogo_ID VARCHAR(10) PRIMARY KEY,
      Preco DECIMAL(10,2),
	Nome VARCHAR(100)
);

CREATE TABLE Plataformas(
	
       Jogo_ID VARCHAR(10),
	 Plataforma VARCHAR(100),
	 PRIMARY KEY (Jogo_ID,Plataforma),
    	 FOREIGN KEY (Jogo_ID) REFERENCES Jogo(Jogo_ID)
);

CREATE TABLE Torneio(

	Torneio_ID VARCHAR(10) PRIMARY KEY,
	Premiacao DECIMAL(12,2),
	Nome VARCHAR(100),
	Jogo_ID VARCHAR(10) NOT NULL,
	FOREIGN KEY (Jogo_ID) REFERENCES Jogo(Jogo_ID)
);

CREATE TABLE Coordena(
	
     CPF VARCHAR(11),
     Torneio_ID VARCHAR(10),
     Papel VARCHAR(100),
     PRIMARY KEY (CPF,Torneio_ID,Papel),
     FOREIGN KEY (CPF) REFERENCES Staff(CPF),
     FOREIGN KEY (Torneio_ID) REFERENCES Torneio(Torneio_ID)
);

CREATE TABLE Partida(

      Partida_ID VARCHAR(100) PRIMARY KEY,
      Data DATE,
      Duracao INTERVAL DAY TO SECOND,
      Torneio_ID VARCHAR(10) NOT NULL,	
      FOREIGN KEY (Torneio_ID) REFERENCES Torneio(Torneio_ID)
);

CREATE TABLE Resultado (
    Partida_ID  VARCHAR(100) PRIMARY KEY,
    Resumo VARCHAR(100),
    Vencedor VARCHAR(100),
    Score INT,
    Placar VARCHAR(50),
    FOREIGN KEY (Partida_ID) REFERENCES Partida(Partida_ID)
);

CREATE TABLE Equipe (
    CNPJ VARCHAR(14) NOT NULL,
    Equipe_Disc VARCHAR(100) NOT NULL,
    Nome VARCHAR(100),
    Orcamento DECIMAL(12,2),
    Data_Criacao DATE,
    PRIMARY KEY (CNPJ, Equipe_Disc),
    FOREIGN KEY (CNPJ) REFERENCES Organizacao(CNPJ)
);

CREATE TABLE Possui (
      CNPJ_Patrocinador VARCHAR(14) NOT NULL,
      CNPJ_Org VARCHAR(14) NOT NULL,
   	Equipe_Disc VARCHAR(100) NOT NULL,

      PRIMARY KEY (CNPJ_Patrocinador, CNPJ_Org, Equipe_Disc),
      FOREIGN KEY (CNPJ_Patrocinador)  REFERENCES Patrocinador(CNPJ),
      FOREIGN KEY (CNPJ_Org, Equipe_Disc) REFERENCES Equipe(CNPJ, Equipe_Disc)
);

CREATE TABLE Participa (

     CPF VARCHAR(11) NOT NULL,
     Partida_ID VARCHAR(100) NOT NULL,
     Equipe_DIsc VARCHAR(100) NOT NULL,
     CNPJ_Organizacao VARCHAR(14) NOT NULL,

     PRIMARY KEY (CPF, Partida_ID),
     FOREIGN KEY (CPF) REFERENCES Pessoa(CPF),
     FOREIGN KEY (Partida_ID) REFERENCES Partida(Partida_ID),
     FOREIGN KEY (CNPJ_Organizacao,Equipe_Disc) REFERENCES Equipe(CNPJ, Equipe_Disc)

);   
