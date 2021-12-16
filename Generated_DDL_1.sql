CREATE TABLE jogador ( --done
	j_id		 INTEGER,
	j_nome		 VARCHAR(65) NOT NULL,
	j_idade		 INTEGER NOT NULL,
	j_interesses	 VARCHAR(256),
	j_tempo_gasto	 INTEGER,
	j_montante_gasto	 FLOAT(8),
	j_nacionalidade	 VARCHAR(25) NOT NULL,
	j_genero		 SMALLINT NOT NULL,
	j_pais_residencia VARCHAR(25) NOT NULL, 
	j_carteira	 INTEGER,
	PRIMARY KEY(j_id)
);

CREATE TABLE editora ( -- publisher done
	e_id	 INTEGER,
	e_nome VARCHAR(50) NOT NULL,
	PRIMARY KEY(e_id)
);

CREATE TABLE produtos ( --done
	pr_id		 INTEGER,
	pr_nome		 VARCHAR(45) NOT NULL,
	pr_preco		 NUMERIC(5,2) NOT NULL,
	pr_avaliacao	 INTEGER,
	pr_requisitos	 VARCHAR(256) NOT NULL,
	pr_tipo		 SMALLINT NOT NULL,
	pr_iva		 NUMERIC(5,2) NOT NULL,
	pr_descricao	 VARCHAR(100),
	desenvolvedor_ds_id BIGINT NOT NULL,
	editora_e_id	 INTEGER NOT NULL,
	PRIMARY KEY(pr_id)
);

CREATE TABLE genero ( -- genero done
	g_id	 INTEGER,
	g_nome VARCHAR(35) NOT NULL,
	PRIMARY KEY(g_id)
);

CREATE TABLE vendas ( 
	ve_id		 INTEGER,
	ve_data_hora	 TIMESTAMP NOT NULL,
	ve_preco	 NUMERIC(7,2) NOT NULL,
	ve_desconto	 INTEGER,
	produtos_pr_id INTEGER NOT NULL,
	jogador_j_id	 INTEGER NOT NULL,
	PRIMARY KEY(ve_id)
);

CREATE TABLE sistema_operativo ( -- sistema operativo done
	s_id	 INTEGER,
	s_nome VARCHAR(20) NOT NULL,
	PRIMARY KEY(s_id)
);

CREATE TABLE categorias ( -- done
	c_id	 INTEGER,
	c_nome VARCHAR(25) NOT NULL,
	PRIMARY KEY(c_id)
);

CREATE TABLE epoca_promocao ( --done
	ep_id		 INTEGER,
	ep_nome	 VARCHAR(512) NOT NULL,
	ep_data_inicio DATE NOT NULL,
	ep_data_fim	 DATE NOT NULL,
	PRIMARY KEY(ep_id)
);

CREATE TABLE historico_sessoes ( --done
	sj_id		 BIGINT,
	sj_data_inicio TIMESTAMP NOT NULL,
	sj_data_fim	 TIMESTAMP NOT NULL,
	produtos_pr_id INTEGER NOT NULL,
	jogador_j_id	 INTEGER NOT NULL,
	PRIMARY KEY(sj_id)
);

CREATE TABLE desenvolvedor ( --done
	ds_id	 BIGINT,
	ds_nome	 CHAR(50) NOT NULL,
	ds_descricao CHAR(256),
	PRIMARY KEY(ds_id)
);

--fornecedor do servidor
CREATE TABLE fornecedor ( -- done
	f_id		 BIGINT,
	f_nome		 VARCHAR(35),
	f_especialidade VARCHAR(25),
	PRIMARY KEY(f_id)
);
--servidor
CREATE TABLE rubrica ( --done
	r_id		 BIGINT,
	r_descricao	 VARCHAR(25) NOT NULL,
	r_observacoes VARCHAR(110),
	PRIMARY KEY(r_id)
);


CREATE TABLE despesas ( --done
	d_id	 BIGINT,
	d_data	 TIMESTAMP NOT NULL,
	d_valor NUMERIC(7,2) NOT NULL,
	PRIMARY KEY(d_id)
);

CREATE TABLE despesas_rubrica ( --done
	despesas_d_id BIGINT,
	rubrica_r_id	 BIGINT,
	PRIMARY KEY(despesas_d_id,rubrica_r_id)
);

CREATE TABLE fornecedor_despesas ( --done
	fornecedor_f_id BIGINT,
	despesas_d_id	 BIGINT,
	PRIMARY KEY(fornecedor_f_id,despesas_d_id)
);

CREATE TABLE despesas_produtos ( --done
	despesas_d_id	 BIGINT,
	produtos_pr_id INTEGER NOT NULL,
	PRIMARY KEY(despesas_d_id)
);

CREATE TABLE vendas_epoca_promocao ( --done
	vendas_ve_id	 INTEGER,
	epoca_promocao_ep_id INTEGER NOT NULL,
	PRIMARY KEY(vendas_ve_id)
);

CREATE TABLE jogador_produtos (--done
	jogador_j_id	 INTEGER,
	produtos_pr_id INTEGER,
	PRIMARY KEY(jogador_j_id,produtos_pr_id)
);

CREATE TABLE produtos_epoca_promocao (--done
	produtos_pr_id	 INTEGER,
	epoca_promocao_ep_id INTEGER NOT NULL,
	PRIMARY KEY(produtos_pr_id)
);

CREATE TABLE categorias_produtos (--done
	categorias_c_id INTEGER,
	produtos_pr_id	 INTEGER,
	PRIMARY KEY(categorias_c_id,produtos_pr_id)
);

CREATE TABLE sistema_operativo_produtos ( --done
	sistema_operativo_s_id INTEGER,
	produtos_pr_id	 INTEGER,
	PRIMARY KEY(sistema_operativo_s_id,produtos_pr_id)
);

CREATE TABLE produtos_genero ( --done
	produtos_pr_id INTEGER,
	genero_g_id	 INTEGER,
	PRIMARY KEY(produtos_pr_id,genero_g_id)
);

ALTER TABLE produtos ADD CONSTRAINT produtos_fk1 FOREIGN KEY (desenvolvedor_ds_id) REFERENCES desenvolvedor(ds_id);
ALTER TABLE produtos ADD CONSTRAINT produtos_fk2 FOREIGN KEY (editora_e_id) REFERENCES editora(e_id);
ALTER TABLE vendas ADD CONSTRAINT vendas_fk1 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE vendas ADD CONSTRAINT vendas_fk2 FOREIGN KEY (jogador_j_id) REFERENCES jogador(j_id);
ALTER TABLE historico_sessoes ADD CONSTRAINT historico_sessoes_fk1 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE historico_sessoes ADD CONSTRAINT historico_sessoes_fk2 FOREIGN KEY (jogador_j_id) REFERENCES jogador(j_id);
ALTER TABLE despesas_rubrica ADD CONSTRAINT despesas_rubrica_fk1 FOREIGN KEY (despesas_d_id) REFERENCES despesas(d_id);
ALTER TABLE despesas_rubrica ADD CONSTRAINT despesas_rubrica_fk2 FOREIGN KEY (rubrica_r_id) REFERENCES rubrica(r_id);
ALTER TABLE fornecedor_despesas ADD CONSTRAINT fornecedor_despesas_fk1 FOREIGN KEY (fornecedor_f_id) REFERENCES fornecedor(f_id);
ALTER TABLE fornecedor_despesas ADD CONSTRAINT fornecedor_despesas_fk2 FOREIGN KEY (despesas_d_id) REFERENCES despesas(d_id);
ALTER TABLE despesas_produtos ADD CONSTRAINT despesas_produtos_fk1 FOREIGN KEY (despesas_d_id) REFERENCES despesas(d_id);
ALTER TABLE despesas_produtos ADD CONSTRAINT despesas_produtos_fk2 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE vendas_epoca_promocao ADD CONSTRAINT vendas_epoca_promocao_fk1 FOREIGN KEY (vendas_ve_id) REFERENCES vendas(ve_id);
ALTER TABLE vendas_epoca_promocao ADD CONSTRAINT vendas_epoca_promocao_fk2 FOREIGN KEY (epoca_promocao_ep_id) REFERENCES epoca_promocao(ep_id);
ALTER TABLE jogador_produtos ADD CONSTRAINT jogador_produtos_fk1 FOREIGN KEY (jogador_j_id) REFERENCES jogador(j_id);
ALTER TABLE jogador_produtos ADD CONSTRAINT jogador_produtos_fk2 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE produtos_epoca_promocao ADD CONSTRAINT produtos_epoca_promocao_fk1 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE produtos_epoca_promocao ADD CONSTRAINT produtos_epoca_promocao_fk2 FOREIGN KEY (epoca_promocao_ep_id) REFERENCES epoca_promocao(ep_id);
ALTER TABLE categorias_produtos ADD CONSTRAINT categorias_produtos_fk1 FOREIGN KEY (categorias_c_id) REFERENCES categorias(c_id);
ALTER TABLE categorias_produtos ADD CONSTRAINT categorias_produtos_fk2 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE sistema_operativo_produtos ADD CONSTRAINT sistema_operativo_produtos_fk1 FOREIGN KEY (sistema_operativo_s_id) REFERENCES sistema_operativo(s_id);
ALTER TABLE sistema_operativo_produtos ADD CONSTRAINT sistema_operativo_produtos_fk2 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE produtos_genero ADD CONSTRAINT produtos_genero_fk1 FOREIGN KEY (produtos_pr_id) REFERENCES produtos(pr_id);
ALTER TABLE produtos_genero ADD CONSTRAINT produtos_genero_fk2 FOREIGN KEY (genero_g_id) REFERENCES genero(g_id);

