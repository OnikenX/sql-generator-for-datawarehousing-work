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

INSERT INTO genero (g_id, g_nome)
            VALUES (1,'Indie');
INSERT INTO genero (g_id, g_nome)
            VALUES (2,'Action');
INSERT INTO genero (g_id, g_nome)
            VALUES (3,'Adventure');
INSERT INTO genero (g_id, g_nome)
            VALUES (4,'Casual');
INSERT INTO genero (g_id, g_nome)
            VALUES (5,'Simulation');
INSERT INTO genero (g_id, g_nome)
            VALUES (6,'Strategy');
INSERT INTO genero (g_id, g_nome)
            VALUES (7,'RPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (8,'Singleplayer');
INSERT INTO genero (g_id, g_nome)
            VALUES (9,'Early Access');
INSERT INTO genero (g_id, g_nome)
            VALUES (10,'Free to Play');
INSERT INTO genero (g_id, g_nome)
            VALUES (11,'2D');
INSERT INTO genero (g_id, g_nome)
            VALUES (12,'Atmospheric');
INSERT INTO genero (g_id, g_nome)
            VALUES (13,'Violent');
INSERT INTO genero (g_id, g_nome)
            VALUES (14,'Massively Multiplayer');
INSERT INTO genero (g_id, g_nome)
            VALUES (15,'Sports');
INSERT INTO genero (g_id, g_nome)
            VALUES (16,'Multiplayer');
INSERT INTO genero (g_id, g_nome)
            VALUES (17,'Puzzle');
INSERT INTO genero (g_id, g_nome)
            VALUES (18,'3D');
INSERT INTO genero (g_id, g_nome)
            VALUES (19,'Story Rich');
INSERT INTO genero (g_id, g_nome)
            VALUES (20,'Fantasy');
INSERT INTO genero (g_id, g_nome)
            VALUES (21,'Pixel Graphics');
INSERT INTO genero (g_id, g_nome)
            VALUES (22,'Colorful');
INSERT INTO genero (g_id, g_nome)
            VALUES (23,'Racing');
INSERT INTO genero (g_id, g_nome)
            VALUES (24,'Nudity');
INSERT INTO genero (g_id, g_nome)
            VALUES (25,'Gore');
INSERT INTO genero (g_id, g_nome)
            VALUES (26,'Exploration');
INSERT INTO genero (g_id, g_nome)
            VALUES (27,'Sexual Content');
INSERT INTO genero (g_id, g_nome)
            VALUES (28,'Cute');
INSERT INTO genero (g_id, g_nome)
            VALUES (29,'Anime');
INSERT INTO genero (g_id, g_nome)
            VALUES (30,'First-Person');
INSERT INTO genero (g_id, g_nome)
            VALUES (31,'Funny');
INSERT INTO genero (g_id, g_nome)
            VALUES (32,'Sci-fi');
INSERT INTO genero (g_id, g_nome)
            VALUES (33,'Arcade');
INSERT INTO genero (g_id, g_nome)
            VALUES (34,'Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (35,'Horror');
INSERT INTO genero (g_id, g_nome)
            VALUES (36,'Family Friendly');
INSERT INTO genero (g_id, g_nome)
            VALUES (37,'Retro');
INSERT INTO genero (g_id, g_nome)
            VALUES (38,'Relaxing');
INSERT INTO genero (g_id, g_nome)
            VALUES (39,'Action-Adventure');
INSERT INTO genero (g_id, g_nome)
            VALUES (40,'Great Soundtrack');
INSERT INTO genero (g_id, g_nome)
            VALUES (41,'Open World');
INSERT INTO genero (g_id, g_nome)
            VALUES (42,'Platformer');
INSERT INTO genero (g_id, g_nome)
            VALUES (43,'Co-op');
INSERT INTO genero (g_id, g_nome)
            VALUES (44,'Survival');
INSERT INTO genero (g_id, g_nome)
            VALUES (45,'Combat');
INSERT INTO genero (g_id, g_nome)
            VALUES (46,'Female Protagonist');
INSERT INTO genero (g_id, g_nome)
            VALUES (47,'Third Person');
INSERT INTO genero (g_id, g_nome)
            VALUES (48,'Difficult');
INSERT INTO genero (g_id, g_nome)
            VALUES (49,'VR');
INSERT INTO genero (g_id, g_nome)
            VALUES (50,'Comedy');
INSERT INTO genero (g_id, g_nome)
            VALUES (51,'Stylized');
INSERT INTO genero (g_id, g_nome)
            VALUES (52,'PvP');
INSERT INTO genero (g_id, g_nome)
            VALUES (53,'Old School');
INSERT INTO genero (g_id, g_nome)
            VALUES (54,'FPS');
INSERT INTO genero (g_id, g_nome)
            VALUES (55,'Visual Novel');
INSERT INTO genero (g_id, g_nome)
            VALUES (56,'Choices Matter');
INSERT INTO genero (g_id, g_nome)
            VALUES (57,'Controller');
INSERT INTO genero (g_id, g_nome)
            VALUES (58,'Realistic');
INSERT INTO genero (g_id, g_nome)
            VALUES (59,'Online Co-Op');
INSERT INTO genero (g_id, g_nome)
            VALUES (60,'Physics');
INSERT INTO genero (g_id, g_nome)
            VALUES (61,'Top-Down');
INSERT INTO genero (g_id, g_nome)
            VALUES (62,'Dark');
INSERT INTO genero (g_id, g_nome)
            VALUES (63,'Character Customization');
INSERT INTO genero (g_id, g_nome)
            VALUES (64,'Mystery');
INSERT INTO genero (g_id, g_nome)
            VALUES (65,'Sandbox');
INSERT INTO genero (g_id, g_nome)
            VALUES (66,'Cartoony');
INSERT INTO genero (g_id, g_nome)
            VALUES (67,'Multiple Endings');
INSERT INTO genero (g_id, g_nome)
            VALUES (68,'Psychological Horror');
INSERT INTO genero (g_id, g_nome)
            VALUES (69,'Shoot Em Up');
INSERT INTO genero (g_id, g_nome)
            VALUES (70,'Tactical');
INSERT INTO genero (g_id, g_nome)
            VALUES (71,'2D Platformer');
INSERT INTO genero (g_id, g_nome)
            VALUES (72,'Design & Illustration');
INSERT INTO genero (g_id, g_nome)
            VALUES (73,'PvE');
INSERT INTO genero (g_id, g_nome)
            VALUES (74,'Minimalist');
INSERT INTO genero (g_id, g_nome)
            VALUES (75,'Space');
INSERT INTO genero (g_id, g_nome)
            VALUES (76,'Linear');
INSERT INTO genero (g_id, g_nome)
            VALUES (77,'Building');
INSERT INTO genero (g_id, g_nome)
            VALUES (78,'Point & Click');
INSERT INTO genero (g_id, g_nome)
            VALUES (79,'Utilities');
INSERT INTO genero (g_id, g_nome)
            VALUES (80,'Local Multiplayer');
INSERT INTO genero (g_id, g_nome)
            VALUES (81,'Magic');
INSERT INTO genero (g_id, g_nome)
            VALUES (82,'Futuristic');
INSERT INTO genero (g_id, g_nome)
            VALUES (83,'Management');
INSERT INTO genero (g_id, g_nome)
            VALUES (84,'Action RPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (85,'Hand-drawn');
INSERT INTO genero (g_id, g_nome)
            VALUES (86,'1980s');
INSERT INTO genero (g_id, g_nome)
            VALUES (87,'Crafting');
INSERT INTO genero (g_id, g_nome)
            VALUES (88,'Side Scroller');
INSERT INTO genero (g_id, g_nome)
            VALUES (89,'Education');
INSERT INTO genero (g_id, g_nome)
            VALUES (90,'Turn-Based');
INSERT INTO genero (g_id, g_nome)
            VALUES (91,'Replay Value');
INSERT INTO genero (g_id, g_nome)
            VALUES (92,'Procedural Generation');
INSERT INTO genero (g_id, g_nome)
            VALUES (93,'Cartoon');
INSERT INTO genero (g_id, g_nome)
            VALUES (94,'Medieval');
INSERT INTO genero (g_id, g_nome)
            VALUES (95,'Resource Management');
INSERT INTO genero (g_id, g_nome)
            VALUES (96,'Puzzle Platformer');
INSERT INTO genero (g_id, g_nome)
            VALUES (97,'Mature');
INSERT INTO genero (g_id, g_nome)
            VALUES (98,'Survival Horror');
INSERT INTO genero (g_id, g_nome)
            VALUES (99,'Zombies');
INSERT INTO genero (g_id, g_nome)
            VALUES (100,'War');
INSERT INTO genero (g_id, g_nome)
            VALUES (101,'Logic');
INSERT INTO genero (g_id, g_nome)
            VALUES (102,'Roguelike');
INSERT INTO genero (g_id, g_nome)
            VALUES (103,'Local Co-Op');
INSERT INTO genero (g_id, g_nome)
            VALUES (104,'Turn-Based Combat');
INSERT INTO genero (g_id, g_nome)
            VALUES (105,'Turn-Based Strategy');
INSERT INTO genero (g_id, g_nome)
            VALUES (106,'Dark Fantasy');
INSERT INTO genero (g_id, g_nome)
            VALUES (107,'Drama');
INSERT INTO genero (g_id, g_nome)
            VALUES (108,'Hack and Slash');
INSERT INTO genero (g_id, g_nome)
            VALUES (109,'3D Platformer');
INSERT INTO genero (g_id, g_nome)
            VALUES (110,'Romance');
INSERT INTO genero (g_id, g_nome)
            VALUES (111,'Choose Your Own Adventure');
INSERT INTO genero (g_id, g_nome)
            VALUES (112,'Post-apocalyptic');
INSERT INTO genero (g_id, g_nome)
            VALUES (113,'Base Building');
INSERT INTO genero (g_id, g_nome)
            VALUES (114,'Roguelite');
INSERT INTO genero (g_id, g_nome)
            VALUES (115,'Historical');
INSERT INTO genero (g_id, g_nome)
            VALUES (116,'Turn-Based Tactics');
INSERT INTO genero (g_id, g_nome)
            VALUES (117,'Memes');
INSERT INTO genero (g_id, g_nome)
            VALUES (118,'Dating Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (119,'Stealth');
INSERT INTO genero (g_id, g_nome)
            VALUES (120,'JRPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (121,'Interactive Fiction');
INSERT INTO genero (g_id, g_nome)
            VALUES (122,'Hidden Object');
INSERT INTO genero (g_id, g_nome)
            VALUES (123,'Walking Simulator');
INSERT INTO genero (g_id, g_nome)
            VALUES (124,'Surreal');
INSERT INTO genero (g_id, g_nome)
            VALUES (125,'Web Publishing');
INSERT INTO genero (g_id, g_nome)
            VALUES (126,'Narration');
INSERT INTO genero (g_id, g_nome)
            VALUES (127,'Dungeon Crawler');
INSERT INTO genero (g_id, g_nome)
            VALUES (128,'Emotional');
INSERT INTO genero (g_id, g_nome)
            VALUES (129,'Classic');
INSERT INTO genero (g_id, g_nome)
            VALUES (130,'Party-Based RPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (131,'Fast-Paced');
INSERT INTO genero (g_id, g_nome)
            VALUES (132,'Score Attack');
INSERT INTO genero (g_id, g_nome)
            VALUES (133,'Military');
INSERT INTO genero (g_id, g_nome)
            VALUES (134,'Hentai');
INSERT INTO genero (g_id, g_nome)
            VALUES (135,'Nature');
INSERT INTO genero (g_id, g_nome)
            VALUES (136,'Bullet Hell');
INSERT INTO genero (g_id, g_nome)
            VALUES (137,'1990s');
INSERT INTO genero (g_id, g_nome)
            VALUES (138,'Third-Person Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (139,'Short');
INSERT INTO genero (g_id, g_nome)
            VALUES (140,'Immersive Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (141,'Movie');
INSERT INTO genero (g_id, g_nome)
            VALUES (142,'Animation & Modeling');
INSERT INTO genero (g_id, g_nome)
            VALUES (143,'Team-Based');
INSERT INTO genero (g_id, g_nome)
            VALUES (144,'Software');
INSERT INTO genero (g_id, g_nome)
            VALUES (145,'Robots');
INSERT INTO genero (g_id, g_nome)
            VALUES (146,'RTS');
INSERT INTO genero (g_id, g_nome)
            VALUES (147,'Top-Down Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (148,'Isometric');
INSERT INTO genero (g_id, g_nome)
            VALUES (149,'Cyberpunk');
INSERT INTO genero (g_id, g_nome)
            VALUES (150,'Text-Based');
INSERT INTO genero (g_id, g_nome)
            VALUES (151,'2.5D');
INSERT INTO genero (g_id, g_nome)
            VALUES (152,'Dark Humor');
INSERT INTO genero (g_id, g_nome)
            VALUES (153,'Aliens');
INSERT INTO genero (g_id, g_nome)
            VALUES (154,'Conversation');
INSERT INTO genero (g_id, g_nome)
            VALUES (155,'Beautiful');
INSERT INTO genero (g_id, g_nome)
            VALUES (156,'Cinematic');
INSERT INTO genero (g_id, g_nome)
            VALUES (157,'Experimental');
INSERT INTO genero (g_id, g_nome)
            VALUES (158,'Driving');
INSERT INTO genero (g_id, g_nome)
            VALUES (159,'Economy');
INSERT INTO genero (g_id, g_nome)
            VALUES (160,'LGBTQ+');
INSERT INTO genero (g_id, g_nome)
            VALUES (161,'Card Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (162,'Investigation');
INSERT INTO genero (g_id, g_nome)
            VALUES (163,'RPGMaker');
INSERT INTO genero (g_id, g_nome)
            VALUES (164,'Abstract');
INSERT INTO genero (g_id, g_nome)
            VALUES (165,'Action Roguelike');
INSERT INTO genero (g_id, g_nome)
            VALUES (166,'Music');
INSERT INTO genero (g_id, g_nome)
            VALUES (167,'Fighting');
INSERT INTO genero (g_id, g_nome)
            VALUES (168,'Tutorial');
INSERT INTO genero (g_id, g_nome)
            VALUES (169,'4 Player Local');
INSERT INTO genero (g_id, g_nome)
            VALUES (170,'Nonlinear');
INSERT INTO genero (g_id, g_nome)
            VALUES (171,'Inventory Management');
INSERT INTO genero (g_id, g_nome)
            VALUES (172,'Tabletop');
INSERT INTO genero (g_id, g_nome)
            VALUES (173,'Board Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (174,'Perma Death');
INSERT INTO genero (g_id, g_nome)
            VALUES (175,'Flight');
INSERT INTO genero (g_id, g_nome)
            VALUES (176,'Audio Production');
INSERT INTO genero (g_id, g_nome)
            VALUES (177,'Soundtrack');
INSERT INTO genero (g_id, g_nome)
            VALUES (178,'Artificial Intelligence');
INSERT INTO genero (g_id, g_nome)
            VALUES (179,'Real Time Tactics');
INSERT INTO genero (g_id, g_nome)
            VALUES (180,'Thriller');
INSERT INTO genero (g_id, g_nome)
            VALUES (181,'Strategy RPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (182,'Detective');
INSERT INTO genero (g_id, g_nome)
            VALUES (183,'Psychological');
INSERT INTO genero (g_id, g_nome)
            VALUES (184,'Arena Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (185,'NSFW');
INSERT INTO genero (g_id, g_nome)
            VALUES (186,'Demons');
INSERT INTO genero (g_id, g_nome)
            VALUES (187,'Clicker');
INSERT INTO genero (g_id, g_nome)
            VALUES (188,'Modern');
INSERT INTO genero (g_id, g_nome)
            VALUES (189,'Moddable');
INSERT INTO genero (g_id, g_nome)
            VALUES (190,'Tower Defense');
INSERT INTO genero (g_id, g_nome)
            VALUES (191,'Video Production');
INSERT INTO genero (g_id, g_nome)
            VALUES (192,'Life Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (193,'Lore-Rich');
INSERT INTO genero (g_id, g_nome)
            VALUES (194,'Competitive');
INSERT INTO genero (g_id, g_nome)
            VALUES (195,'City Builder');
INSERT INTO genero (g_id, g_nome)
            VALUES (196,'Psychedelic');
INSERT INTO genero (g_id, g_nome)
            VALUES (197,'Destruction');
INSERT INTO genero (g_id, g_nome)
            VALUES (198,'Dystopian');
INSERT INTO genero (g_id, g_nome)
            VALUES (199,'Time Management');
INSERT INTO genero (g_id, g_nome)
            VALUES (200,'Beat em up');
INSERT INTO genero (g_id, g_nome)
            VALUES (201,'Loot');
INSERT INTO genero (g_id, g_nome)
            VALUES (202,'Precision Platformer');
INSERT INTO genero (g_id, g_nome)
            VALUES (203,'Metroidvania');
INSERT INTO genero (g_id, g_nome)
            VALUES (204,'Supernatural');
INSERT INTO genero (g_id, g_nome)
            VALUES (205,'Tactical RPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (206,'Alternate History');
INSERT INTO genero (g_id, g_nome)
            VALUES (207,'Level Editor');
INSERT INTO genero (g_id, g_nome)
            VALUES (208,'Wargame');
INSERT INTO genero (g_id, g_nome)
            VALUES (209,'Comic Book');
INSERT INTO genero (g_id, g_nome)
            VALUES (210,'MMORPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (211,'Game Development');
INSERT INTO genero (g_id, g_nome)
            VALUES (212,'Souls-like');
INSERT INTO genero (g_id, g_nome)
            VALUES (213,'Parkour');
INSERT INTO genero (g_id, g_nome)
            VALUES (214,'Crime');
INSERT INTO genero (g_id, g_nome)
            VALUES (215,'Dark Comedy');
INSERT INTO genero (g_id, g_nome)
            VALUES (216,'World War II');
INSERT INTO genero (g_id, g_nome)
            VALUES (217,'Mythology');
INSERT INTO genero (g_id, g_nome)
            VALUES (218,'2D Fighter');
INSERT INTO genero (g_id, g_nome)
            VALUES (219,'Runner');
INSERT INTO genero (g_id, g_nome)
            VALUES (220,'Grid-Based Movement');
INSERT INTO genero (g_id, g_nome)
            VALUES (221,'Character Action Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (222,'Philosophical');
INSERT INTO genero (g_id, g_nome)
            VALUES (223,'CRPG');
INSERT INTO genero (g_id, g_nome)
            VALUES (224,'Science');
INSERT INTO genero (g_id, g_nome)
            VALUES (225,'Twin Stick Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (226,'Class-Based');
INSERT INTO genero (g_id, g_nome)
            VALUES (227,'Software Training');
INSERT INTO genero (g_id, g_nome)
            VALUES (228,'Automobile Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (229,'Addictive');
INSERT INTO genero (g_id, g_nome)
            VALUES (230,'Co-op Campaign');
INSERT INTO genero (g_id, g_nome)
            VALUES (231,'Grand Strategy');
INSERT INTO genero (g_id, g_nome)
            VALUES (232,'Space Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (233,'Blood');
INSERT INTO genero (g_id, g_nome)
            VALUES (234,'Collectathon');
INSERT INTO genero (g_id, g_nome)
            VALUES (235,'Gun Customization');
INSERT INTO genero (g_id, g_nome)
            VALUES (236,'Swordplay');
INSERT INTO genero (g_id, g_nome)
            VALUES (237,'Rhythm');
INSERT INTO genero (g_id, g_nome)
            VALUES (238,'Lovecraftian');
INSERT INTO genero (g_id, g_nome)
            VALUES (239,'Idler');
INSERT INTO genero (g_id, g_nome)
            VALUES (240,'Battle Royale');
INSERT INTO genero (g_id, g_nome)
            VALUES (241,'Split Screen');
INSERT INTO genero (g_id, g_nome)
            VALUES (242,'Cats');
INSERT INTO genero (g_id, g_nome)
            VALUES (243,'Deckbuilding');
INSERT INTO genero (g_id, g_nome)
            VALUES (244,'Dragons');
INSERT INTO genero (g_id, g_nome)
            VALUES (245,'Match 3');
INSERT INTO genero (g_id, g_nome)
            VALUES (246,'3D Vision');
INSERT INTO genero (g_id, g_nome)
            VALUES (247,'Illuminati');
INSERT INTO genero (g_id, g_nome)
            VALUES (248,'Open World Survival Craft');
INSERT INTO genero (g_id, g_nome)
            VALUES (249,'eSports');
INSERT INTO genero (g_id, g_nome)
            VALUES (250,'6DOF');
INSERT INTO genero (g_id, g_nome)
            VALUES (251,'America');
INSERT INTO genero (g_id, g_nome)
            VALUES (252,'Vehicular Combat');
INSERT INTO genero (g_id, g_nome)
            VALUES (253,'Parody');
INSERT INTO genero (g_id, g_nome)
            VALUES (254,'Noir');
INSERT INTO genero (g_id, g_nome)
            VALUES (255,'Card Battler');
INSERT INTO genero (g_id, g_nome)
            VALUES (256,'Conspiracy');
INSERT INTO genero (g_id, g_nome)
            VALUES (257,'Capitalism');
INSERT INTO genero (g_id, g_nome)
            VALUES (258,'Satire');
INSERT INTO genero (g_id, g_nome)
            VALUES (259,'3D Fighter');
INSERT INTO genero (g_id, g_nome)
            VALUES (260,'Bullet Time');
INSERT INTO genero (g_id, g_nome)
            VALUES (261,'Trading');
INSERT INTO genero (g_id, g_nome)
            VALUES (262,'Voxel');
INSERT INTO genero (g_id, g_nome)
            VALUES (263,'Photo Editing');
INSERT INTO genero (g_id, g_nome)
            VALUES (264,'Political');
INSERT INTO genero (g_id, g_nome)
            VALUES (265,'Real-Time');
INSERT INTO genero (g_id, g_nome)
            VALUES (266,'Mouse only');
INSERT INTO genero (g_id, g_nome)
            VALUES (267,'Steampunk');
INSERT INTO genero (g_id, g_nome)
            VALUES (268,'Episodic');
INSERT INTO genero (g_id, g_nome)
            VALUES (269,'Cult Classic');
INSERT INTO genero (g_id, g_nome)
            VALUES (270,'Epic');
INSERT INTO genero (g_id, g_nome)
            VALUES (271,'Colony Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (272,'Automation');
INSERT INTO genero (g_id, g_nome)
            VALUES (273,'Time Manipulation');
INSERT INTO genero (g_id, g_nome)
            VALUES (274,'Mystery Dungeon');
INSERT INTO genero (g_id, g_nome)
            VALUES (275,'Mechs');
INSERT INTO genero (g_id, g_nome)
            VALUES (276,'Hunting');
INSERT INTO genero (g_id, g_nome)
            VALUES (277,'Time Travel');
INSERT INTO genero (g_id, g_nome)
            VALUES (278,'Gothic');
INSERT INTO genero (g_id, g_nome)
            VALUES (279,'Underground');
INSERT INTO genero (g_id, g_nome)
            VALUES (280,'Mining');
INSERT INTO genero (g_id, g_nome)
            VALUES (281,'Agriculture');
INSERT INTO genero (g_id, g_nome)
            VALUES (282,'Dynamic Narration');
INSERT INTO genero (g_id, g_nome)
            VALUES (283,'Tanks');
INSERT INTO genero (g_id, g_nome)
            VALUES (284,'MOBA');
INSERT INTO genero (g_id, g_nome)
            VALUES (285,'Remake');
INSERT INTO genero (g_id, g_nome)
            VALUES (286,'Politics');
INSERT INTO genero (g_id, g_nome)
            VALUES (287,'Farming Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (288,'Quick-Time Events');
INSERT INTO genero (g_id, g_nome)
            VALUES (289,'Otome');
INSERT INTO genero (g_id, g_nome)
            VALUES (290,'Martial Arts');
INSERT INTO genero (g_id, g_nome)
            VALUES (291,'Hacking');
INSERT INTO genero (g_id, g_nome)
            VALUES (292,'Ninja');
INSERT INTO genero (g_id, g_nome)
            VALUES (293,'Hero Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (294,'Pirates');
INSERT INTO genero (g_id, g_nome)
            VALUES (295,'Word Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (296,'God Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (297,'Spectacle fighter');
INSERT INTO genero (g_id, g_nome)
            VALUES (298,'Dog');
INSERT INTO genero (g_id, g_nome)
            VALUES (299,'Hex Grid');
INSERT INTO genero (g_id, g_nome)
            VALUES (300,'Cold War');
INSERT INTO genero (g_id, g_nome)
            VALUES (301,'FMV');
INSERT INTO genero (g_id, g_nome)
            VALUES (302,'Creature Collector');
INSERT INTO genero (g_id, g_nome)
            VALUES (303,'Solitaire');
INSERT INTO genero (g_id, g_nome)
            VALUES (304,'Looter Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (305,'Combat Racing');
INSERT INTO genero (g_id, g_nome)
            VALUES (306,'4X');
INSERT INTO genero (g_id, g_nome)
            VALUES (307,'Asynchronous Multiplayer');
INSERT INTO genero (g_id, g_nome)
            VALUES (308,'Trading Card Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (309,'Superhero');
INSERT INTO genero (g_id, g_nome)
            VALUES (310,'Fishing');
INSERT INTO genero (g_id, g_nome)
            VALUES (311,'Programming');
INSERT INTO genero (g_id, g_nome)
            VALUES (312,'Real-Time with Pause');
INSERT INTO genero (g_id, g_nome)
            VALUES (313,'Dinosaurs');
INSERT INTO genero (g_id, g_nome)
            VALUES (314,'Assassin');
INSERT INTO genero (g_id, g_nome)
            VALUES (315,'Underwater');
INSERT INTO genero (g_id, g_nome)
            VALUES (316,'Vampire');
INSERT INTO genero (g_id, g_nome)
            VALUES (317,'Trains');
INSERT INTO genero (g_id, g_nome)
            VALUES (318,'Naval');
INSERT INTO genero (g_id, g_nome)
            VALUES (319,'Kickstarter');
INSERT INTO genero (g_id, g_nome)
            VALUES (320,'Western');
INSERT INTO genero (g_id, g_nome)
            VALUES (321,'Heist');
INSERT INTO genero (g_id, g_nome)
            VALUES (322,'Immersive');
INSERT INTO genero (g_id, g_nome)
            VALUES (323,'Minigames');
INSERT INTO genero (g_id, g_nome)
            VALUES (324,'Narrative');
INSERT INTO genero (g_id, g_nome)
            VALUES (325,'Faith');
INSERT INTO genero (g_id, g_nome)
            VALUES (326,'Sokoban');
INSERT INTO genero (g_id, g_nome)
            VALUES (327,'Political Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (328,'Cooking');
INSERT INTO genero (g_id, g_nome)
            VALUES (329,'Party');
INSERT INTO genero (g_id, g_nome)
            VALUES (330,'Archery');
INSERT INTO genero (g_id, g_nome)
            VALUES (331,'GameMaker');
INSERT INTO genero (g_id, g_nome)
            VALUES (332,'Diplomacy');
INSERT INTO genero (g_id, g_nome)
            VALUES (333,'Party Game');
INSERT INTO genero (g_id, g_nome)
            VALUES (334,'Touch-Friendly');
INSERT INTO genero (g_id, g_nome)
            VALUES (335,'Experience');
INSERT INTO genero (g_id, g_nome)
            VALUES (336,'Foreign');
INSERT INTO genero (g_id, g_nome)
            VALUES (337,'Mod');
INSERT INTO genero (g_id, g_nome)
            VALUES (338,'Transportation');
INSERT INTO genero (g_id, g_nome)
            VALUES (339,'Snow');
INSERT INTO genero (g_id, g_nome)
            VALUES (340,'Naval Combat');
INSERT INTO genero (g_id, g_nome)
            VALUES (341,'Auto Battler');
INSERT INTO genero (g_id, g_nome)
            VALUES (342,'Sequel');
INSERT INTO genero (g_id, g_nome)
            VALUES (343,'Dungeons & Dragons');
INSERT INTO genero (g_id, g_nome)
            VALUES (344,'Sailing');
INSERT INTO genero (g_id, g_nome)
            VALUES (345,'Music-Based Procedural Generation');
INSERT INTO genero (g_id, g_nome)
            VALUES (346,'Documentary');
INSERT INTO genero (g_id, g_nome)
            VALUES (347,'Sniper');
INSERT INTO genero (g_id, g_nome)
            VALUES (348,'Transhumanism');
INSERT INTO genero (g_id, g_nome)
            VALUES (349,'Time Attack');
INSERT INTO genero (g_id, g_nome)
            VALUES (350,'Gambling');
INSERT INTO genero (g_id, g_nome)
            VALUES (351,'Villain Protagonist');
INSERT INTO genero (g_id, g_nome)
            VALUES (352,'Mars');
INSERT INTO genero (g_id, g_nome)
            VALUES (353,'Games Workshop');
INSERT INTO genero (g_id, g_nome)
            VALUES (354,'Action RTS');
INSERT INTO genero (g_id, g_nome)
            VALUES (355,'Soccer');
INSERT INTO genero (g_id, g_nome)
            VALUES (356,'Typing');
INSERT INTO genero (g_id, g_nome)
            VALUES (357,'World War I');
INSERT INTO genero (g_id, g_nome)
            VALUES (358,'On-Rails Shooter');
INSERT INTO genero (g_id, g_nome)
            VALUES (359,'Offroad');
INSERT INTO genero (g_id, g_nome)
            VALUES (360,'Football');
INSERT INTO genero (g_id, g_nome)
            VALUES (361,'Horses');
INSERT INTO genero (g_id, g_nome)
            VALUES (362,'Werewolves');
INSERT INTO genero (g_id, g_nome)
            VALUES (363,'Gaming');
INSERT INTO genero (g_id, g_nome)
            VALUES (364,'Silent Protagonist');
INSERT INTO genero (g_id, g_nome)
            VALUES (365,'Trivia');
INSERT INTO genero (g_id, g_nome)
            VALUES (366,'360 Video');
INSERT INTO genero (g_id, g_nome)
            VALUES (367,'Crowdfunded');
INSERT INTO genero (g_id, g_nome)
            VALUES (368,'Chess');
INSERT INTO genero (g_id, g_nome)
            VALUES (369,'Boxing');
INSERT INTO genero (g_id, g_nome)
            VALUES (370,'Nostalgia');
INSERT INTO genero (g_id, g_nome)
            VALUES (371,'Farming');
INSERT INTO genero (g_id, g_nome)
            VALUES (372,'Traditional Roguelike');
INSERT INTO genero (g_id, g_nome)
            VALUES (373,'Unforgiving');
INSERT INTO genero (g_id, g_nome)
            VALUES (374,'LEGO');
INSERT INTO genero (g_id, g_nome)
            VALUES (375,'Roguelike Deckbuilder');
INSERT INTO genero (g_id, g_nome)
            VALUES (376,'Jet');
INSERT INTO genero (g_id, g_nome)
            VALUES (377,'TrackIR');
INSERT INTO genero (g_id, g_nome)
            VALUES (378,'Outbreak Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (379,'Pinball');
INSERT INTO genero (g_id, g_nome)
            VALUES (380,'Motorbike');
INSERT INTO genero (g_id, g_nome)
            VALUES (381,'Rome');
INSERT INTO genero (g_id, g_nome)
            VALUES (382,'Spaceships');
INSERT INTO genero (g_id, g_nome)
            VALUES (383,'Electronic Music');
INSERT INTO genero (g_id, g_nome)
            VALUES (384,'Medical Sim');
INSERT INTO genero (g_id, g_nome)
            VALUES (385,'Golf');
INSERT INTO genero (g_id, g_nome)
            VALUES (386,'Asymmetric VR');
INSERT INTO genero (g_id, g_nome)
            VALUES (387,'Ambient');
INSERT INTO genero (g_id, g_nome)
            VALUES (388,'Spelling');
INSERT INTO genero (g_id, g_nome)
            VALUES (389,'Warhammer 40K');
INSERT INTO genero (g_id, g_nome)
            VALUES (390,'Based On A Novel');
INSERT INTO genero (g_id, g_nome)
            VALUES (391,'Submarine');
INSERT INTO genero (g_id, g_nome)
            VALUES (392,'Roguevania');
INSERT INTO genero (g_id, g_nome)
            VALUES (393,'Bikes');
INSERT INTO genero (g_id, g_nome)
            VALUES (394,'Escape Room');
INSERT INTO genero (g_id, g_nome)
            VALUES (395,'Basketball');
INSERT INTO genero (g_id, g_nome)
            VALUES (396,'Social Deduction');
INSERT INTO genero (g_id, g_nome)
            VALUES (397,'Mini Golf');
INSERT INTO genero (g_id, g_nome)
            VALUES (398,'Intentionally Awkward Controls');
INSERT INTO genero (g_id, g_nome)
            VALUES (399,'Wrestling');
INSERT INTO genero (g_id, g_nome)
            VALUES (400,'Instrumental Music');
INSERT INTO genero (g_id, g_nome)
            VALUES (401,'Pool');
INSERT INTO genero (g_id, g_nome)
            VALUES (402,'Skateboarding');
INSERT INTO genero (g_id, g_nome)
            VALUES (403,'Vikings');
INSERT INTO genero (g_id, g_nome)
            VALUES (404,'Lemmings');
INSERT INTO genero (g_id, g_nome)
            VALUES (405,'Benchmark');
INSERT INTO genero (g_id, g_nome)
            VALUES (406,'Baseball');
INSERT INTO genero (g_id, g_nome)
            VALUES (407,'Steam Machine');
INSERT INTO genero (g_id, g_nome)
            VALUES (408,'Tennis');
INSERT INTO genero (g_id, g_nome)
            VALUES (409,'Skating');
INSERT INTO genero (g_id, g_nome)
            VALUES (410,'Hockey');
INSERT INTO genero (g_id, g_nome)
            VALUES (411,'Hardware');
INSERT INTO genero (g_id, g_nome)
            VALUES (412,'Motocross');
INSERT INTO genero (g_id, g_nome)
            VALUES (413,'Bowling');
INSERT INTO genero (g_id, g_nome)
            VALUES (414,'Cycling');
INSERT INTO genero (g_id, g_nome)
            VALUES (415,'Electronic');
INSERT INTO genero (g_id, g_nome)
            VALUES (416,'Rock Music');
INSERT INTO genero (g_id, g_nome)
            VALUES (417,'Feature Film');
INSERT INTO genero (g_id, g_nome)
            VALUES (418,'Voice Control');
INSERT INTO genero (g_id, g_nome)
            VALUES (419,'ATV');
INSERT INTO genero (g_id, g_nome)
            VALUES (420,'8-bit Music');
INSERT INTO genero (g_id, g_nome)
            VALUES (421,'Well-Written');
INSERT INTO genero (g_id, g_nome)
            VALUES (422,'Skiing');
INSERT INTO genero (g_id, g_nome)
            VALUES (423,'BMX');
INSERT INTO genero (g_id, g_nome)
            VALUES (424,'Snowboarding');
INSERT INTO genero (g_id, g_nome)
            VALUES (425,'Boss Rush');
INSERT INTO genero (g_id, g_nome)
            VALUES (426,'Reboot');
INSERT INTO editora (e_id, e_nome)
            VALUES (1,'07th Expansion');
INSERT INTO editora (e_id, e_nome)
            VALUES (2,'11 bit studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (3,'1C Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (4,'2K Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (5,'3D Realms');
INSERT INTO editora (e_id, e_nome)
            VALUES (6,'The 3DO Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (7,'505 Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (8,'7th Level');
INSERT INTO editora (e_id, e_nome)
            VALUES (9,'A&F Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (10,'Aackosoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (11,'Aardvark Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (12,'ABC Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (13,'Absolute Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (14,'Access Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (15,'Acclaim Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (16,'Accolade');
INSERT INTO editora (e_id, e_nome)
            VALUES (17,'Acornsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (18,'Acquire');
INSERT INTO editora (e_id, e_nome)
            VALUES (19,'Active Gaming Media AGM');
INSERT INTO editora (e_id, e_nome)
            VALUES (20,'Activision');
INSERT INTO editora (e_id, e_nome)
            VALUES (21,'Activision Blizzard');
INSERT INTO editora (e_id, e_nome)
            VALUES (22,'Addictive Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (23,'The Adventure Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (24,'Adventure International');
INSERT INTO editora (e_id, e_nome)
            VALUES (25,'Adventure Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (26,'Affect');
INSERT INTO editora (e_id, e_nome)
            VALUES (27,'Agatsuma Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (28,'Âge');
INSERT INTO editora (e_id, e_nome)
            VALUES (29,'AGEod');
INSERT INTO editora (e_id, e_nome)
            VALUES (30,'Agetec');
INSERT INTO editora (e_id, e_nome)
            VALUES (31,'Akabeisoft2');
INSERT INTO editora (e_id, e_nome)
            VALUES (32,'Akella');
INSERT INTO editora (e_id, e_nome)
            VALUES (33,'Akupara Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (34,'Aksys');
INSERT INTO editora (e_id, e_nome)
            VALUES (35,'ALcot');
INSERT INTO editora (e_id, e_nome)
            VALUES (36,'Alawar');
INSERT INTO editora (e_id, e_nome)
            VALUES (37,'AliceSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (38,'AlphaDream');
INSERT INTO editora (e_id, e_nome)
            VALUES (39,'ADK');
INSERT INTO editora (e_id, e_nome)
            VALUES (40,'Alchemist');
INSERT INTO editora (e_id, e_nome)
            VALUES (41,'All in! Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (42,'Alligata');
INSERT INTO editora (e_id, e_nome)
            VALUES (43,'Allumer');
INSERT INTO editora (e_id, e_nome)
            VALUES (44,'Alten8');
INSERT INTO editora (e_id, e_nome)
            VALUES (45,'Alternative Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (46,'Amazon Game Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (47,'American Game Cartridges');
INSERT INTO editora (e_id, e_nome)
            VALUES (48,'American Laser Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (49,'American Video Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (50,'Amplitude Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (51,'Amsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (52,'ANALOG Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (53,'Antic Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (54,'APF Electronics Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (55,'Apogee Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (56,'Apple Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (57,'Aquaplus');
INSERT INTO editora (e_id, e_nome)
            VALUES (58,'AQ Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (59,'Arcadia Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (60,'Arcen Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (61,'Arc System Works');
INSERT INTO editora (e_id, e_nome)
            VALUES (62,'Argus Press');
INSERT INTO editora (e_id, e_nome)
            VALUES (63,'Arika');
INSERT INTO editora (e_id, e_nome)
            VALUES (64,'Ariolasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (65,'Armor Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (66,'Arsys Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (67,'Artdink');
INSERT INTO editora (e_id, e_nome)
            VALUES (68,'Artic Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (69,'Arush Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (70,'Arxel Tribe');
INSERT INTO editora (e_id, e_nome)
            VALUES (71,'Ascaron');
INSERT INTO editora (e_id, e_nome)
            VALUES (72,'ASC Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (73,'Asmik Corporation of America');
INSERT INTO editora (e_id, e_nome)
            VALUES (74,'Aspyr Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (75,'Astragon');
INSERT INTO editora (e_id, e_nome)
            VALUES (76,'Atari, Inc');
INSERT INTO editora (e_id, e_nome)
            VALUES (77,'Atari Corp.');
INSERT INTO editora (e_id, e_nome)
            VALUES (78,'Atari Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (79,'Atari, SA');
INSERT INTO editora (e_id, e_nome)
            VALUES (80,'Athena');
INSERT INTO editora (e_id, e_nome)
            VALUES (81,'Atlantis Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (82,'AQ Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (83,'Artech Digital Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (84,'ASCII Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (85,'Atlus');
INSERT INTO editora (e_id, e_nome)
            VALUES (86,'Attic Entertainment Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (87,'Audiogenic Limited');
INSERT INTO editora (e_id, e_nome)
            VALUES (88,'August');
INSERT INTO editora (e_id, e_nome)
            VALUES (89,'Auran Development');
INSERT INTO editora (e_id, e_nome)
            VALUES (90,'Automata UK');
INSERT INTO editora (e_id, e_nome)
            VALUES (91,'Autumn Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (92,'Avalon Hill');
INSERT INTO editora (e_id, e_nome)
            VALUES (93,'Aventuras AD');
INSERT INTO editora (e_id, e_nome)
            VALUES (94,'Aventurine SA');
INSERT INTO editora (e_id, e_nome)
            VALUES (95,'BAM! Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (96,'Bandai Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (97,'Bandai Namco Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (98,'Banpresto');
INSERT INTO editora (e_id, e_nome)
            VALUES (99,'BBC Multimedia');
INSERT INTO editora (e_id, e_nome)
            VALUES (100,'Beagle Bros');
INSERT INTO editora (e_id, e_nome)
            VALUES (101,'Bergsala Lightweight');
INSERT INTO editora (e_id, e_nome)
            VALUES (102,'Berkeley Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (103,'Bethesda Softworks');
INSERT INTO editora (e_id, e_nome)
            VALUES (104,'Beyond Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (105,'Big Fish Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (106,'Big Five Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (107,'Black Bean Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (108,'Blue Byte');
INSERT INTO editora (e_id, e_nome)
            VALUES (109,'Broderbund');
INSERT INTO editora (e_id, e_nome)
            VALUES (110,'Black Legend');
INSERT INTO editora (e_id, e_nome)
            VALUES (111,'Blizzard Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (112,'Blue Ribbon');
INSERT INTO editora (e_id, e_nome)
            VALUES (113,'Bohemia Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (114,'Box Office, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (115,'Brash Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (116,'Broccoli');
INSERT INTO editora (e_id, e_nome)
            VALUES (117,'Bug-Byte');
INSERT INTO editora (e_id, e_nome)
            VALUES (118,'Bubble Bus Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (119,'BudgeCo');
INSERT INTO editora (e_id, e_nome)
            VALUES (120,'Bullet-Proof Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (121,'Bungie');
INSERT INTO editora (e_id, e_nome)
            VALUES (122,'C&E');
INSERT INTO editora (e_id, e_nome)
            VALUES (123,'California Dreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (124,'California Pacific Computer Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (125,'Camerica');
INSERT INTO editora (e_id, e_nome)
            VALUES (126,'Canal+ Multimedia');
INSERT INTO editora (e_id, e_nome)
            VALUES (127,'Candy Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (128,'Capcom');
INSERT INTO editora (e_id, e_nome)
            VALUES (129,'Capstone Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (130,'Carry Lab');
INSERT INTO editora (e_id, e_nome)
            VALUES (131,'Casady & Greene');
INSERT INTO editora (e_id, e_nome)
            VALUES (132,'Cases Computer Simulations');
INSERT INTO editora (e_id, e_nome)
            VALUES (133,'Cave');
INSERT INTO editora (e_id, e_nome)
            VALUES (134,'CBS Electronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (135,'CD Projekt Red');
INSERT INTO editora (e_id, e_nome)
            VALUES (136,'CDS Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (137,'CDV Software Entertainment AG');
INSERT INTO editora (e_id, e_nome)
            VALUES (138,'Centuri');
INSERT INTO editora (e_id, e_nome)
            VALUES (139,'ChessBase');
INSERT INTO editora (e_id, e_nome)
            VALUES (140,'Cinemax');
INSERT INTO editora (e_id, e_nome)
            VALUES (141,'CI Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (142,'Cinematronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (143,'Cinemaware');
INSERT INTO editora (e_id, e_nome)
            VALUES (144,'Circus');
INSERT INTO editora (e_id, e_nome)
            VALUES (145,'Club Kidsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (146,'The Coca-Cola Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (147,'Codemasters');
INSERT INTO editora (e_id, e_nome)
            VALUES (148,'Coktel Vision');
INSERT INTO editora (e_id, e_nome)
            VALUES (149,'Coleco');
INSERT INTO editora (e_id, e_nome)
            VALUES (150,'Color Dreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (151,'CommaVid');
INSERT INTO editora (e_id, e_nome)
            VALUES (152,'Commercial Data Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (153,'Commodore');
INSERT INTO editora (e_id, e_nome)
            VALUES (154,'Compile');
INSERT INTO editora (e_id, e_nome)
            VALUES (155,'Compile Heart');
INSERT INTO editora (e_id, e_nome)
            VALUES (156,'CompuServe');
INSERT INTO editora (e_id, e_nome)
            VALUES (157,'Computer and Video Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (158,'Conspiracy Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (159,'Core Design');
INSERT INTO editora (e_id, e_nome)
            VALUES (160,'Cosmi Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (161,'Crave Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (162,'Creative Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (163,'Creatures');
INSERT INTO editora (e_id, e_nome)
            VALUES (164,'Crimson Cow');
INSERT INTO editora (e_id, e_nome)
            VALUES (165,'CRL Group');
INSERT INTO editora (e_id, e_nome)
            VALUES (166,'Cronosoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (167,'Culture Brain Excel');
INSERT INTO editora (e_id, e_nome)
            VALUES (168,'Cryo Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (169,'Crystal Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (170,'Crystal Dynamics');
INSERT INTO editora (e_id, e_nome)
            VALUES (171,'Crytek');
INSERT INTO editora (e_id, e_nome)
            VALUES (172,'Crytivo Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (173,'Cyberdreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (174,'Cybersoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (175,'D3 Publisher');
INSERT INTO editora (e_id, e_nome)
            VALUES (176,'Daedalic Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (177,'DarXabre');
INSERT INTO editora (e_id, e_nome)
            VALUES (178,'Datamost');
INSERT INTO editora (e_id, e_nome)
            VALUES (179,'Datam Polystar');
INSERT INTO editora (e_id, e_nome)
            VALUES (180,'Datasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (181,'Data Age');
INSERT INTO editora (e_id, e_nome)
            VALUES (182,'Data Becker');
INSERT INTO editora (e_id, e_nome)
            VALUES (183,'Data East');
INSERT INTO editora (e_id, e_nome)
            VALUES (184,'Davidson & Associates');
INSERT INTO editora (e_id, e_nome)
            VALUES (185,'Davilex Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (186,'Davka');
INSERT INTO editora (e_id, e_nome)
            VALUES (187,'Daybreak Game Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (188,'dB-SOFT');
INSERT INTO editora (e_id, e_nome)
            VALUES (189,'Deep Silver');
INSERT INTO editora (e_id, e_nome)
            VALUES (190,'Delphine Software International');
INSERT INTO editora (e_id, e_nome)
            VALUES (191,'Delta 4');
INSERT INTO editora (e_id, e_nome)
            VALUES (192,'Destination Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (193,'Destineer');
INSERT INTO editora (e_id, e_nome)
            VALUES (194,'Devolver Digital');
INSERT INTO editora (e_id, e_nome)
            VALUES (195,'Digital Fantasia');
INSERT INTO editora (e_id, e_nome)
            VALUES (196,'Digital Integration');
INSERT INTO editora (e_id, e_nome)
            VALUES (197,'Digital Jesters');
INSERT INTO editora (e_id, e_nome)
            VALUES (198,'Digital Leisure');
INSERT INTO editora (e_id, e_nome)
            VALUES (199,'Digital Pictures');
INSERT INTO editora (e_id, e_nome)
            VALUES (200,'Dinamic Multimedia');
INSERT INTO editora (e_id, e_nome)
            VALUES (201,'Dinamic Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (202,'Disney Interactive Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (203,'DKTronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (204,'Domark');
INSERT INTO editora (e_id, e_nome)
            VALUES (205,'Double Fine');
INSERT INTO editora (e_id, e_nome)
            VALUES (206,'Dovetail Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (207,'Dragon Data');
INSERT INTO editora (e_id, e_nome)
            VALUES (208,'DreamCatcher Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (209,'DreamWorks Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (210,'DROsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (211,'Dtp entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (212,'Dynamic Planning');
INSERT INTO editora (e_id, e_nome)
            VALUES (213,'Dynamix');
INSERT INTO editora (e_id, e_nome)
            VALUES (214,'EasyGameStation');
INSERT INTO editora (e_id, e_nome)
            VALUES (215,'Ecole Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (216,'Edge Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (217,'Edu-Ware');
INSERT INTO editora (e_id, e_nome)
            VALUES (218,'eGames');
INSERT INTO editora (e_id, e_nome)
            VALUES (219,'Electric Dreams Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (220,'Electronic Arts');
INSERT INTO editora (e_id, e_nome)
            VALUES (221,'Electronic Arts Victor');
INSERT INTO editora (e_id, e_nome)
            VALUES (222,'Electro Brain');
INSERT INTO editora (e_id, e_nome)
            VALUES (223,'The Elektrik Keyboard');
INSERT INTO editora (e_id, e_nome)
            VALUES (224,'ELF Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (225,'Elite Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (226,'Empire Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (227,'English Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (228,'Enix');
INSERT INTO editora (e_id, e_nome)
            VALUES (229,'Enlight Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (230,'Enterbrain');
INSERT INTO editora (e_id, e_nome)
            VALUES (231,'Durell Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (232,'Eighting');
INSERT INTO editora (e_id, e_nome)
            VALUES (233,'Electric Transit');
INSERT INTO editora (e_id, e_nome)
            VALUES (234,'Emerald Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (235,'Encore, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (236,'Entertainment Software Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (237,'En Masse Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (238,'Eolith');
INSERT INTO editora (e_id, e_nome)
            VALUES (239,'Eon Digital Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (240,'Epic Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (241,'Epoch Co.');
INSERT INTO editora (e_id, e_nome)
            VALUES (242,'Epyx');
INSERT INTO editora (e_id, e_nome)
            VALUES (243,'ERE Informatique');
INSERT INTO editora (e_id, e_nome)
            VALUES (244,'ESA ');
INSERT INTO editora (e_id, e_nome)
            VALUES (245,'Europress');
INSERT INTO editora (e_id, e_nome)
            VALUES (246,'Eushully');
INSERT INTO editora (e_id, e_nome)
            VALUES (247,'Examu');
INSERT INTO editora (e_id, e_nome)
            VALUES (248,'Exidy');
INSERT INTO editora (e_id, e_nome)
            VALUES (249,'f&C');
INSERT INTO editora (e_id, e_nome)
            VALUES (250,'FASA');
INSERT INTO editora (e_id, e_nome)
            VALUES (251,'Fabtek');
INSERT INTO editora (e_id, e_nome)
            VALUES (252,'Fandom');
INSERT INTO editora (e_id, e_nome)
            VALUES (253,'Fairchild Semiconductor');
INSERT INTO editora (e_id, e_nome)
            VALUES (254,'Family Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (255,'Fantasy Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (256,'Faster Than Light');
INSERT INTO editora (e_id, e_nome)
            VALUES (257,'Fathammer');
INSERT INTO editora (e_id, e_nome)
            VALUES (258,'Firebird Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (259,'First Star Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (260,'Feral Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (261,'Broccoli');
INSERT INTO editora (e_id, e_nome)
            VALUES (262,'Bug-Byte');
INSERT INTO editora (e_id, e_nome)
            VALUES (263,'Bubble Bus Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (264,'BudgeCo');
INSERT INTO editora (e_id, e_nome)
            VALUES (265,'Bullet-Proof Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (266,'Bungie');
INSERT INTO editora (e_id, e_nome)
            VALUES (267,'C&E');
INSERT INTO editora (e_id, e_nome)
            VALUES (268,'California Dreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (269,'California Pacific Computer Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (270,'Camerica');
INSERT INTO editora (e_id, e_nome)
            VALUES (271,'Canal+ Multimedia');
INSERT INTO editora (e_id, e_nome)
            VALUES (272,'Candy Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (273,'Capcom');
INSERT INTO editora (e_id, e_nome)
            VALUES (274,'Capstone Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (275,'Carry Lab');
INSERT INTO editora (e_id, e_nome)
            VALUES (276,'Casady & Greene');
INSERT INTO editora (e_id, e_nome)
            VALUES (277,'Cases Computer Simulations');
INSERT INTO editora (e_id, e_nome)
            VALUES (278,'Cave');
INSERT INTO editora (e_id, e_nome)
            VALUES (279,'CBS Electronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (280,'CD Projekt Red');
INSERT INTO editora (e_id, e_nome)
            VALUES (281,'CDS Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (282,'CDV Software Entertainment AG');
INSERT INTO editora (e_id, e_nome)
            VALUES (283,'Centuri');
INSERT INTO editora (e_id, e_nome)
            VALUES (284,'ChessBase');
INSERT INTO editora (e_id, e_nome)
            VALUES (285,'Cinemax');
INSERT INTO editora (e_id, e_nome)
            VALUES (286,'CI Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (287,'Cinematronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (288,'Cinemaware');
INSERT INTO editora (e_id, e_nome)
            VALUES (289,'Circus');
INSERT INTO editora (e_id, e_nome)
            VALUES (290,'Club Kidsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (291,'The Coca-Cola Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (292,'Codemasters');
INSERT INTO editora (e_id, e_nome)
            VALUES (293,'Coktel Vision');
INSERT INTO editora (e_id, e_nome)
            VALUES (294,'Coleco');
INSERT INTO editora (e_id, e_nome)
            VALUES (295,'Color Dreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (296,'CommaVid');
INSERT INTO editora (e_id, e_nome)
            VALUES (297,'Commercial Data Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (298,'Commodore');
INSERT INTO editora (e_id, e_nome)
            VALUES (299,'Compile');
INSERT INTO editora (e_id, e_nome)
            VALUES (300,'Compile Heart');
INSERT INTO editora (e_id, e_nome)
            VALUES (301,'CompuServe');
INSERT INTO editora (e_id, e_nome)
            VALUES (302,'Computer and Video Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (303,'Conspiracy Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (304,'Core Design');
INSERT INTO editora (e_id, e_nome)
            VALUES (305,'Cosmi Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (306,'Crave Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (307,'Creative Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (308,'Creatures');
INSERT INTO editora (e_id, e_nome)
            VALUES (309,'Crimson Cow');
INSERT INTO editora (e_id, e_nome)
            VALUES (310,'CRL Group');
INSERT INTO editora (e_id, e_nome)
            VALUES (311,'Cronosoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (312,'Culture Brain Excel');
INSERT INTO editora (e_id, e_nome)
            VALUES (313,'Cryo Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (314,'Crystal Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (315,'Crystal Dynamics');
INSERT INTO editora (e_id, e_nome)
            VALUES (316,'Crytek');
INSERT INTO editora (e_id, e_nome)
            VALUES (317,'Crytivo Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (318,'Cyberdreams');
INSERT INTO editora (e_id, e_nome)
            VALUES (319,'Cybersoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (320,'D3 Publisher');
INSERT INTO editora (e_id, e_nome)
            VALUES (321,'Daedalic Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (322,'DarXabre');
INSERT INTO editora (e_id, e_nome)
            VALUES (323,'Datamost');
INSERT INTO editora (e_id, e_nome)
            VALUES (324,'Datam Polystar');
INSERT INTO editora (e_id, e_nome)
            VALUES (325,'Datasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (326,'Data Age');
INSERT INTO editora (e_id, e_nome)
            VALUES (327,'Data Becker');
INSERT INTO editora (e_id, e_nome)
            VALUES (328,'Data East');
INSERT INTO editora (e_id, e_nome)
            VALUES (329,'Davidson & Associates');
INSERT INTO editora (e_id, e_nome)
            VALUES (330,'Davilex Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (331,'Davka');
INSERT INTO editora (e_id, e_nome)
            VALUES (332,'Daybreak Game Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (333,'dB-SOFT');
INSERT INTO editora (e_id, e_nome)
            VALUES (334,'Deep Silver');
INSERT INTO editora (e_id, e_nome)
            VALUES (335,'Delphine Software International');
INSERT INTO editora (e_id, e_nome)
            VALUES (336,'Delta 4');
INSERT INTO editora (e_id, e_nome)
            VALUES (337,'Destination Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (338,'Destineer');
INSERT INTO editora (e_id, e_nome)
            VALUES (339,'Devolver Digital');
INSERT INTO editora (e_id, e_nome)
            VALUES (340,'Digital Fantasia');
INSERT INTO editora (e_id, e_nome)
            VALUES (341,'Digital Integration');
INSERT INTO editora (e_id, e_nome)
            VALUES (342,'Digital Jesters');
INSERT INTO editora (e_id, e_nome)
            VALUES (343,'Digital Leisure');
INSERT INTO editora (e_id, e_nome)
            VALUES (344,'Digital Pictures');
INSERT INTO editora (e_id, e_nome)
            VALUES (345,'Dinamic Multimedia');
INSERT INTO editora (e_id, e_nome)
            VALUES (346,'Dinamic Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (347,'Disney Interactive Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (348,'DKTronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (349,'Domark');
INSERT INTO editora (e_id, e_nome)
            VALUES (350,'Double Fine');
INSERT INTO editora (e_id, e_nome)
            VALUES (351,'Dovetail Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (352,'Dragon Data');
INSERT INTO editora (e_id, e_nome)
            VALUES (353,'DreamCatcher Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (354,'DreamWorks Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (355,'DROsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (356,'Dtp entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (357,'Dynamic Planning');
INSERT INTO editora (e_id, e_nome)
            VALUES (358,'Dynamix');
INSERT INTO editora (e_id, e_nome)
            VALUES (359,'EasyGameStation');
INSERT INTO editora (e_id, e_nome)
            VALUES (360,'Ecole Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (361,'Edge Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (362,'Edu-Ware');
INSERT INTO editora (e_id, e_nome)
            VALUES (363,'eGames');
INSERT INTO editora (e_id, e_nome)
            VALUES (364,'Electric Dreams Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (365,'Electronic Arts');
INSERT INTO editora (e_id, e_nome)
            VALUES (366,'Electronic Arts Victor');
INSERT INTO editora (e_id, e_nome)
            VALUES (367,'Electro Brain');
INSERT INTO editora (e_id, e_nome)
            VALUES (368,'The Elektrik Keyboard');
INSERT INTO editora (e_id, e_nome)
            VALUES (369,'ELF Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (370,'Elite Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (371,'Empire Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (372,'English Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (373,'Enix');
INSERT INTO editora (e_id, e_nome)
            VALUES (374,'Enlight Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (375,'Enterbrain');
INSERT INTO editora (e_id, e_nome)
            VALUES (376,'Durell Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (377,'Eighting');
INSERT INTO editora (e_id, e_nome)
            VALUES (378,'Electric Transit');
INSERT INTO editora (e_id, e_nome)
            VALUES (379,'Emerald Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (380,'Encore, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (381,'Entertainment Software Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (382,'En Masse Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (383,'Eolith');
INSERT INTO editora (e_id, e_nome)
            VALUES (384,'Eon Digital Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (385,'Epic Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (386,'Epoch Co.');
INSERT INTO editora (e_id, e_nome)
            VALUES (387,'Epyx');
INSERT INTO editora (e_id, e_nome)
            VALUES (388,'ERE Informatique');
INSERT INTO editora (e_id, e_nome)
            VALUES (389,'ESA ');
INSERT INTO editora (e_id, e_nome)
            VALUES (390,'Europress');
INSERT INTO editora (e_id, e_nome)
            VALUES (391,'Eushully');
INSERT INTO editora (e_id, e_nome)
            VALUES (392,'Examu');
INSERT INTO editora (e_id, e_nome)
            VALUES (393,'Exidy');
INSERT INTO editora (e_id, e_nome)
            VALUES (394,'f&C');
INSERT INTO editora (e_id, e_nome)
            VALUES (395,'FASA');
INSERT INTO editora (e_id, e_nome)
            VALUES (396,'Fabtek');
INSERT INTO editora (e_id, e_nome)
            VALUES (397,'Fandom');
INSERT INTO editora (e_id, e_nome)
            VALUES (398,'Fairchild Semiconductor');
INSERT INTO editora (e_id, e_nome)
            VALUES (399,'Family Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (400,'Fantasy Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (401,'Faster Than Light');
INSERT INTO editora (e_id, e_nome)
            VALUES (402,'Fathammer');
INSERT INTO editora (e_id, e_nome)
            VALUES (403,'Firebird Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (404,'First Star Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (405,'Feral Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (406,'inXile Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (407,'iQue');
INSERT INTO editora (e_id, e_nome)
            VALUES (408,'Irem');
INSERT INTO editora (e_id, e_nome)
            VALUES (409,'ITE Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (410,'Jaleco');
INSERT INTO editora (e_id, e_nome)
            VALUES (411,'JAST USA');
INSERT INTO editora (e_id, e_nome)
            VALUES (412,'Jester Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (413,'Johnson & Johnson');
INSERT INTO editora (e_id, e_nome)
            VALUES (414,'JoWooD Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (415,'JumpStart Games ');
INSERT INTO editora (e_id, e_nome)
            VALUES (416,'K2 Network ');
INSERT INTO editora (e_id, e_nome)
            VALUES (417,'Kalisto Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (418,'Kalypso Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (419,'Kaneko');
INSERT INTO editora (e_id, e_nome)
            VALUES (420,'Kaypro');
INSERT INTO editora (e_id, e_nome)
            VALUES (421,'Kemco');
INSERT INTO editora (e_id, e_nome)
            VALUES (422,'King Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (423,'KID');
INSERT INTO editora (e_id, e_nome)
            VALUES (424,'Kingsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (425,'King Records');
INSERT INTO editora (e_id, e_nome)
            VALUES (426,'Koch Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (427,'Kodansha');
INSERT INTO editora (e_id, e_nome)
            VALUES (428,'Koei');
INSERT INTO editora (e_id, e_nome)
            VALUES (429,'Koei Tecmo');
INSERT INTO editora (e_id, e_nome)
            VALUES (430,'Kogado Studio');
INSERT INTO editora (e_id, e_nome)
            VALUES (431,'Konami');
INSERT INTO editora (e_id, e_nome)
            VALUES (432,'Krisalis Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (433,'KSS');
INSERT INTO editora (e_id, e_nome)
            VALUES (434,'Kure Software Koubou');
INSERT INTO editora (e_id, e_nome)
            VALUES (435,'Lankhor');
INSERT INTO editora (e_id, e_nome)
            VALUES (436,'Le Lombard');
INSERT INTO editora (e_id, e_nome)
            VALUES (437,'Legacy Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (438,'Legendo Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (439,'Legend Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (440,'Lego Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (441,'Leland Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (442,'Level-5');
INSERT INTO editora (e_id, e_nome)
            VALUES (443,'Level 9 Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (444,'Limited Run Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (445,'Linux Game Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (446,'Lighthouse Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (447,'LJN');
INSERT INTO editora (e_id, e_nome)
            VALUES (448,'LK Avalon');
INSERT INTO editora (e_id, e_nome)
            VALUES (449,'Llamasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (450,'Lock n Load Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (451,'Logotron Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (452,'Loki Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (453,'Loriciel');
INSERT INTO editora (e_id, e_nome)
            VALUES (454,'LucasArts');
INSERT INTO editora (e_id, e_nome)
            VALUES (455,'Lump of Sugar');
INSERT INTO editora (e_id, e_nome)
            VALUES (456,'MacPlay');
INSERT INTO editora (e_id, e_nome)
            VALUES (457,'MacSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (458,'Mad Catz');
INSERT INTO editora (e_id, e_nome)
            VALUES (459,'Magical Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (460,'Mages ');
INSERT INTO editora (e_id, e_nome)
            VALUES (461,'Magnavox');
INSERT INTO editora (e_id, e_nome)
            VALUES (462,'Mr Chip Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (463,'magnussoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (464,'Mandarin Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (465,'MangaGamer');
INSERT INTO editora (e_id, e_nome)
            VALUES (466,'Martech');
INSERT INTO editora (e_id, e_nome)
            VALUES (467,'Majesco Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (468,'Marvelous');
INSERT INTO editora (e_id, e_nome)
            VALUES (469,'Marvelous Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (470,'Masaya');
INSERT INTO editora (e_id, e_nome)
            VALUES (471,'Mastertronic');
INSERT INTO editora (e_id, e_nome)
            VALUES (472,'Mastiff');
INSERT INTO editora (e_id, e_nome)
            VALUES (473,'Matrix Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (474,'Mattel');
INSERT INTO editora (e_id, e_nome)
            VALUES (475,'Maximum Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (476,'Maxis');
INSERT INTO editora (e_id, e_nome)
            VALUES (477,'Max Design');
INSERT INTO editora (e_id, e_nome)
            VALUES (478,'MC2 France');
INSERT INTO editora (e_id, e_nome)
            VALUES (479,'MC Lothlorien');
INSERT INTO editora (e_id, e_nome)
            VALUES (480,'MECC');
INSERT INTO editora (e_id, e_nome)
            VALUES (481,'MediaWorks');
INSERT INTO editora (e_id, e_nome)
            VALUES (482,'Media Factory');
INSERT INTO editora (e_id, e_nome)
            VALUES (483,'Media Rings');
INSERT INTO editora (e_id, e_nome)
            VALUES (484,'Mega Enterprise');
INSERT INTO editora (e_id, e_nome)
            VALUES (485,'Melbourne House');
INSERT INTO editora (e_id, e_nome)
            VALUES (486,'Meldac');
INSERT INTO editora (e_id, e_nome)
            VALUES (487,'Metro3D, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (488,'Metropolis Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (489,'MGM Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (490,'Microdeal');
INSERT INTO editora (e_id, e_nome)
            VALUES (491,'Microids');
INSERT INTO editora (e_id, e_nome)
            VALUES (492,'MicroIllusions');
INSERT INTO editora (e_id, e_nome)
            VALUES (493,'Micronet co., Ltd.');
INSERT INTO editora (e_id, e_nome)
            VALUES (494,'MicroProse');
INSERT INTO editora (e_id, e_nome)
            VALUES (495,'Microsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (496,'Microsphere');
INSERT INTO editora (e_id, e_nome)
            VALUES (497,'Microcabin');
INSERT INTO editora (e_id, e_nome)
            VALUES (498,'Micrografx');
INSERT INTO editora (e_id, e_nome)
            VALUES (499,'MicroGraphic Image');
INSERT INTO editora (e_id, e_nome)
            VALUES (500,'Micro Genius');
INSERT INTO editora (e_id, e_nome)
            VALUES (501,'Micro Power');
INSERT INTO editora (e_id, e_nome)
            VALUES (502,'Midway Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (503,'Midway Manufacturing');
INSERT INTO editora (e_id, e_nome)
            VALUES (504,'Mikro-Gen');
INSERT INTO editora (e_id, e_nome)
            VALUES (505,'MileStone Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (506,'Millennium Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (507,'Milton Bradley Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (508,'Minato Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (509,'Mindcraft');
INSERT INTO editora (e_id, e_nome)
            VALUES (510,'Mindscape');
INSERT INTO editora (e_id, e_nome)
            VALUES (511,'Minori');
INSERT INTO editora (e_id, e_nome)
            VALUES (512,'Mirrorsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (513,'Mitchell Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (514,'Mode 7 Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (515,'Modus Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (516,'Mojang');
INSERT INTO editora (e_id, e_nome)
            VALUES (517,'MonkeyPaw Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (518,'Monolith Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (519,'Monte Cristo');
INSERT INTO editora (e_id, e_nome)
            VALUES (520,'Moonstone');
INSERT INTO editora (e_id, e_nome)
            VALUES (521,'Mosaic Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (522,'MOSS');
INSERT INTO editora (e_id, e_nome)
            VALUES (523,'Motown Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (524,'Mountain King Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (525,'MTO');
INSERT INTO editora (e_id, e_nome)
            VALUES (526,'MTV Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (527,'Mud Duck Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (528,'Muse Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (529,'MumboJumbo');
INSERT INTO editora (e_id, e_nome)
            VALUES (530,'Mystique');
INSERT INTO editora (e_id, e_nome)
            VALUES (531,'Nacon ');
INSERT INTO editora (e_id, e_nome)
            VALUES (532,'Namco');
INSERT INTO editora (e_id, e_nome)
            VALUES (533,'Natsume Co Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (534,'Natsume Inc');
INSERT INTO editora (e_id, e_nome)
            VALUES (535,'Navel');
INSERT INTO editora (e_id, e_nome)
            VALUES (536,'Naxat Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (537,'NBCUniversal');
INSERT INTO editora (e_id, e_nome)
            VALUES (538,'NCsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (539,'NEC Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (540,'Neko Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (541,'Netdragon');
INSERT INTO editora (e_id, e_nome)
            VALUES (542,'Netease');
INSERT INTO editora (e_id, e_nome)
            VALUES (543,'New Generation Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (544,'NewKidCo');
INSERT INTO editora (e_id, e_nome)
            VALUES (545,'inXile Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (546,'iQue');
INSERT INTO editora (e_id, e_nome)
            VALUES (547,'Irem');
INSERT INTO editora (e_id, e_nome)
            VALUES (548,'ITE Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (549,'Jaleco');
INSERT INTO editora (e_id, e_nome)
            VALUES (550,'JAST USA');
INSERT INTO editora (e_id, e_nome)
            VALUES (551,'Jester Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (552,'Johnson & Johnson');
INSERT INTO editora (e_id, e_nome)
            VALUES (553,'JoWooD Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (554,'JumpStart Games ');
INSERT INTO editora (e_id, e_nome)
            VALUES (555,'K2 Network ');
INSERT INTO editora (e_id, e_nome)
            VALUES (556,'Kalisto Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (557,'Kalypso Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (558,'Kaneko');
INSERT INTO editora (e_id, e_nome)
            VALUES (559,'Kaypro');
INSERT INTO editora (e_id, e_nome)
            VALUES (560,'Kemco');
INSERT INTO editora (e_id, e_nome)
            VALUES (561,'King Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (562,'KID');
INSERT INTO editora (e_id, e_nome)
            VALUES (563,'Kingsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (564,'King Records');
INSERT INTO editora (e_id, e_nome)
            VALUES (565,'Koch Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (566,'Kodansha');
INSERT INTO editora (e_id, e_nome)
            VALUES (567,'Koei');
INSERT INTO editora (e_id, e_nome)
            VALUES (568,'Koei Tecmo');
INSERT INTO editora (e_id, e_nome)
            VALUES (569,'Kogado Studio');
INSERT INTO editora (e_id, e_nome)
            VALUES (570,'Konami');
INSERT INTO editora (e_id, e_nome)
            VALUES (571,'Krisalis Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (572,'KSS');
INSERT INTO editora (e_id, e_nome)
            VALUES (573,'Kure Software Koubou');
INSERT INTO editora (e_id, e_nome)
            VALUES (574,'Lankhor');
INSERT INTO editora (e_id, e_nome)
            VALUES (575,'Le Lombard');
INSERT INTO editora (e_id, e_nome)
            VALUES (576,'Legacy Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (577,'Legendo Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (578,'Legend Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (579,'Lego Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (580,'Leland Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (581,'Level-5');
INSERT INTO editora (e_id, e_nome)
            VALUES (582,'Level 9 Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (583,'Limited Run Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (584,'Linux Game Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (585,'Lighthouse Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (586,'LJN');
INSERT INTO editora (e_id, e_nome)
            VALUES (587,'LK Avalon');
INSERT INTO editora (e_id, e_nome)
            VALUES (588,'Llamasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (589,'Lock n Load Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (590,'Logotron Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (591,'Loki Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (592,'Loriciel');
INSERT INTO editora (e_id, e_nome)
            VALUES (593,'LucasArts');
INSERT INTO editora (e_id, e_nome)
            VALUES (594,'Lump of Sugar');
INSERT INTO editora (e_id, e_nome)
            VALUES (595,'MacPlay');
INSERT INTO editora (e_id, e_nome)
            VALUES (596,'MacSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (597,'Mad Catz');
INSERT INTO editora (e_id, e_nome)
            VALUES (598,'Magical Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (599,'Mages ');
INSERT INTO editora (e_id, e_nome)
            VALUES (600,'Magnavox');
INSERT INTO editora (e_id, e_nome)
            VALUES (601,'Mr Chip Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (602,'magnussoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (603,'Mandarin Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (604,'MangaGamer');
INSERT INTO editora (e_id, e_nome)
            VALUES (605,'Martech');
INSERT INTO editora (e_id, e_nome)
            VALUES (606,'Majesco Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (607,'Marvelous');
INSERT INTO editora (e_id, e_nome)
            VALUES (608,'Marvelous Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (609,'Masaya');
INSERT INTO editora (e_id, e_nome)
            VALUES (610,'Mastertronic');
INSERT INTO editora (e_id, e_nome)
            VALUES (611,'Mastiff');
INSERT INTO editora (e_id, e_nome)
            VALUES (612,'Matrix Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (613,'Mattel');
INSERT INTO editora (e_id, e_nome)
            VALUES (614,'Maximum Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (615,'Maxis');
INSERT INTO editora (e_id, e_nome)
            VALUES (616,'Max Design');
INSERT INTO editora (e_id, e_nome)
            VALUES (617,'MC2 France');
INSERT INTO editora (e_id, e_nome)
            VALUES (618,'MC Lothlorien');
INSERT INTO editora (e_id, e_nome)
            VALUES (619,'MECC');
INSERT INTO editora (e_id, e_nome)
            VALUES (620,'MediaWorks');
INSERT INTO editora (e_id, e_nome)
            VALUES (621,'Media Factory');
INSERT INTO editora (e_id, e_nome)
            VALUES (622,'Media Rings');
INSERT INTO editora (e_id, e_nome)
            VALUES (623,'Mega Enterprise');
INSERT INTO editora (e_id, e_nome)
            VALUES (624,'Melbourne House');
INSERT INTO editora (e_id, e_nome)
            VALUES (625,'Meldac');
INSERT INTO editora (e_id, e_nome)
            VALUES (626,'Metro3D, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (627,'Metropolis Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (628,'MGM Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (629,'Microdeal');
INSERT INTO editora (e_id, e_nome)
            VALUES (630,'Microids');
INSERT INTO editora (e_id, e_nome)
            VALUES (631,'MicroIllusions');
INSERT INTO editora (e_id, e_nome)
            VALUES (632,'Micronet co., Ltd.');
INSERT INTO editora (e_id, e_nome)
            VALUES (633,'MicroProse');
INSERT INTO editora (e_id, e_nome)
            VALUES (634,'Microsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (635,'Microsphere');
INSERT INTO editora (e_id, e_nome)
            VALUES (636,'Microcabin');
INSERT INTO editora (e_id, e_nome)
            VALUES (637,'Micrografx');
INSERT INTO editora (e_id, e_nome)
            VALUES (638,'MicroGraphic Image');
INSERT INTO editora (e_id, e_nome)
            VALUES (639,'Micro Genius');
INSERT INTO editora (e_id, e_nome)
            VALUES (640,'Micro Power');
INSERT INTO editora (e_id, e_nome)
            VALUES (641,'Midway Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (642,'Midway Manufacturing');
INSERT INTO editora (e_id, e_nome)
            VALUES (643,'Mikro-Gen');
INSERT INTO editora (e_id, e_nome)
            VALUES (644,'MileStone Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (645,'Millennium Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (646,'Milton Bradley Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (647,'Minato Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (648,'Mindcraft');
INSERT INTO editora (e_id, e_nome)
            VALUES (649,'Mindscape');
INSERT INTO editora (e_id, e_nome)
            VALUES (650,'Minori');
INSERT INTO editora (e_id, e_nome)
            VALUES (651,'Mirrorsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (652,'Mitchell Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (653,'Mode 7 Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (654,'Modus Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (655,'Mojang');
INSERT INTO editora (e_id, e_nome)
            VALUES (656,'MonkeyPaw Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (657,'Monolith Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (658,'Monte Cristo');
INSERT INTO editora (e_id, e_nome)
            VALUES (659,'Moonstone');
INSERT INTO editora (e_id, e_nome)
            VALUES (660,'Mosaic Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (661,'MOSS');
INSERT INTO editora (e_id, e_nome)
            VALUES (662,'Motown Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (663,'Mountain King Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (664,'MTO');
INSERT INTO editora (e_id, e_nome)
            VALUES (665,'MTV Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (666,'Mud Duck Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (667,'Muse Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (668,'MumboJumbo');
INSERT INTO editora (e_id, e_nome)
            VALUES (669,'Mystique');
INSERT INTO editora (e_id, e_nome)
            VALUES (670,'Nacon ');
INSERT INTO editora (e_id, e_nome)
            VALUES (671,'Namco');
INSERT INTO editora (e_id, e_nome)
            VALUES (672,'Natsume Co Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (673,'Natsume Inc');
INSERT INTO editora (e_id, e_nome)
            VALUES (674,'Navel');
INSERT INTO editora (e_id, e_nome)
            VALUES (675,'Naxat Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (676,'NBCUniversal');
INSERT INTO editora (e_id, e_nome)
            VALUES (677,'NCsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (678,'NEC Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (679,'Neko Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (680,'Netdragon');
INSERT INTO editora (e_id, e_nome)
            VALUES (681,'Netease');
INSERT INTO editora (e_id, e_nome)
            VALUES (682,'New Generation Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (683,'NewKidCo');
INSERT INTO editora (e_id, e_nome)
            VALUES (684,'New World Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (685,'Nexon');
INSERT INTO editora (e_id, e_nome)
            VALUES (686,'Nihon Falcom');
INSERT INTO editora (e_id, e_nome)
            VALUES (687,'Nintendo');
INSERT INTO editora (e_id, e_nome)
            VALUES (688,'Nippon Ichi Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (689,'Nihon Bussan');
INSERT INTO editora (e_id, e_nome)
            VALUES (690,'Nitroplus');
INSERT INTO editora (e_id, e_nome)
            VALUES (691,'Novagen Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (692,'Nokia');
INSERT INTO editora (e_id, e_nome)
            VALUES (693,'Nordcurrent');
INSERT INTO editora (e_id, e_nome)
            VALUES (694,'NovaLogic');
INSERT INTO editora (e_id, e_nome)
            VALUES (695,'NTDEC');
INSERT INTO editora (e_id, e_nome)
            VALUES (696,'Nutting Associates');
INSERT INTO editora (e_id, e_nome)
            VALUES (697,'O3 Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (698,'Ocean Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (699,'Ocean State Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (700,'Oculus Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (701,'Odin Computer Graphics');
INSERT INTO editora (e_id, e_nome)
            VALUES (702,'Opera Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (703,'Orbital Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (704,'Origin Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (705,'Orion Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (706,'Out of the Park Developments');
INSERT INTO editora (e_id, e_nome)
            VALUES (707,'0verflow');
INSERT INTO editora (e_id, e_nome)
            VALUES (708,'Oxygen Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (709,'OziSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (710,'Pacific Novelty');
INSERT INTO editora (e_id, e_nome)
            VALUES (711,'Pack-In-Video');
INSERT INTO editora (e_id, e_nome)
            VALUES (712,'Palace Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (713,'Palette');
INSERT INTO editora (e_id, e_nome)
            VALUES (714,'Panasonic');
INSERT INTO editora (e_id, e_nome)
            VALUES (715,'Panda Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (716,'Panesian Taiwan');
INSERT INTO editora (e_id, e_nome)
            VALUES (717,'Panther Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (718,'Panther Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (719,'Paradox Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (720,'Paragon Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (721,'Parker Brothers');
INSERT INTO editora (e_id, e_nome)
            VALUES (722,'Parsoft Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (723,'Penguin Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (724,'Pentavision');
INSERT INTO editora (e_id, e_nome)
            VALUES (725,'Perfect World');
INSERT INTO editora (e_id, e_nome)
            VALUES (726,'Personal Software Services');
INSERT INTO editora (e_id, e_nome)
            VALUES (727,'Petit Ferret');
INSERT INTO editora (e_id, e_nome)
            VALUES (728,'Petroglyph Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (729,'PF Magic');
INSERT INTO editora (e_id, e_nome)
            VALUES (730,'Phantagram');
INSERT INTO editora (e_id, e_nome)
            VALUES (731,'Philips');
INSERT INTO editora (e_id, e_nome)
            VALUES (732,'Pionesoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (733,'Piranha Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (734,'Piranha Interactive Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (735,'PlayFirst');
INSERT INTO editora (e_id, e_nome)
            VALUES (736,'Playlogic Entertainment, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (737,'Playmates Toys');
INSERT INTO editora (e_id, e_nome)
            VALUES (738,'The Pokémon Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (739,'Pony Canyon');
INSERT INTO editora (e_id, e_nome)
            VALUES (740,'PopCap Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (741,'Portkey Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (742,'Positech Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (743,'Presto Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (744,'PrincessSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (745,'Prism Leisure Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (746,'Private Division');
INSERT INTO editora (e_id, e_nome)
            VALUES (747,'Probe Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (748,'Programma International');
INSERT INTO editora (e_id, e_nome)
            VALUES (749,'Prototype');
INSERT INTO editora (e_id, e_nome)
            VALUES (750,'Psygnosis');
INSERT INTO editora (e_id, e_nome)
            VALUES (751,'Psikyo');
INSERT INTO editora (e_id, e_nome)
            VALUES (752,'Psytronik Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (753,'Pulltop');
INSERT INTO editora (e_id, e_nome)
            VALUES (754,'Purple Moon');
INSERT INTO editora (e_id, e_nome)
            VALUES (755,'Quality Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (756,'Quantum Axcess');
INSERT INTO editora (e_id, e_nome)
            VALUES (757,'Quantum Quality Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (758,'Quest Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (759,'Quicksilva');
INSERT INTO editora (e_id, e_nome)
            VALUES (760,'QuinRose');
INSERT INTO editora (e_id, e_nome)
            VALUES (761,'Quintet');
INSERT INTO editora (e_id, e_nome)
            VALUES (762,'Qute');
INSERT INTO editora (e_id, e_nome)
            VALUES (763,'Q Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (764,'R2Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (765,'Rabbit Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (766,'Radica Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (767,'Rage Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (768,'Rainbird Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (769,'Rainbow Arts');
INSERT INTO editora (e_id, e_nome)
            VALUES (770,'Random House');
INSERT INTO editora (e_id, e_nome)
            VALUES (771,'Rare');
INSERT INTO editora (e_id, e_nome)
            VALUES (772,'Ravensburger Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (773,'Raw Fury');
INSERT INTO editora (e_id, e_nome)
            VALUES (774,'Raw Thrills');
INSERT INTO editora (e_id, e_nome)
            VALUES (775,'Red Ant Enterprises');
INSERT INTO editora (e_id, e_nome)
            VALUES (776,'Red Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (777,'RedOctane');
INSERT INTO editora (e_id, e_nome)
            VALUES (778,'Red Orb Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (779,'Red Shift');
INSERT INTO editora (e_id, e_nome)
            VALUES (780,'Red Storm Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (781,'Regista');
INSERT INTO editora (e_id, e_nome)
            VALUES (782,'reLINE Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (783,'Renegade Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (784,'Renovation Products');
INSERT INTO editora (e_id, e_nome)
            VALUES (785,'Richard Shepherd Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (786,'Right Stuff');
INSERT INTO editora (e_id, e_nome)
            VALUES (787,'Riot Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (788,'Ripcord Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (789,'Rising Star Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (790,'Riverhillsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (791,'Rock-Ola');
INSERT INTO editora (e_id, e_nome)
            VALUES (792,'Rockstar Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (793,'Romstar');
INSERT INTO editora (e_id, e_nome)
            VALUES (794,'Romtech');
INSERT INTO editora (e_id, e_nome)
            VALUES (795,'Rovio Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (796,'RTL Group');
INSERT INTO editora (e_id, e_nome)
            VALUES (797,'RuneSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (798,'Saga Planets');
INSERT INTO editora (e_id, e_nome)
            VALUES (799,'Sammy Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (800,'Samsung');
INSERT INTO editora (e_id, e_nome)
            VALUES (801,'Sanctuary Woods');
INSERT INTO editora (e_id, e_nome)
            VALUES (802,'Scavenger, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (803,'Scopely');
INSERT INTO editora (e_id, e_nome)
            VALUES (804,'SCi Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (805,'SCS Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (806,'Safari Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (807,'Scholastic');
INSERT INTO editora (e_id, e_nome)
            VALUES (808,'Sears');
INSERT INTO editora (e_id, e_nome)
            VALUES (809,'Sega');
INSERT INTO editora (e_id, e_nome)
            VALUES (810,'Seibu Kaihatsu');
INSERT INTO editora (e_id, e_nome)
            VALUES (811,'Serenity Forge');
INSERT INTO editora (e_id, e_nome)
            VALUES (812,'SETA Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (813,'Seven45 Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (814,'Shadow Tor Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (815,'Shanda');
INSERT INTO editora (e_id, e_nome)
            VALUES (816,'Sharp Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (817,'Shengqu Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (818,'Sherston Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (819,'Shoeisha');
INSERT INTO editora (e_id, e_nome)
            VALUES (820,'Shogakukan');
INSERT INTO editora (e_id, e_nome)
            VALUES (821,'New World Computing');
INSERT INTO editora (e_id, e_nome)
            VALUES (822,'Nexon');
INSERT INTO editora (e_id, e_nome)
            VALUES (823,'Nihon Falcom');
INSERT INTO editora (e_id, e_nome)
            VALUES (824,'Nintendo');
INSERT INTO editora (e_id, e_nome)
            VALUES (825,'Nippon Ichi Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (826,'Nihon Bussan');
INSERT INTO editora (e_id, e_nome)
            VALUES (827,'Nitroplus');
INSERT INTO editora (e_id, e_nome)
            VALUES (828,'Novagen Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (829,'Nokia');
INSERT INTO editora (e_id, e_nome)
            VALUES (830,'Nordcurrent');
INSERT INTO editora (e_id, e_nome)
            VALUES (831,'NovaLogic');
INSERT INTO editora (e_id, e_nome)
            VALUES (832,'NTDEC');
INSERT INTO editora (e_id, e_nome)
            VALUES (833,'Nutting Associates');
INSERT INTO editora (e_id, e_nome)
            VALUES (834,'O3 Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (835,'Ocean Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (836,'Ocean State Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (837,'Oculus Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (838,'Odin Computer Graphics');
INSERT INTO editora (e_id, e_nome)
            VALUES (839,'Opera Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (840,'Orbital Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (841,'Origin Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (842,'Orion Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (843,'Out of the Park Developments');
INSERT INTO editora (e_id, e_nome)
            VALUES (844,'0verflow');
INSERT INTO editora (e_id, e_nome)
            VALUES (845,'Oxygen Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (846,'OziSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (847,'Pacific Novelty');
INSERT INTO editora (e_id, e_nome)
            VALUES (848,'Pack-In-Video');
INSERT INTO editora (e_id, e_nome)
            VALUES (849,'Palace Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (850,'Palette');
INSERT INTO editora (e_id, e_nome)
            VALUES (851,'Panasonic');
INSERT INTO editora (e_id, e_nome)
            VALUES (852,'Panda Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (853,'Panesian Taiwan');
INSERT INTO editora (e_id, e_nome)
            VALUES (854,'Panther Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (855,'Panther Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (856,'Paradox Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (857,'Paragon Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (858,'Parker Brothers');
INSERT INTO editora (e_id, e_nome)
            VALUES (859,'Parsoft Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (860,'Penguin Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (861,'Pentavision');
INSERT INTO editora (e_id, e_nome)
            VALUES (862,'Perfect World');
INSERT INTO editora (e_id, e_nome)
            VALUES (863,'Personal Software Services');
INSERT INTO editora (e_id, e_nome)
            VALUES (864,'Petit Ferret');
INSERT INTO editora (e_id, e_nome)
            VALUES (865,'Petroglyph Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (866,'PF Magic');
INSERT INTO editora (e_id, e_nome)
            VALUES (867,'Phantagram');
INSERT INTO editora (e_id, e_nome)
            VALUES (868,'Philips');
INSERT INTO editora (e_id, e_nome)
            VALUES (869,'Pionesoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (870,'Piranha Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (871,'Piranha Interactive Publishing');
INSERT INTO editora (e_id, e_nome)
            VALUES (872,'PlayFirst');
INSERT INTO editora (e_id, e_nome)
            VALUES (873,'Playlogic Entertainment, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (874,'Playmates Toys');
INSERT INTO editora (e_id, e_nome)
            VALUES (875,'The Pokémon Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (876,'Pony Canyon');
INSERT INTO editora (e_id, e_nome)
            VALUES (877,'PopCap Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (878,'Portkey Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (879,'Positech Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (880,'Presto Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (881,'PrincessSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (882,'Prism Leisure Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (883,'Private Division');
INSERT INTO editora (e_id, e_nome)
            VALUES (884,'Probe Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (885,'Programma International');
INSERT INTO editora (e_id, e_nome)
            VALUES (886,'Prototype');
INSERT INTO editora (e_id, e_nome)
            VALUES (887,'Psygnosis');
INSERT INTO editora (e_id, e_nome)
            VALUES (888,'Psikyo');
INSERT INTO editora (e_id, e_nome)
            VALUES (889,'Psytronik Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (890,'Pulltop');
INSERT INTO editora (e_id, e_nome)
            VALUES (891,'Purple Moon');
INSERT INTO editora (e_id, e_nome)
            VALUES (892,'Quality Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (893,'Quantum Axcess');
INSERT INTO editora (e_id, e_nome)
            VALUES (894,'Quantum Quality Productions');
INSERT INTO editora (e_id, e_nome)
            VALUES (895,'Quest Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (896,'Quicksilva');
INSERT INTO editora (e_id, e_nome)
            VALUES (897,'QuinRose');
INSERT INTO editora (e_id, e_nome)
            VALUES (898,'Quintet');
INSERT INTO editora (e_id, e_nome)
            VALUES (899,'Qute');
INSERT INTO editora (e_id, e_nome)
            VALUES (900,'Q Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (901,'R2Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (902,'Rabbit Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (903,'Radica Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (904,'Rage Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (905,'Rainbird Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (906,'Rainbow Arts');
INSERT INTO editora (e_id, e_nome)
            VALUES (907,'Random House');
INSERT INTO editora (e_id, e_nome)
            VALUES (908,'Rare');
INSERT INTO editora (e_id, e_nome)
            VALUES (909,'Ravensburger Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (910,'Raw Fury');
INSERT INTO editora (e_id, e_nome)
            VALUES (911,'Raw Thrills');
INSERT INTO editora (e_id, e_nome)
            VALUES (912,'Red Ant Enterprises');
INSERT INTO editora (e_id, e_nome)
            VALUES (913,'Red Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (914,'RedOctane');
INSERT INTO editora (e_id, e_nome)
            VALUES (915,'Red Orb Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (916,'Red Shift');
INSERT INTO editora (e_id, e_nome)
            VALUES (917,'Red Storm Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (918,'Regista');
INSERT INTO editora (e_id, e_nome)
            VALUES (919,'reLINE Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (920,'Renegade Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (921,'Renovation Products');
INSERT INTO editora (e_id, e_nome)
            VALUES (922,'Richard Shepherd Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (923,'Right Stuff');
INSERT INTO editora (e_id, e_nome)
            VALUES (924,'Riot Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (925,'Ripcord Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (926,'Rising Star Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (927,'Riverhillsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (928,'Rock-Ola');
INSERT INTO editora (e_id, e_nome)
            VALUES (929,'Rockstar Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (930,'Romstar');
INSERT INTO editora (e_id, e_nome)
            VALUES (931,'Romtech');
INSERT INTO editora (e_id, e_nome)
            VALUES (932,'Rovio Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (933,'RTL Group');
INSERT INTO editora (e_id, e_nome)
            VALUES (934,'RuneSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (935,'Saga Planets');
INSERT INTO editora (e_id, e_nome)
            VALUES (936,'Sammy Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (937,'Samsung');
INSERT INTO editora (e_id, e_nome)
            VALUES (938,'Sanctuary Woods');
INSERT INTO editora (e_id, e_nome)
            VALUES (939,'Scavenger, Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (940,'Scopely');
INSERT INTO editora (e_id, e_nome)
            VALUES (941,'SCi Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (942,'SCS Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (943,'Safari Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (944,'Scholastic');
INSERT INTO editora (e_id, e_nome)
            VALUES (945,'Sears');
INSERT INTO editora (e_id, e_nome)
            VALUES (946,'Sega');
INSERT INTO editora (e_id, e_nome)
            VALUES (947,'Seibu Kaihatsu');
INSERT INTO editora (e_id, e_nome)
            VALUES (948,'Serenity Forge');
INSERT INTO editora (e_id, e_nome)
            VALUES (949,'SETA Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (950,'Seven45 Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (951,'Shadow Tor Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (952,'Shanda');
INSERT INTO editora (e_id, e_nome)
            VALUES (953,'Sharp Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (954,'Shengqu Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (955,'Sherston Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (956,'Shoeisha');
INSERT INTO editora (e_id, e_nome)
            VALUES (957,'Shogakukan');
INSERT INTO editora (e_id, e_nome)
            VALUES (958,'Sierra Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (959,'Silicon Beach Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (960,'Silmarils');
INSERT INTO editora (e_id, e_nome)
            VALUES (961,'Simon & Schuster Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (962,'SIMS Co., Ltd.');
INSERT INTO editora (e_id, e_nome)
            VALUES (963,'Simulations Canada');
INSERT INTO editora (e_id, e_nome)
            VALUES (964,'Sinclair Research Ltd.');
INSERT INTO editora (e_id, e_nome)
            VALUES (965,'Sirius Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (966,'Sir-Tech');
INSERT INTO editora (e_id, e_nome)
            VALUES (967,'Slitherine');
INSERT INTO editora (e_id, e_nome)
            VALUES (968,'SNK');
INSERT INTO editora (e_id, e_nome)
            VALUES (969,'Soedesco');
INSERT INTO editora (e_id, e_nome)
            VALUES (970,'SOFEL');
INSERT INTO editora (e_id, e_nome)
            VALUES (971,'Soft-World');
INSERT INTO editora (e_id, e_nome)
            VALUES (972,'Softape');
INSERT INTO editora (e_id, e_nome)
            VALUES (973,'Softdisk');
INSERT INTO editora (e_id, e_nome)
            VALUES (974,'SoftKey');
INSERT INTO editora (e_id, e_nome)
            VALUES (975,'Softek International Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (976,'SoftSide');
INSERT INTO editora (e_id, e_nome)
            VALUES (977,'Softstar');
INSERT INTO editora (e_id, e_nome)
            VALUES (978,'Software 2000');
INSERT INTO editora (e_id, e_nome)
            VALUES (979,'Software Dynamics');
INSERT INTO editora (e_id, e_nome)
            VALUES (980,'Software Projects');
INSERT INTO editora (e_id, e_nome)
            VALUES (981,'Sony Imagesoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (982,'Sony Interactive Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (983,'Sony Pictures Digital');
INSERT INTO editora (e_id, e_nome)
            VALUES (984,'SouthPeak Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (985,'Spectral Associates');
INSERT INTO editora (e_id, e_nome)
            VALUES (986,'Spectravideo');
INSERT INTO editora (e_id, e_nome)
            VALUES (987,'Spectrum HoloByte');
INSERT INTO editora (e_id, e_nome)
            VALUES (988,'Spike');
INSERT INTO editora (e_id, e_nome)
            VALUES (989,'Spike Chunsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (990,'Spil Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (991,'Spinnaker Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (992,'Square');
INSERT INTO editora (e_id, e_nome)
            VALUES (993,'Square Electronic Arts');
INSERT INTO editora (e_id, e_nome)
            VALUES (994,'Square Enix');
INSERT INTO editora (e_id, e_nome)
            VALUES (995,'Square Enix Europe');
INSERT INTO editora (e_id, e_nome)
            VALUES (996,'Stardock');
INSERT INTO editora (e_id, e_nome)
            VALUES (997,'Starpath');
INSERT INTO editora (e_id, e_nome)
            VALUES (998,'Stern Electronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (999,'Sting Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (1000,'Storm Impact');
INSERT INTO editora (e_id, e_nome)
            VALUES (1001,'Strategic Simulations ');
INSERT INTO editora (e_id, e_nome)
            VALUES (1002,'Strategic Studies Group');
INSERT INTO editora (e_id, e_nome)
            VALUES (1003,'Strat-O-Matic');
INSERT INTO editora (e_id, e_nome)
            VALUES (1004,'Stormfront Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (1005,'Strategy First');
INSERT INTO editora (e_id, e_nome)
            VALUES (1006,'Studio e.go!');
INSERT INTO editora (e_id, e_nome)
            VALUES (1007,'Sublogic');
INSERT INTO editora (e_id, e_nome)
            VALUES (1008,'Success');
INSERT INTO editora (e_id, e_nome)
            VALUES (1009,'Sunflowers Interactive Entertainment Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1010,'Sunrise Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1011,'Sunsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1012,'Superior Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1013,'Supersoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1014,'Sydney Development Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (1015,'Super Fighter Team');
INSERT INTO editora (e_id, e_nome)
            VALUES (1016,'Suzy Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1017,'Synapse Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1018,'Synergistic Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1019,'SystemSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1020,'System 3');
INSERT INTO editora (e_id, e_nome)
            VALUES (1021,'System Sacom');
INSERT INTO editora (e_id, e_nome)
            VALUES (1022,'Tactics');
INSERT INTO editora (e_id, e_nome)
            VALUES (1023,'Taito');
INSERT INTO editora (e_id, e_nome)
            VALUES (1024,'Takara');
INSERT INTO editora (e_id, e_nome)
            VALUES (1025,'Take-Two Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1026,'TalonSoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1027,'Tamsoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1028,'Tandy Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (1029,'Taxan');
INSERT INTO editora (e_id, e_nome)
            VALUES (1030,'TDK Mediactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1031,'Team17');
INSERT INTO editora (e_id, e_nome)
            VALUES (1032,'Team Shanghai Alice');
INSERT INTO editora (e_id, e_nome)
            VALUES (1033,'Techland');
INSERT INTO editora (e_id, e_nome)
            VALUES (1034,'Technical Group Laboratory');
INSERT INTO editora (e_id, e_nome)
            VALUES (1035,'Technology and Entertainment Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1036,'Technosoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1037,'Technos Japan');
INSERT INTO editora (e_id, e_nome)
            VALUES (1038,'TecMagik');
INSERT INTO editora (e_id, e_nome)
            VALUES (1039,'Tecmo');
INSERT INTO editora (e_id, e_nome)
            VALUES (1040,'Tectoy');
INSERT INTO editora (e_id, e_nome)
            VALUES (1041,'Telarium');
INSERT INTO editora (e_id, e_nome)
            VALUES (1042,'Telesys');
INSERT INTO editora (e_id, e_nome)
            VALUES (1043,'Telenet Japan');
INSERT INTO editora (e_id, e_nome)
            VALUES (1044,'Telltale Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1045,'Tencent');
INSERT INTO editora (e_id, e_nome)
            VALUES (1046,'Tengen');
INSERT INTO editora (e_id, e_nome)
            VALUES (1047,'Texas Instruments');
INSERT INTO editora (e_id, e_nome)
            VALUES (1048,'Thalamus Ltd');
INSERT INTO editora (e_id, e_nome)
            VALUES (1049,'Thalion Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1050,'The9');
INSERT INTO editora (e_id, e_nome)
            VALUES (1051,'The Learning Company');
INSERT INTO editora (e_id, e_nome)
            VALUES (1052,'Thin Chen Enterprise');
INSERT INTO editora (e_id, e_nome)
            VALUES (1053,'Thinking Rabbit');
INSERT INTO editora (e_id, e_nome)
            VALUES (1054,'THQ');
INSERT INTO editora (e_id, e_nome)
            VALUES (1055,'THQ Nordic');
INSERT INTO editora (e_id, e_nome)
            VALUES (1056,'Thorn EMI Computer Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1057,'Three-Sixty Pacific');
INSERT INTO editora (e_id, e_nome)
            VALUES (1058,'Tiertex Design Studios');
INSERT INTO editora (e_id, e_nome)
            VALUES (1059,'Tiger Electronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (1060,'Time Warner Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1061,'Titus Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1062,'Toaplan');
INSERT INTO editora (e_id, e_nome)
            VALUES (1063,'Toei Animation');
INSERT INTO editora (e_id, e_nome)
            VALUES (1064,'Toho');
INSERT INTO editora (e_id, e_nome)
            VALUES (1065,'Tokuma Shoten');
INSERT INTO editora (e_id, e_nome)
            VALUES (1066,'Tokyo Shoseki');
INSERT INTO editora (e_id, e_nome)
            VALUES (1067,'Tomy ');
INSERT INTO editora (e_id, e_nome)
            VALUES (1068,'Tommo');
INSERT INTO editora (e_id, e_nome)
            VALUES (1069,'Tonkin House');
INSERT INTO editora (e_id, e_nome)
            VALUES (1070,'Topologika');
INSERT INTO editora (e_id, e_nome)
            VALUES (1071,'Topo Soft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1072,'TopWare Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1073,'Toshiba EMI');
INSERT INTO editora (e_id, e_nome)
            VALUES (1074,'Towa Chiki');
INSERT INTO editora (e_id, e_nome)
            VALUES (1075,'Tradewest');
INSERT INTO editora (e_id, e_nome)
            VALUES (1076,'Treco');
INSERT INTO editora (e_id, e_nome)
            VALUES (1077,'Triangle Service');
INSERT INTO editora (e_id, e_nome)
            VALUES (1078,'Triffix Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (1079,'Trilobyte Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1080,'Tripwire Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1081,'Tri Synergy');
INSERT INTO editora (e_id, e_nome)
            VALUES (1082,'Tru Blu Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (1083,'Tsunami Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1084,'TT Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1085,'Twilight Frontier');
INSERT INTO editora (e_id, e_nome)
            VALUES (1086,'Tynesoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1087,'Type-Moon');
INSERT INTO editora (e_id, e_nome)
            VALUES (1088,'Ubisoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1089,'UEP Systems');
INSERT INTO editora (e_id, e_nome)
            VALUES (1090,'UFO Interactive Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1091,'Ultimate Play the Game');
INSERT INTO editora (e_id, e_nome)
            VALUES (1092,'Ultrasoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1093,'Ultra Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1094,'United States Army');
INSERT INTO editora (e_id, e_nome)
            VALUES (1095,'Universal Entertainment Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (1096,'UserJoy Technology');
INSERT INTO editora (e_id, e_nome)
            VALUES (1097,'US Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1098,'Valcon Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1099,'Valve');
INSERT INTO editora (e_id, e_nome)
            VALUES (1100,'VAP');
INSERT INTO editora (e_id, e_nome)
            VALUES (1101,'Varie');
INSERT INTO editora (e_id, e_nome)
            VALUES (1102,'VEB Polytechnik');
INSERT INTO editora (e_id, e_nome)
            VALUES (1103,'Vectorbeam');
INSERT INTO editora (e_id, e_nome)
            VALUES (1104,'Viacom');
INSERT INTO editora (e_id, e_nome)
            VALUES (1105,'Victor Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1106,'Vic Tokai');
INSERT INTO editora (e_id, e_nome)
            VALUES (1107,'Virgin Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1108,'Virgin Play');
INSERT INTO editora (e_id, e_nome)
            VALUES (1109,'Virtual Programming');
INSERT INTO editora (e_id, e_nome)
            VALUES (1110,'Visco Corporation');
INSERT INTO editora (e_id, e_nome)
            VALUES (1111,'The Vision Factory');
INSERT INTO editora (e_id, e_nome)
            VALUES (1112,'VisualArts');
INSERT INTO editora (e_id, e_nome)
            VALUES (1113,'Vivarium Inc.');
INSERT INTO editora (e_id, e_nome)
            VALUES (1114,'Vivendi Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1115,'Vortex Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1116,'VoxelStorm');
INSERT INTO editora (e_id, e_nome)
            VALUES (1117,'Vulcan Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1118,'Wales Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1119,'Walnut Creek CDROM');
INSERT INTO editora (e_id, e_nome)
            VALUES (1120,'Wanadoo Edition');
INSERT INTO editora (e_id, e_nome)
            VALUES (1121,'Warashi');
INSERT INTO editora (e_id, e_nome)
            VALUES (1122,'Wargaming');
INSERT INTO editora (e_id, e_nome)
            VALUES (1123,'Warner Bros. Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1124,'WARP');
INSERT INTO editora (e_id, e_nome)
            VALUES (1125,'Webfoot Technologies');
INSERT INTO editora (e_id, e_nome)
            VALUES (1126,'Webzen');
INSERT INTO editora (e_id, e_nome)
            VALUES (1127,'WildTangent');
INSERT INTO editora (e_id, e_nome)
            VALUES (1128,'Williams Electronics');
INSERT INTO editora (e_id, e_nome)
            VALUES (1129,'Windham Classics');
INSERT INTO editora (e_id, e_nome)
            VALUES (1130,'Windmill');
INSERT INTO editora (e_id, e_nome)
            VALUES (1131,'Windmill Software');
INSERT INTO editora (e_id, e_nome)
            VALUES (1132,'Winkysoft');
INSERT INTO editora (e_id, e_nome)
            VALUES (1133,'Wisdom Tree');
INSERT INTO editora (e_id, e_nome)
            VALUES (1134,'WizardWorks');
INSERT INTO editora (e_id, e_nome)
            VALUES (1135,'Wolf Team');
INSERT INTO editora (e_id, e_nome)
            VALUES (1136,'Working Designs');
INSERT INTO editora (e_id, e_nome)
            VALUES (1137,'Xicat Interactive');
INSERT INTO editora (e_id, e_nome)
            VALUES (1138,'Xonox');
INSERT INTO editora (e_id, e_nome)
            VALUES (1139,'Xseed Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1140,'XS Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1141,'Yeti');
INSERT INTO editora (e_id, e_nome)
            VALUES (1142,'Yojigen');
INSERT INTO editora (e_id, e_nome)
            VALUES (1143,'Yonezawa PR21');
INSERT INTO editora (e_id, e_nome)
            VALUES (1144,'Yukes');
INSERT INTO editora (e_id, e_nome)
            VALUES (1145,'Yutaka');
INSERT INTO editora (e_id, e_nome)
            VALUES (1146,'Zaccaria');
INSERT INTO editora (e_id, e_nome)
            VALUES (1147,'ZAPiT Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1148,'ZeniMax Media');
INSERT INTO editora (e_id, e_nome)
            VALUES (1149,'Zenobi');
INSERT INTO editora (e_id, e_nome)
            VALUES (1150,'Zeppelin Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1151,'Zigurat');
INSERT INTO editora (e_id, e_nome)
            VALUES (1152,'Zimag');
INSERT INTO editora (e_id, e_nome)
            VALUES (1153,'Zoom');
INSERT INTO editora (e_id, e_nome)
            VALUES (1154,'Zuxxez Entertainment');
INSERT INTO editora (e_id, e_nome)
            VALUES (1155,'Zushi Games');
INSERT INTO editora (e_id, e_nome)
            VALUES (1156,'Zynga');
INSERT INTO editora (e_id, e_nome)
            VALUES (1157,'ZyX');
INSERT INTO sistema_operativo (s_id, s_nome)
            VALUES (1,'linux');
INSERT INTO sistema_operativo (s_id, s_nome)
            VALUES (2,'mac');
INSERT INTO sistema_operativo (s_id, s_nome)
            VALUES (3,'windows');
INSERT INTO categorias (c_id, c_nome)
            VALUES (1,'Indie');
INSERT INTO categorias (c_id, c_nome)
            VALUES (2,'Action');
INSERT INTO categorias (c_id, c_nome)
            VALUES (3,'Adventure');
INSERT INTO categorias (c_id, c_nome)
            VALUES (4,'Casual');
INSERT INTO categorias (c_id, c_nome)
            VALUES (5,'Simulation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (6,'Strategy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (7,'RPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (8,'Singleplayer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (9,'Early Access');
INSERT INTO categorias (c_id, c_nome)
            VALUES (10,'Free to Play');
INSERT INTO categorias (c_id, c_nome)
            VALUES (11,'2D');
INSERT INTO categorias (c_id, c_nome)
            VALUES (12,'Atmospheric');
INSERT INTO categorias (c_id, c_nome)
            VALUES (13,'Violent');
INSERT INTO categorias (c_id, c_nome)
            VALUES (14,'Massively Multiplayer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (15,'Sports');
INSERT INTO categorias (c_id, c_nome)
            VALUES (16,'Multiplayer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (17,'Puzzle');
INSERT INTO categorias (c_id, c_nome)
            VALUES (18,'3D');
INSERT INTO categorias (c_id, c_nome)
            VALUES (19,'Story Rich');
INSERT INTO categorias (c_id, c_nome)
            VALUES (20,'Fantasy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (21,'Pixel Graphics');
INSERT INTO categorias (c_id, c_nome)
            VALUES (22,'Colorful');
INSERT INTO categorias (c_id, c_nome)
            VALUES (23,'Racing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (24,'Nudity');
INSERT INTO categorias (c_id, c_nome)
            VALUES (25,'Gore');
INSERT INTO categorias (c_id, c_nome)
            VALUES (26,'Exploration');
INSERT INTO categorias (c_id, c_nome)
            VALUES (27,'Sexual Content');
INSERT INTO categorias (c_id, c_nome)
            VALUES (28,'Cute');
INSERT INTO categorias (c_id, c_nome)
            VALUES (29,'Anime');
INSERT INTO categorias (c_id, c_nome)
            VALUES (30,'First-Person');
INSERT INTO categorias (c_id, c_nome)
            VALUES (31,'Funny');
INSERT INTO categorias (c_id, c_nome)
            VALUES (32,'Sci-fi');
INSERT INTO categorias (c_id, c_nome)
            VALUES (33,'Arcade');
INSERT INTO categorias (c_id, c_nome)
            VALUES (34,'Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (35,'Horror');
INSERT INTO categorias (c_id, c_nome)
            VALUES (36,'Family Friendly');
INSERT INTO categorias (c_id, c_nome)
            VALUES (37,'Retro');
INSERT INTO categorias (c_id, c_nome)
            VALUES (38,'Relaxing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (39,'Action-Adventure');
INSERT INTO categorias (c_id, c_nome)
            VALUES (40,'Great Soundtrack');
INSERT INTO categorias (c_id, c_nome)
            VALUES (41,'Open World');
INSERT INTO categorias (c_id, c_nome)
            VALUES (42,'Platformer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (43,'Co-op');
INSERT INTO categorias (c_id, c_nome)
            VALUES (44,'Survival');
INSERT INTO categorias (c_id, c_nome)
            VALUES (45,'Combat');
INSERT INTO categorias (c_id, c_nome)
            VALUES (46,'Female Protagonist');
INSERT INTO categorias (c_id, c_nome)
            VALUES (47,'Third Person');
INSERT INTO categorias (c_id, c_nome)
            VALUES (48,'Difficult');
INSERT INTO categorias (c_id, c_nome)
            VALUES (49,'VR');
INSERT INTO categorias (c_id, c_nome)
            VALUES (50,'Comedy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (51,'Stylized');
INSERT INTO categorias (c_id, c_nome)
            VALUES (52,'PvP');
INSERT INTO categorias (c_id, c_nome)
            VALUES (53,'Old School');
INSERT INTO categorias (c_id, c_nome)
            VALUES (54,'FPS');
INSERT INTO categorias (c_id, c_nome)
            VALUES (55,'Visual Novel');
INSERT INTO categorias (c_id, c_nome)
            VALUES (56,'Choices Matter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (57,'Controller');
INSERT INTO categorias (c_id, c_nome)
            VALUES (58,'Realistic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (59,'Online Co-Op');
INSERT INTO categorias (c_id, c_nome)
            VALUES (60,'Physics');
INSERT INTO categorias (c_id, c_nome)
            VALUES (61,'Top-Down');
INSERT INTO categorias (c_id, c_nome)
            VALUES (62,'Dark');
INSERT INTO categorias (c_id, c_nome)
            VALUES (63,'Character Customization');
INSERT INTO categorias (c_id, c_nome)
            VALUES (64,'Mystery');
INSERT INTO categorias (c_id, c_nome)
            VALUES (65,'Sandbox');
INSERT INTO categorias (c_id, c_nome)
            VALUES (66,'Cartoony');
INSERT INTO categorias (c_id, c_nome)
            VALUES (67,'Multiple Endings');
INSERT INTO categorias (c_id, c_nome)
            VALUES (68,'Psychological Horror');
INSERT INTO categorias (c_id, c_nome)
            VALUES (69,'Shoot Em Up');
INSERT INTO categorias (c_id, c_nome)
            VALUES (70,'Tactical');
INSERT INTO categorias (c_id, c_nome)
            VALUES (71,'2D Platformer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (72,'Design & Illustration');
INSERT INTO categorias (c_id, c_nome)
            VALUES (73,'PvE');
INSERT INTO categorias (c_id, c_nome)
            VALUES (74,'Minimalist');
INSERT INTO categorias (c_id, c_nome)
            VALUES (75,'Space');
INSERT INTO categorias (c_id, c_nome)
            VALUES (76,'Linear');
INSERT INTO categorias (c_id, c_nome)
            VALUES (77,'Building');
INSERT INTO categorias (c_id, c_nome)
            VALUES (78,'Point & Click');
INSERT INTO categorias (c_id, c_nome)
            VALUES (79,'Utilities');
INSERT INTO categorias (c_id, c_nome)
            VALUES (80,'Local Multiplayer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (81,'Magic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (82,'Futuristic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (83,'Management');
INSERT INTO categorias (c_id, c_nome)
            VALUES (84,'Action RPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (85,'Hand-drawn');
INSERT INTO categorias (c_id, c_nome)
            VALUES (86,'1980s');
INSERT INTO categorias (c_id, c_nome)
            VALUES (87,'Crafting');
INSERT INTO categorias (c_id, c_nome)
            VALUES (88,'Side Scroller');
INSERT INTO categorias (c_id, c_nome)
            VALUES (89,'Education');
INSERT INTO categorias (c_id, c_nome)
            VALUES (90,'Turn-Based');
INSERT INTO categorias (c_id, c_nome)
            VALUES (91,'Replay Value');
INSERT INTO categorias (c_id, c_nome)
            VALUES (92,'Procedural Generation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (93,'Cartoon');
INSERT INTO categorias (c_id, c_nome)
            VALUES (94,'Medieval');
INSERT INTO categorias (c_id, c_nome)
            VALUES (95,'Resource Management');
INSERT INTO categorias (c_id, c_nome)
            VALUES (96,'Puzzle Platformer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (97,'Mature');
INSERT INTO categorias (c_id, c_nome)
            VALUES (98,'Survival Horror');
INSERT INTO categorias (c_id, c_nome)
            VALUES (99,'Zombies');
INSERT INTO categorias (c_id, c_nome)
            VALUES (100,'War');
INSERT INTO categorias (c_id, c_nome)
            VALUES (101,'Logic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (102,'Roguelike');
INSERT INTO categorias (c_id, c_nome)
            VALUES (103,'Local Co-Op');
INSERT INTO categorias (c_id, c_nome)
            VALUES (104,'Turn-Based Combat');
INSERT INTO categorias (c_id, c_nome)
            VALUES (105,'Turn-Based Strategy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (106,'Dark Fantasy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (107,'Drama');
INSERT INTO categorias (c_id, c_nome)
            VALUES (108,'Hack and Slash');
INSERT INTO categorias (c_id, c_nome)
            VALUES (109,'3D Platformer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (110,'Romance');
INSERT INTO categorias (c_id, c_nome)
            VALUES (111,'Choose Your Own Adventure');
INSERT INTO categorias (c_id, c_nome)
            VALUES (112,'Post-apocalyptic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (113,'Base Building');
INSERT INTO categorias (c_id, c_nome)
            VALUES (114,'Roguelite');
INSERT INTO categorias (c_id, c_nome)
            VALUES (115,'Historical');
INSERT INTO categorias (c_id, c_nome)
            VALUES (116,'Turn-Based Tactics');
INSERT INTO categorias (c_id, c_nome)
            VALUES (117,'Memes');
INSERT INTO categorias (c_id, c_nome)
            VALUES (118,'Dating Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (119,'Stealth');
INSERT INTO categorias (c_id, c_nome)
            VALUES (120,'JRPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (121,'Interactive Fiction');
INSERT INTO categorias (c_id, c_nome)
            VALUES (122,'Hidden Object');
INSERT INTO categorias (c_id, c_nome)
            VALUES (123,'Walking Simulator');
INSERT INTO categorias (c_id, c_nome)
            VALUES (124,'Surreal');
INSERT INTO categorias (c_id, c_nome)
            VALUES (125,'Web Publishing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (126,'Narration');
INSERT INTO categorias (c_id, c_nome)
            VALUES (127,'Dungeon Crawler');
INSERT INTO categorias (c_id, c_nome)
            VALUES (128,'Emotional');
INSERT INTO categorias (c_id, c_nome)
            VALUES (129,'Classic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (130,'Party-Based RPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (131,'Fast-Paced');
INSERT INTO categorias (c_id, c_nome)
            VALUES (132,'Score Attack');
INSERT INTO categorias (c_id, c_nome)
            VALUES (133,'Military');
INSERT INTO categorias (c_id, c_nome)
            VALUES (134,'Hentai');
INSERT INTO categorias (c_id, c_nome)
            VALUES (135,'Nature');
INSERT INTO categorias (c_id, c_nome)
            VALUES (136,'Bullet Hell');
INSERT INTO categorias (c_id, c_nome)
            VALUES (137,'1990s');
INSERT INTO categorias (c_id, c_nome)
            VALUES (138,'Third-Person Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (139,'Short');
INSERT INTO categorias (c_id, c_nome)
            VALUES (140,'Immersive Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (141,'Movie');
INSERT INTO categorias (c_id, c_nome)
            VALUES (142,'Animation & Modeling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (143,'Team-Based');
INSERT INTO categorias (c_id, c_nome)
            VALUES (144,'Software');
INSERT INTO categorias (c_id, c_nome)
            VALUES (145,'Robots');
INSERT INTO categorias (c_id, c_nome)
            VALUES (146,'RTS');
INSERT INTO categorias (c_id, c_nome)
            VALUES (147,'Top-Down Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (148,'Isometric');
INSERT INTO categorias (c_id, c_nome)
            VALUES (149,'Cyberpunk');
INSERT INTO categorias (c_id, c_nome)
            VALUES (150,'Text-Based');
INSERT INTO categorias (c_id, c_nome)
            VALUES (151,'2.5D');
INSERT INTO categorias (c_id, c_nome)
            VALUES (152,'Dark Humor');
INSERT INTO categorias (c_id, c_nome)
            VALUES (153,'Aliens');
INSERT INTO categorias (c_id, c_nome)
            VALUES (154,'Conversation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (155,'Beautiful');
INSERT INTO categorias (c_id, c_nome)
            VALUES (156,'Cinematic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (157,'Experimental');
INSERT INTO categorias (c_id, c_nome)
            VALUES (158,'Driving');
INSERT INTO categorias (c_id, c_nome)
            VALUES (159,'Economy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (160,'LGBTQ+');
INSERT INTO categorias (c_id, c_nome)
            VALUES (161,'Card Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (162,'Investigation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (163,'RPGMaker');
INSERT INTO categorias (c_id, c_nome)
            VALUES (164,'Abstract');
INSERT INTO categorias (c_id, c_nome)
            VALUES (165,'Action Roguelike');
INSERT INTO categorias (c_id, c_nome)
            VALUES (166,'Music');
INSERT INTO categorias (c_id, c_nome)
            VALUES (167,'Fighting');
INSERT INTO categorias (c_id, c_nome)
            VALUES (168,'Tutorial');
INSERT INTO categorias (c_id, c_nome)
            VALUES (169,'4 Player Local');
INSERT INTO categorias (c_id, c_nome)
            VALUES (170,'Nonlinear');
INSERT INTO categorias (c_id, c_nome)
            VALUES (171,'Inventory Management');
INSERT INTO categorias (c_id, c_nome)
            VALUES (172,'Tabletop');
INSERT INTO categorias (c_id, c_nome)
            VALUES (173,'Board Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (174,'Perma Death');
INSERT INTO categorias (c_id, c_nome)
            VALUES (175,'Flight');
INSERT INTO categorias (c_id, c_nome)
            VALUES (176,'Audio Production');
INSERT INTO categorias (c_id, c_nome)
            VALUES (177,'Soundtrack');
INSERT INTO categorias (c_id, c_nome)
            VALUES (178,'Artificial Intelligence');
INSERT INTO categorias (c_id, c_nome)
            VALUES (179,'Real Time Tactics');
INSERT INTO categorias (c_id, c_nome)
            VALUES (180,'Thriller');
INSERT INTO categorias (c_id, c_nome)
            VALUES (181,'Strategy RPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (182,'Detective');
INSERT INTO categorias (c_id, c_nome)
            VALUES (183,'Psychological');
INSERT INTO categorias (c_id, c_nome)
            VALUES (184,'Arena Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (185,'NSFW');
INSERT INTO categorias (c_id, c_nome)
            VALUES (186,'Demons');
INSERT INTO categorias (c_id, c_nome)
            VALUES (187,'Clicker');
INSERT INTO categorias (c_id, c_nome)
            VALUES (188,'Modern');
INSERT INTO categorias (c_id, c_nome)
            VALUES (189,'Moddable');
INSERT INTO categorias (c_id, c_nome)
            VALUES (190,'Tower Defense');
INSERT INTO categorias (c_id, c_nome)
            VALUES (191,'Video Production');
INSERT INTO categorias (c_id, c_nome)
            VALUES (192,'Life Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (193,'Lore-Rich');
INSERT INTO categorias (c_id, c_nome)
            VALUES (194,'Competitive');
INSERT INTO categorias (c_id, c_nome)
            VALUES (195,'City Builder');
INSERT INTO categorias (c_id, c_nome)
            VALUES (196,'Psychedelic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (197,'Destruction');
INSERT INTO categorias (c_id, c_nome)
            VALUES (198,'Dystopian');
INSERT INTO categorias (c_id, c_nome)
            VALUES (199,'Time Management');
INSERT INTO categorias (c_id, c_nome)
            VALUES (200,'Beat em up');
INSERT INTO categorias (c_id, c_nome)
            VALUES (201,'Loot');
INSERT INTO categorias (c_id, c_nome)
            VALUES (202,'Precision Platformer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (203,'Metroidvania');
INSERT INTO categorias (c_id, c_nome)
            VALUES (204,'Supernatural');
INSERT INTO categorias (c_id, c_nome)
            VALUES (205,'Tactical RPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (206,'Alternate History');
INSERT INTO categorias (c_id, c_nome)
            VALUES (207,'Level Editor');
INSERT INTO categorias (c_id, c_nome)
            VALUES (208,'Wargame');
INSERT INTO categorias (c_id, c_nome)
            VALUES (209,'Comic Book');
INSERT INTO categorias (c_id, c_nome)
            VALUES (210,'MMORPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (211,'Game Development');
INSERT INTO categorias (c_id, c_nome)
            VALUES (212,'Souls-like');
INSERT INTO categorias (c_id, c_nome)
            VALUES (213,'Parkour');
INSERT INTO categorias (c_id, c_nome)
            VALUES (214,'Crime');
INSERT INTO categorias (c_id, c_nome)
            VALUES (215,'Dark Comedy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (216,'World War II');
INSERT INTO categorias (c_id, c_nome)
            VALUES (217,'Mythology');
INSERT INTO categorias (c_id, c_nome)
            VALUES (218,'2D Fighter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (219,'Runner');
INSERT INTO categorias (c_id, c_nome)
            VALUES (220,'Grid-Based Movement');
INSERT INTO categorias (c_id, c_nome)
            VALUES (221,'Character Action Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (222,'Philosophical');
INSERT INTO categorias (c_id, c_nome)
            VALUES (223,'CRPG');
INSERT INTO categorias (c_id, c_nome)
            VALUES (224,'Science');
INSERT INTO categorias (c_id, c_nome)
            VALUES (225,'Twin Stick Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (226,'Class-Based');
INSERT INTO categorias (c_id, c_nome)
            VALUES (227,'Software Training');
INSERT INTO categorias (c_id, c_nome)
            VALUES (228,'Automobile Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (229,'Addictive');
INSERT INTO categorias (c_id, c_nome)
            VALUES (230,'Co-op Campaign');
INSERT INTO categorias (c_id, c_nome)
            VALUES (231,'Grand Strategy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (232,'Space Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (233,'Blood');
INSERT INTO categorias (c_id, c_nome)
            VALUES (234,'Collectathon');
INSERT INTO categorias (c_id, c_nome)
            VALUES (235,'Gun Customization');
INSERT INTO categorias (c_id, c_nome)
            VALUES (236,'Swordplay');
INSERT INTO categorias (c_id, c_nome)
            VALUES (237,'Rhythm');
INSERT INTO categorias (c_id, c_nome)
            VALUES (238,'Lovecraftian');
INSERT INTO categorias (c_id, c_nome)
            VALUES (239,'Idler');
INSERT INTO categorias (c_id, c_nome)
            VALUES (240,'Battle Royale');
INSERT INTO categorias (c_id, c_nome)
            VALUES (241,'Split Screen');
INSERT INTO categorias (c_id, c_nome)
            VALUES (242,'Cats');
INSERT INTO categorias (c_id, c_nome)
            VALUES (243,'Deckbuilding');
INSERT INTO categorias (c_id, c_nome)
            VALUES (244,'Dragons');
INSERT INTO categorias (c_id, c_nome)
            VALUES (245,'Match 3');
INSERT INTO categorias (c_id, c_nome)
            VALUES (246,'3D Vision');
INSERT INTO categorias (c_id, c_nome)
            VALUES (247,'Illuminati');
INSERT INTO categorias (c_id, c_nome)
            VALUES (248,'Open World Survival Craft');
INSERT INTO categorias (c_id, c_nome)
            VALUES (249,'eSports');
INSERT INTO categorias (c_id, c_nome)
            VALUES (250,'6DOF');
INSERT INTO categorias (c_id, c_nome)
            VALUES (251,'America');
INSERT INTO categorias (c_id, c_nome)
            VALUES (252,'Vehicular Combat');
INSERT INTO categorias (c_id, c_nome)
            VALUES (253,'Parody');
INSERT INTO categorias (c_id, c_nome)
            VALUES (254,'Noir');
INSERT INTO categorias (c_id, c_nome)
            VALUES (255,'Card Battler');
INSERT INTO categorias (c_id, c_nome)
            VALUES (256,'Conspiracy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (257,'Capitalism');
INSERT INTO categorias (c_id, c_nome)
            VALUES (258,'Satire');
INSERT INTO categorias (c_id, c_nome)
            VALUES (259,'3D Fighter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (260,'Bullet Time');
INSERT INTO categorias (c_id, c_nome)
            VALUES (261,'Trading');
INSERT INTO categorias (c_id, c_nome)
            VALUES (262,'Voxel');
INSERT INTO categorias (c_id, c_nome)
            VALUES (263,'Photo Editing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (264,'Political');
INSERT INTO categorias (c_id, c_nome)
            VALUES (265,'Real-Time');
INSERT INTO categorias (c_id, c_nome)
            VALUES (266,'Mouse only');
INSERT INTO categorias (c_id, c_nome)
            VALUES (267,'Steampunk');
INSERT INTO categorias (c_id, c_nome)
            VALUES (268,'Episodic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (269,'Cult Classic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (270,'Epic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (271,'Colony Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (272,'Automation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (273,'Time Manipulation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (274,'Mystery Dungeon');
INSERT INTO categorias (c_id, c_nome)
            VALUES (275,'Mechs');
INSERT INTO categorias (c_id, c_nome)
            VALUES (276,'Hunting');
INSERT INTO categorias (c_id, c_nome)
            VALUES (277,'Time Travel');
INSERT INTO categorias (c_id, c_nome)
            VALUES (278,'Gothic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (279,'Underground');
INSERT INTO categorias (c_id, c_nome)
            VALUES (280,'Mining');
INSERT INTO categorias (c_id, c_nome)
            VALUES (281,'Agriculture');
INSERT INTO categorias (c_id, c_nome)
            VALUES (282,'Dynamic Narration');
INSERT INTO categorias (c_id, c_nome)
            VALUES (283,'Tanks');
INSERT INTO categorias (c_id, c_nome)
            VALUES (284,'MOBA');
INSERT INTO categorias (c_id, c_nome)
            VALUES (285,'Remake');
INSERT INTO categorias (c_id, c_nome)
            VALUES (286,'Politics');
INSERT INTO categorias (c_id, c_nome)
            VALUES (287,'Farming Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (288,'Quick-Time Events');
INSERT INTO categorias (c_id, c_nome)
            VALUES (289,'Otome');
INSERT INTO categorias (c_id, c_nome)
            VALUES (290,'Martial Arts');
INSERT INTO categorias (c_id, c_nome)
            VALUES (291,'Hacking');
INSERT INTO categorias (c_id, c_nome)
            VALUES (292,'Ninja');
INSERT INTO categorias (c_id, c_nome)
            VALUES (293,'Hero Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (294,'Pirates');
INSERT INTO categorias (c_id, c_nome)
            VALUES (295,'Word Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (296,'God Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (297,'Spectacle fighter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (298,'Dog');
INSERT INTO categorias (c_id, c_nome)
            VALUES (299,'Hex Grid');
INSERT INTO categorias (c_id, c_nome)
            VALUES (300,'Cold War');
INSERT INTO categorias (c_id, c_nome)
            VALUES (301,'FMV');
INSERT INTO categorias (c_id, c_nome)
            VALUES (302,'Creature Collector');
INSERT INTO categorias (c_id, c_nome)
            VALUES (303,'Solitaire');
INSERT INTO categorias (c_id, c_nome)
            VALUES (304,'Looter Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (305,'Combat Racing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (306,'4X');
INSERT INTO categorias (c_id, c_nome)
            VALUES (307,'Asynchronous Multiplayer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (308,'Trading Card Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (309,'Superhero');
INSERT INTO categorias (c_id, c_nome)
            VALUES (310,'Fishing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (311,'Programming');
INSERT INTO categorias (c_id, c_nome)
            VALUES (312,'Real-Time with Pause');
INSERT INTO categorias (c_id, c_nome)
            VALUES (313,'Dinosaurs');
INSERT INTO categorias (c_id, c_nome)
            VALUES (314,'Assassin');
INSERT INTO categorias (c_id, c_nome)
            VALUES (315,'Underwater');
INSERT INTO categorias (c_id, c_nome)
            VALUES (316,'Vampire');
INSERT INTO categorias (c_id, c_nome)
            VALUES (317,'Trains');
INSERT INTO categorias (c_id, c_nome)
            VALUES (318,'Naval');
INSERT INTO categorias (c_id, c_nome)
            VALUES (319,'Kickstarter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (320,'Western');
INSERT INTO categorias (c_id, c_nome)
            VALUES (321,'Heist');
INSERT INTO categorias (c_id, c_nome)
            VALUES (322,'Immersive');
INSERT INTO categorias (c_id, c_nome)
            VALUES (323,'Minigames');
INSERT INTO categorias (c_id, c_nome)
            VALUES (324,'Narrative');
INSERT INTO categorias (c_id, c_nome)
            VALUES (325,'Faith');
INSERT INTO categorias (c_id, c_nome)
            VALUES (326,'Sokoban');
INSERT INTO categorias (c_id, c_nome)
            VALUES (327,'Political Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (328,'Cooking');
INSERT INTO categorias (c_id, c_nome)
            VALUES (329,'Party');
INSERT INTO categorias (c_id, c_nome)
            VALUES (330,'Archery');
INSERT INTO categorias (c_id, c_nome)
            VALUES (331,'GameMaker');
INSERT INTO categorias (c_id, c_nome)
            VALUES (332,'Diplomacy');
INSERT INTO categorias (c_id, c_nome)
            VALUES (333,'Party Game');
INSERT INTO categorias (c_id, c_nome)
            VALUES (334,'Touch-Friendly');
INSERT INTO categorias (c_id, c_nome)
            VALUES (335,'Experience');
INSERT INTO categorias (c_id, c_nome)
            VALUES (336,'Foreign');
INSERT INTO categorias (c_id, c_nome)
            VALUES (337,'Mod');
INSERT INTO categorias (c_id, c_nome)
            VALUES (338,'Transportation');
INSERT INTO categorias (c_id, c_nome)
            VALUES (339,'Snow');
INSERT INTO categorias (c_id, c_nome)
            VALUES (340,'Naval Combat');
INSERT INTO categorias (c_id, c_nome)
            VALUES (341,'Auto Battler');
INSERT INTO categorias (c_id, c_nome)
            VALUES (342,'Sequel');
INSERT INTO categorias (c_id, c_nome)
            VALUES (343,'Dungeons & Dragons');
INSERT INTO categorias (c_id, c_nome)
            VALUES (344,'Sailing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (345,'Music-Based Procedural Ge');
INSERT INTO categorias (c_id, c_nome)
            VALUES (346,'Documentary');
INSERT INTO categorias (c_id, c_nome)
            VALUES (347,'Sniper');
INSERT INTO categorias (c_id, c_nome)
            VALUES (348,'Transhumanism');
INSERT INTO categorias (c_id, c_nome)
            VALUES (349,'Time Attack');
INSERT INTO categorias (c_id, c_nome)
            VALUES (350,'Gambling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (351,'Villain Protagonist');
INSERT INTO categorias (c_id, c_nome)
            VALUES (352,'Mars');
INSERT INTO categorias (c_id, c_nome)
            VALUES (353,'Games Workshop');
INSERT INTO categorias (c_id, c_nome)
            VALUES (354,'Action RTS');
INSERT INTO categorias (c_id, c_nome)
            VALUES (355,'Soccer');
INSERT INTO categorias (c_id, c_nome)
            VALUES (356,'Typing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (357,'World War I');
INSERT INTO categorias (c_id, c_nome)
            VALUES (358,'On-Rails Shooter');
INSERT INTO categorias (c_id, c_nome)
            VALUES (359,'Offroad');
INSERT INTO categorias (c_id, c_nome)
            VALUES (360,'Football');
INSERT INTO categorias (c_id, c_nome)
            VALUES (361,'Horses');
INSERT INTO categorias (c_id, c_nome)
            VALUES (362,'Werewolves');
INSERT INTO categorias (c_id, c_nome)
            VALUES (363,'Gaming');
INSERT INTO categorias (c_id, c_nome)
            VALUES (364,'Silent Protagonist');
INSERT INTO categorias (c_id, c_nome)
            VALUES (365,'Trivia');
INSERT INTO categorias (c_id, c_nome)
            VALUES (366,'360 Video');
INSERT INTO categorias (c_id, c_nome)
            VALUES (367,'Crowdfunded');
INSERT INTO categorias (c_id, c_nome)
            VALUES (368,'Chess');
INSERT INTO categorias (c_id, c_nome)
            VALUES (369,'Boxing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (370,'Nostalgia');
INSERT INTO categorias (c_id, c_nome)
            VALUES (371,'Farming');
INSERT INTO categorias (c_id, c_nome)
            VALUES (372,'Traditional Roguelike');
INSERT INTO categorias (c_id, c_nome)
            VALUES (373,'Unforgiving');
INSERT INTO categorias (c_id, c_nome)
            VALUES (374,'LEGO');
INSERT INTO categorias (c_id, c_nome)
            VALUES (375,'Roguelike Deckbuilder');
INSERT INTO categorias (c_id, c_nome)
            VALUES (376,'Jet');
INSERT INTO categorias (c_id, c_nome)
            VALUES (377,'TrackIR');
INSERT INTO categorias (c_id, c_nome)
            VALUES (378,'Outbreak Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (379,'Pinball');
INSERT INTO categorias (c_id, c_nome)
            VALUES (380,'Motorbike');
INSERT INTO categorias (c_id, c_nome)
            VALUES (381,'Rome');
INSERT INTO categorias (c_id, c_nome)
            VALUES (382,'Spaceships');
INSERT INTO categorias (c_id, c_nome)
            VALUES (383,'Electronic Music');
INSERT INTO categorias (c_id, c_nome)
            VALUES (384,'Medical Sim');
INSERT INTO categorias (c_id, c_nome)
            VALUES (385,'Golf');
INSERT INTO categorias (c_id, c_nome)
            VALUES (386,'Asymmetric VR');
INSERT INTO categorias (c_id, c_nome)
            VALUES (387,'Ambient');
INSERT INTO categorias (c_id, c_nome)
            VALUES (388,'Spelling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (389,'Warhammer 40K');
INSERT INTO categorias (c_id, c_nome)
            VALUES (390,'Based On A Novel');
INSERT INTO categorias (c_id, c_nome)
            VALUES (391,'Submarine');
INSERT INTO categorias (c_id, c_nome)
            VALUES (392,'Roguevania');
INSERT INTO categorias (c_id, c_nome)
            VALUES (393,'Bikes');
INSERT INTO categorias (c_id, c_nome)
            VALUES (394,'Escape Room');
INSERT INTO categorias (c_id, c_nome)
            VALUES (395,'Basketball');
INSERT INTO categorias (c_id, c_nome)
            VALUES (396,'Social Deduction');
INSERT INTO categorias (c_id, c_nome)
            VALUES (397,'Mini Golf');
INSERT INTO categorias (c_id, c_nome)
            VALUES (398,'Intentionally Awkward Con');
INSERT INTO categorias (c_id, c_nome)
            VALUES (399,'Wrestling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (400,'Instrumental Music');
INSERT INTO categorias (c_id, c_nome)
            VALUES (401,'Pool');
INSERT INTO categorias (c_id, c_nome)
            VALUES (402,'Skateboarding');
INSERT INTO categorias (c_id, c_nome)
            VALUES (403,'Vikings');
INSERT INTO categorias (c_id, c_nome)
            VALUES (404,'Lemmings');
INSERT INTO categorias (c_id, c_nome)
            VALUES (405,'Benchmark');
INSERT INTO categorias (c_id, c_nome)
            VALUES (406,'Baseball');
INSERT INTO categorias (c_id, c_nome)
            VALUES (407,'Steam Machine');
INSERT INTO categorias (c_id, c_nome)
            VALUES (408,'Tennis');
INSERT INTO categorias (c_id, c_nome)
            VALUES (409,'Skating');
INSERT INTO categorias (c_id, c_nome)
            VALUES (410,'Hockey');
INSERT INTO categorias (c_id, c_nome)
            VALUES (411,'Hardware');
INSERT INTO categorias (c_id, c_nome)
            VALUES (412,'Motocross');
INSERT INTO categorias (c_id, c_nome)
            VALUES (413,'Bowling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (414,'Cycling');
INSERT INTO categorias (c_id, c_nome)
            VALUES (415,'Electronic');
INSERT INTO categorias (c_id, c_nome)
            VALUES (416,'Rock Music');
INSERT INTO categorias (c_id, c_nome)
            VALUES (417,'Feature Film');
INSERT INTO categorias (c_id, c_nome)
            VALUES (418,'Voice Control');
INSERT INTO categorias (c_id, c_nome)
            VALUES (419,'ATV');
INSERT INTO categorias (c_id, c_nome)
            VALUES (420,'8-bit Music');
INSERT INTO categorias (c_id, c_nome)
            VALUES (421,'Well-Written');
INSERT INTO categorias (c_id, c_nome)
            VALUES (422,'Skiing');
INSERT INTO categorias (c_id, c_nome)
            VALUES (423,'BMX');
INSERT INTO categorias (c_id, c_nome)
            VALUES (424,'Snowboarding');
INSERT INTO categorias (c_id, c_nome)
            VALUES (425,'Boss Rush');
INSERT INTO categorias (c_id, c_nome)
            VALUES (426,'Reboot');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (1,'The NineHertz', 'consectetur etiam sed ultricies vulputate nec venenatis senectus at nec pharetra et etiam donec ultricies proin lacinia tristique cursus feugiat malesuada viverra libero mi ut netus odio tempus duis nisl cras vitae in erat elit fames sagittis proin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (2,'0verflow', 'non augue condimentum nulla sit erat magna massa eu at  lorem convallis orci condimentum  at lacus  imperdiet  arcu amet  fusce pellentesque vitae bibendum nisl amet enim adipiscing vitae urna cursus bibendum egestas quisque  duis  sit sed nec donec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (3,'11 bit studios', 'elementum tortor quisque porttitor enim massa nunc vel  at  a  elementum vitae facilisi est volutpat vulputate lectus tempus blandit ut nunc neque curabitur urna ornare convallis tincidunt pellentesque condimentum sit amet tincidunt pellentesque vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (4,'1C Company', 'gravida ullamcorper et donec lorem mi ultrices sit  risus nam pretium sed nibh congue enim elementum   cursus eget duis hac vitae lacus ac in et purus adipiscing amet integer mauris aliquet consectetur lacinia et ultrices ut interdum pharetra a massa et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (5,'1-Up Studio', 'in quis lectus volutpat volutpat tempus  parturient amet purus ornare mi suspendisse  nulla suspendisse ut ultricies quam ultrices faucibus tortor  dapibus donec donec egestas turpis elit, risus duis adipiscing duis nam tempus molestie auctor fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (6,'2K Czech', 'consequat elit  tempor consectetur dis magna elit habitant a iaculis sed egestas velit hendrerit pellentesque mi aenean non in  labore erat arcu gravida  quisque tellus ipsum nam diam phasellus diam urna  nibh cursus in est consectetur nibh et hendrerit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (7,'2K', 'fames aenean  nibh ultricies molestie ultrices a molestie amet a pharetra pellentesque integer viverra sagittis eget  nulla elit vitae  id  suspendisse urna sodales iaculis eget quam non lectus in sed  fusce cursus sit semper vestibulum morbi lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (8,'343 Industries', 'nunc hac tortor ultrices  consectetur diam mauris risus pellentesque facilisis facilisi lectus  in aenean molestie felis massa tristique nullam consequat feugiat   nibh amet adipiscing dolor in tristique aliquam hendrerit sed interdum enim tempus erat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (9,'38 Studios', 'ultrices amet massa sit duis  vitae vulputate bibendum vulputate at velit amet lacus etiam duis ut mi  arcu amet sed risus vehicula  eget amet montes  viverra blandit non est  nunc sit ut imperdiet incididunt urna convallis nunc mattis egestas sed urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (10,'3D Realms', 'sit  congue elit eget   suspendisse   in sagittis varius  donec neque sed sed urna   eget amet sit nunc cursus mollis auctor velit enim lacinia arcu nisl amet nec consectetur mi tempor fermentum orci accumsan laoreet   enim varius sollicitudin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (11,'42 Entertainment', 'a lectus lectus sit non condimentum amet urna et integer mauris  nulla  eu libero ultrices pharetra diam leo morbi parturient quam lacus amet nam aliquam viverra tortor porttitor eget dui mauris pellentesque at laoreet ridiculus mauris pulvinar');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (12,'4A Games', 'mattis pretium laoreet amet duis elementum elit varius quam dictum ornare est cursus vitae non vehicula urna risus purus pellentesque porttitor cursus sagittis nibh proin ipsum pretium sapien eu duis ut  amet id vestibulum quisque nec adipiscing et sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (13,'5th Cell', 'ultricies  faucibus ut  fusce pretium  tortor sed leo nunc enim consectetur gravida fermentum  urna   convallis   eu scelerisque nec id  massa  feugiat augue volutpat  id porta lobortis netus nisl cursus eget tellus porttitor adipiscing et purus eu cras');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (14,'989 Studios', 'tincidunt  elementum tempus risus sit nam enim nec lectus viverra curabitur arcu quisque venenatis feugiat ullamcorper velit  at  pretium risus convallis purus aliquam lacus sit parturient faucibus vel amet nibh  scelerisque condimentum elit amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (15,'Acclaim Entertainment', 'nam mattis et incididunt sollicitudin in tincidunt enim a vulputate in justo risus netus elementum viverra rhoncus nisl quam potenti mattis curabitur tempor faucibus eu dis porttitor lectus pellentesque consectetur tristique et  egestas elit sed lorem');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (16,'Acclaim Studios Austin', 'ipsum sed molestie enim imperdiet phasellus placerat  faucibus et pellentesque neque potenti vel vitae diam hendrerit elementum  a diam massa  amet integer eget amet nunc duis maecenas malesuada porta et porttitor  aliquam sed lectus orci nisi pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (17,'Accolade', 'leo risus ornare sed suscipit integer commodo purus pellentesque vel feugiat et eget ipsum dapibus nibh  nunc velit auctor fusce turpis amet erat mattis nulla nulla et lacinia gravida bibendum sed diam et risus a sed donec    adipiscing pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (18,'Access Games', 'nulla arcu  at porta ut donec nisl consectetur elementum vitae vitae nunc ultrices pulvinar   facilisis in at pellentesque dolor egestas aliqua cursus at dictum ut nunc ultrices purus quisque congue nisl netus venenatis  massa id orci euismod massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (19,'Access Software', 'facilisis libero eu sed  pellentesque ac in ut euismod vulputate convallis nec facilisis congue non eu nec mi malesuada nulla  odio ultrices  viverra enim risus et netus nec tristique malesuada id sed et montes diam id a    elementum tempor molestie');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (20,'ACE Team', 'nec purus sit porttitor  aenean congue ultrices interdum erat ornare  tempor purus eu et tortor enim nulla placerat fusce sapien aliquam diam ornare  tellus tortor   pellentesque tincidunt ultrices urna quis sit nec massa enim proin a dictum montes et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (21,'Aces Studio', 'pretium lectus lectus non libero lectus  fames quis velit vulputate suspendisse diam at vitae odio consectetur fermentum cursus  quam sit diam mauris fermentum phasellus  tristique et augue aliquam nisi viverra   ullamcorper ac massa molestie  mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (22,'Acquire', 'ultrices malesuada aenean elit  iaculis et duis id nunc sit hac fermentum quam sed amet proin neque  pretium fusce cras erat nunc et ut pharetra risus diam  suspendisse etiam  in magna odio nulla sed mauris amet id nam sit euismod ut tellus tristique');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (23,'Action Forms', 'donec aliquam libero sed non consectetur facilisi aliquet massa malesuada ipsum consectetur aliquet mattis purus morbi iaculis massa enim lorem purus mus at diam auctor urna gravida non molestie non vulputate aliquet donec at nisi eget bibendum  velit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (24,'Active Gaming Media', 'velit nisl elementum aliquam elit duis vestibulum nisi sed nec nibh  et  nam  et integer vitae amet etiam  massa nulla mauris porta eros sed magna  et arcu ornare sit ut enim  massa aliquet amet sapien netus dictum sed imperdiet sit odio adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (25,'Activision', 'eu sed fusce  neque et orci mattis sed diam nam senectus tempor amet vitae in dui dapibus gravida elit  lectus nulla sed purus venenatis  neque congue diam elit lectus  at mauris  purus    viverra consectetur varius suscipit  nisl arcu cursus nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (26,'Adventure Soft', 'justo lorem massa ultrices eu sagittis id  vivamus sed vel aliquam integer sit dapibus vel libero mauris in morbi risus suspendisse ut venenatis nisl pulvinar pellentesque bibendum malesuada id neque adipiscing  ut quam purus mi urna nisl diam mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (27,'Akella', 'velit   dui id  consequat sed  orci interdum sollicitudin pretium cursus risus vel  diam at id amet sapien lectus quis congue eget  fermentum feugiat  eget eget   et malesuada consectetur pellentesque neque integer placerat nunc ut    dictumst integer');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (28,'Alfa System', 'aliquet turpis feugiat non enim vitae turpis pretium donec quis cursus convallis magnis  vel molestie nullam mi ultrices sed lorem massa tempor lectus nulla morbi viverra   aliquam etiam eget nulla at vitae elementum sagittis nisi  mi duis ac ipsum sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (29,'AlphaDream', 'tortor non  id mi nisl ultricies purus feugiat felis sit sit gravida auctor tristique nulla vel risus  in sed eget et nec pharetra aliquam pellentesque at  odio senectus elit  libero nisi  tempor aenean mi laoreet   morbi sollicitudin posuere in et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (30,'Amazon Game Studios', 'libero non malesuada vitae elementum ut  id orci tortor diam odio nam adipiscing pharetra diam in amet rutrum consequat montes pellentesque habitasse ut  non consectetur non ultricies varius  etiam iaculis sit  nulla sit  fermentum  elementum  nibh netus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (31,'Amazon Game Studios, Orange County', 'egestas  egestas lacinia amet ultricies   mauris vulputate tempor amet elementum at ipsum turpis  nisi vulputate nisl lectus ipsum enim pulvinar eget iaculis adipiscing egestas ultrices porttitor in amet ut ut nec odio neque donec etiam cursus sed odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (32,'Ambrella', 'ut quis et mauris nibh consectetur iaculis  duis sit dapibus cursus ultricies diam nunc egestas in ultrices maecenas imperdiet suspendisse vestibulum interdum justo risus gravida nunc lacus quam odio ridiculus tempus lorem dolor diam eget  pretium nibh');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (33,'Amusement Vision', 'tempor scelerisque  vestibulum convallis gravida  risus mauris purus  diam quam amet mattis lacus vitae massa vitae risus porta nulla nascetur velit est nisl eget sed ut cras  nec mauris nunc velit tempus ipsum vitae arcu sed sed   nunc gravida eget diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (34,'Ancient', 'tempus sed nam sed nullam sollicitudin malesuada  donec malesuada duis  massa amet  vitae diam  feugiat hendrerit pharetra imperdiet vulputate pretium egestas nisl sit ipsum faucibus morbi porta mi id  enim quis at  orci urna egestas sit ullamcorper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (35,'Anino', 'felis amet integer quis scelerisque vitae interdum eu diam ornare suscipit  magnis tortor tellus eu nisi  lacinia vel sem amet massa aliquet viverra fermentum ipsum   cursus tortor    pretium semper erat mi venenatis a lectus at integer nunc id vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (36,'Ankama Games', 'nisl blandit sit  vitae pharetra facilisi nisi at non pulvinar  nibh feugiat est tristique ut nam  cursus vel  elit accumsan orci quis duis elementum egestas nunc ipsum scelerisque nec habitant tellus  scelerisque feugiat facilisis sed vel viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (37,'Appy Entertainment', 'diam vitae at faucibus interdum integer  lorem tortor amet leo nisl integer facilisis ac eget rhoncus  hendrerit  sit luctus gravida senectus dui lectus tempor sed interdum  vulputate semper et sed quam  consectetur augue vitae mattis ultrices  mus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (38,'AQ Interactive', 'aliquam risus turpis adipiscing  purus mauris rhoncus sit in imperdiet in netus  donec turpis commodo  sit tempus in leo enim  ipsum semper dictum amet viverra ultrices  elementum nec amet aliquet laoreet  iaculis erat quisque aliquam interdum id massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (39,'Aquria', 'malesuada  enim interdum elementum convallis netus vel purus cursus ultrices amet mattis  etiam sit quam malesuada sit magna enim orci in lacus  fusce quam sed viverra in egestas orci sit viverra neque lectus nulla risus  id amet amet  nascetur et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (40,'Arc System Works', 'pharetra ac varius mattis at non nec augue parturient tortor laoreet lobortis fusce varius viverra porta maecenas faucibus mauris varius ipsum ac aliquet magna mauris montes etiam neque  congue ultrices sed donec nunc semper consequat tempor pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (41,'Arcane Kids', 'sagittis id justo nunc laoreet neque sit orci vitae quis tristique elementum senectus sit suspendisse faucibus augue adipiscing accumsan  amet varius at in massa porttitor vel cursus vitae massa facilisis suscipit purus tellus rhoncus ut dapibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (42,'Arcen Games', 'orci nisl at  aliquet sit id sit urna mauris et  amet habitasse vel sit interdum etiam lacinia nunc tempus   viverra rhoncus augue vestibulum  elit placerat vitae  labore sem massa hendrerit in diam massa eget viverra ullamcorper ipsum risus et et amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (43,'Arkane Studios', 'duis facilisi pellentesque pellentesque gravida morbi ultrices etiam tempor risus maecenas  vitae eget integer sit   ac neque nibh sed eget et enim malesuada nibh aliquam tempus diam malesuada imperdiet facilisi mauris mauris  in faucibus massa pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (44,'Arkedo Studio', 'quam pretium nunc bibendum  suspendisse egestas in  morbi vitae amet, nibh donec tempor quam eget sit feugiat vel proin ac varius ullamcorper sed tellus vitae ut euismod fermentum fusce nisl diam neque et amet  pellentesque  mattis at  condimentum magna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (45,'ArenaNet', 'nec sodales ut  ultrices congue vitae parturient nisi quisque dictum auctor eget  mollis mi ut eget montes  ultrices ut vitae neque sit  nascetur sit amet ultricies laoreet massa fermentum consectetur tellus nunc elementum accumsan risus nam adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (46,'Arika', 'lectus tortor integer consectetur amet massa nisl senectus euismod euismod nunc egestas amet  quisque vivamus ut commodo faucibus mattis enim mi urna  iaculis malesuada  viverra mus nulla  quis turpis sed mollis  nisi magna justo amet ornare risus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (47,'Art Co., Ltd', 'tincidunt morbi commodo  elit viverra urna amet tempus  et nisl  ipsum ipsum nam  vitae tellus vestibulum dui  amet adipiscing eget in in pulvinar fusce consequat purus volutpat blandit aenean eget quam nulla gravida at senectus ipsum mattis mi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (48,'Artech Digital Entertainment', 'arcu tincidunt adipiscing ullamcorper viverra gravida eget tristique rhoncus auctor ullamcorper sollicitudin velit  nulla  donec viverra  sed fusce  lorem ultrices donec eget molestie ut cras viverra convallis pharetra amet sed sed est augue ultricies');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (49,'Artdink', 'adipiscing in dapibus nunc sed consectetur tempus odio eu arcu diam egestas enim  at nisl  sed ut fermentum lorem nec elit molestie viverra sit fermentum  ut nulla vehicula in   lectus egestas scelerisque mauris tortor pharetra augue nisl pretium sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (50,'ArtePiazza', 'odio pretium id a  amet amet sit scelerisque sit lacus pellentesque auctor in integer tempus quis non faucibus vulputate ac pulvinar varius massa lobortis et cursus amet dignissim augue tempor mi  faucibus blandit congue nullam quisque et nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (51,'Artificial Studios', 'donec morbi odio hac facilisis ut elit dis tellus faucibus id risus  mus vitae non   proin ac porttitor diam scelerisque vel varius adipiscing eget pretium sagittis duis augue tellus netus tristique magna libero vestibulum  urna nisi  pellentesque vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (52,'Artoon', 'iaculis aenean vulputate ut nibh  sem cras tempor nibh sed integer volutpat  dictum sollicitudin neque tempus imperdiet  tempus  ut sem quam condimentum  netus et quam adipiscing mi aliquam elementum sagittis ipsum eget habitasse arcu magna urna eu odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (53,'Arzest', 'nisl consequat  donec elit viverra scelerisque  facilisis erat  condimentum morbi interdum odio sapien amet ut mi bibendum nisl mi diam orci arcu tincidunt nunc imperdiet ultrices velit suspendisse porttitor  blandit feugiat tortor purus pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (54,'Ascaron', 'a mauris non vel fermentum  quam et feugiat quam egestas enim  scelerisque sapien vulputate tellus risus  quam varius duis  adipiscing bibendum integer in cursus vel et cursus eget ultrices dapibus gravida urna cras gravida rhoncus  nisl faucibus ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (55,'Asobo Studio', 'volutpat erat sed ac interdum iaculis nulla tristique ut morbi condimentum pharetra sed  sit nec sit condimentum  sem  sit tempor pellentesque faucibus suscipit sem sit at vulputate pretium  vestibulum at eget duis condimentum habitasse elit velit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (56,'Aspyr', 'a  libero felis elit  purus consectetur varius quisque tincidunt molestie mi leo amet mauris libero nulla egestas diam varius mollis eget at egestas eu non pharetra morbi habitant tincidunt nulla tortor tristique senectus eget in arcu eu hendrerit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (57,'Atari Interactive', 'dignissim  dui cursus urna commodo sem mauris vitae id pellentesque eu  amet suspendisse tellus in commodo aliquam urna adipiscing lectus tortor pretium nunc integer  nisl tortor at vitae consectetur  sit venenatis massa tellus senectus amet semper dolor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (58,'Atlus', 'amet mattis ultricies et mauris ultrices quis ornare non accumsan vitae nunc feugiat nisl sed malesuada feugiat  massa tristique quis gravida velit  pretium massa  tincidunt porta euismod morbi amet quam mollis duis purus vitae orci eu ut   sed commodo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (59,'Atomic Planet Entertainment', 'vitae sit et lectus interdum purus facilisis vestibulum facilisis  mi erat  senectus    donec  viverra parturient amet tellus aenean faucibus  blandit interdum quis quis consectetur hendrerit nibh mauris feugiat  aliquam eu cursus tempor non tellus nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (60,'Attic Entertainment Software', 'tincidunt vulputate fermentum aliquam   mattis platea et gravida sapien scelerisque cras tellus commodo lacus rutrum lorem netus duis vitae quam semper  nec pharetra erat augue mus a pellentesque adipiscing interdum mauris nisi  elit arcu posuere');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (61,'Audiogenic', 'faucibus ornare velit elit ipsum ridiculus ac tempor nunc  urna ac  ut imperdiet ipsum proin  adipiscing bibendum odio fermentum amet neque diam velit mus scelerisque consectetur a quam ultrices placerat auctor ipsum  lectus at tellus rutrum  ultricies');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (62,'Avalanche Studios Group', 'fermentum nascetur tristique eget labore ultricies facilisi sed a arcu facilisis aliquet quisque pulvinar purus quam in mi non  aliquam nunc orci egestas tristique  consectetur risus bibendum tristique id  cras  eu   arcu  pellentesque sodales in quis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (63,'Aventurine SA', 'orci tortor adipiscing tristique tortor urna nibh nulla  interdum aliquam  imperdiet mus ornare justo eget dictum aliquet eget ac vulputate a at aliquam sit amet sollicitudin  vulputate condimentum augue accumsan turpis non id tincidunt cras  aenean');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (64,'Babaroga', 'integer parturient tincidunt  in velit malesuada fusce tristique  consectetur hendrerit quis eu aliquam amet dictum diam  sed orci  nec  mattis sit id nibh auctor  eget nec dis porttitor massa fusce semper ac eget tellus auctor diam nibh donec a ipsum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (65,'Backflip Studios', 'enim iaculis praesent ut viverra lacus quis non  nulla id odio orci amet amet lectus vitae lectus ipsum curabitur  habitant et tortor gravida sit tempor viverra velit pellentesque nec quam a amet porttitor lacinia malesuada nunc parturient hendrerit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (66,'Bandai Namco Entertainment', 'sagittis eu et donec dapibus integer nunc amet nunc amet non  tristique vitae neque diam viverra nisi a arcu a ipsum arcu et urna pellentesque ut nibh gravida nulla bibendum nisl gravida etiam lectus ut ac pellentesque eu ut  tincidunt vel at ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (67,'Bandai Namco Studios', 'pretium  mattis at cursus varius integer dui lorem platea id dictumst magna et nulla sagittis  nisl dolor a enim turpis iaculis sapien malesuada dis non cursus sed amet aliquam  lectus ornare sagittis nulla nibh tortor sollicitudin varius odio id sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (68,'Bauhaus Entertainment', 'augue  ut nisl vestibulum amet cras donec  neque eget amet   non libero dolore quam elit fermentum sed  sed in senectus phasellus sodales pellentesque sollicitudin etiam netus pellentesque nascetur sed sapien pharetra consectetur ut sit  massa risus vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (69,'B.B. Studio', 'consectetur donec lobortis amet eget facilisis massa gravida mus amet sit non malesuada diam pulvinar turpis  vestibulum donec a  pellentesque ipsum amet risus urna   massa  ultricies gravida  erat arcu massa faucibus sed at morbi viverra  vitae sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (70,'Beenox', 'tempus magna tempor mi fermentum amet  at pulvinar nunc quis augue erat ipsum id amet aliquam  libero  viverra pellentesque malesuada id nullam nibh adipiscing nunc aenean ultrices mattis tempor habitant elit amet feugiat interdum morbi  tempor elit,');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (71,'Behaviour Interactive', 'duis ornare nisl erat accumsan ultrices venenatis dictum  pharetra id  aenean morbi faucibus in nulla  interdum volutpat lacinia lacus  lorem vitae amet commodo iaculis pellentesque amet  sem nulla adipiscing cras enim  viverra suscipit dui augue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (72,'Behaviour Santiago', 'odio vel cursus  porttitor aliquam vitae id nisl quam at lobortis dui massa molestie facilisis duis nisi facilisi enim faucibus ultrices massa diam arcu aliquam in lorem  gravida sollicitudin netus amet vitae massa id at nec habitant eget neque quis elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (73,'Bethesda Game Studios', 'velit amet vulputate mauris pretium vitae ipsum augue amet nulla neque congue et lacus ultrices tellus nunc consectetur ipsum  mattis duis tellus porttitor vitae massa sed ipsum placerat ultrices  aliquam morbi venenatis ut in  amet ultrices fusce sapien');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (74,'Big Blue Bubble', 'quisque condimentum dictum et aenean ipsum nisl purus at ut consectetur  egestas augue iaculis  elit  vulputate  duis parturient at in etiam quis est sed malesuada id in vitae magna  et ac elit nisi  ut vitae ultricies lorem enim velit quis tellus  eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (75,'Big Finish Games', 'nulla eget  feugiat fusce integer sit dapibus mi leo eget faucibus proin egestas mauris nibh aenean ut  suscipit aliquet adipiscing  semper sit lectus arcu ut amet sit egestas urna lectus tellus commodo enim odio odio feugiat urna rhoncus at elementum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (76,'Big Huge Games', 'magna arcu morbi nulla facilisis ullamcorper  morbi pellentesque molestie  sed sed lectus senectus malesuada  nunc integer amet  sed mi cras vitae purus eiusmod condimentum vitae  tristique elit et orci  amet erat diam vitae quis  eget amet vulputate');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (77,'BioWare', 'neque viverra commodo  nunc blandit lacus rhoncus sed nisl amet ut ultrices sed sit orci nascetur  netus integer habitasse faucibus massa purus elementum  mi  facilisis sed etiam parturient non tempor  commodo lobortis eget accumsan adipiscing in  urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (78,'The Bitmap Brothers', 'sed nulla tristique cursus aliquam eget  labore    at vel amet sed risus ipsum ridiculus congue viverra adipiscing pellentesque non iaculis malesuada luctus viverra facilisis facilisi vulputate sit   pharetra magna fermentum pellentesque  facilisis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (79,'Best Way', 'ultricies  iaculis amet dictumst est eget  mauris etiam in  pellentesque eu amet condimentum pharetra nullam  ac integer at  tellus  est egestas vulputate nisl ultrices accumsan fermentum  aliquam senectus condimentum lobortis blandit tortor diam eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (80,'Bits Studios', 'habitasse semper nisl  viverra  dapibus  maecenas viverra augue amet augue  id tortor elit ac sed vitae nibh mi sit iaculis potenti at semper nulla massa adipiscing interdum sit nunc urna nibh orci in   a in eu id mattis bibendum at aliquet pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (81,'Bizarre Creations', 'eu consectetur neque congue elit commodo habitant  aliquam nullam tellus nunc purus dignissim amet magna elit mollis donec nec convallis nunc gravida mauris ac est nunc mattis  cursus diam quam odio vitae quis aliquam at diam consectetur sit tortor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (82,'Black Forest Games', 'risus velit egestas dis velit suspendisse sapien at pellentesque nisl vitae nibh mattis odio nam arcu sagittis porta pharetra a tempor odio amet risus at aliquam facilisi  eu nulla nec justo dictumst vulputate gravida id  consectetur velit mus eu iaculis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (83,'Black Isle Studios', 'donec diam elementum integer nulla  lorem risus  congue aliquam diam id purus neque eget pharetra a gravida sit aliquet massa interdum duis pretium nam  urna tempor  magna ac vitae egestas  elementum hendrerit  fermentum consectetur et quis pretium enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (84,'Black Rock Studio', 'dictum mauris non rhoncus amet ultricies    risus nisl elit feugiat nunc sapien sed convallis tellus a pharetra vulputate augue donec nulla duis volutpat ultrices aliquam et pretium massa elit non ullamcorper non vel et vulputate nisi proin euismod massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (85,'Black Wing Foundation', 'sit sit tortor in vivamus mattis nunc congue volutpat cursus  duis mi diam lorem in in sit   malesuada imperdiet amet sit ut  orci fames  ut lacus sit mus sagittis hendrerit cursus at  sagittis proin massa  vel a libero mattis etiam faucibus  neque nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (86,'Blind Squirrel Games', 'nec non fermentum id  lectus donec gravida dictumst iaculis magna  iaculis   at pharetra nec amet,  tristique ac non integer et vitae amet  adipiscing orci arcu convallis porttitor massa mauris et laoreet vitae at vitae tempus malesuada velit ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (87,'Blitz Games Studios', 'faucibus justo feugiat porta feugiat ornare habitant est mattis luctus turpis massa ac tortor felis consectetur viverra scelerisque aliquam mattis dictumst sit tortor aliquet malesuada sed quam feugiat in est sagittis  sem adipiscing nec dui tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (88,'Blizzard Entertainment', 'quis aenean  interdum eu condimentum tortor elit lorem vitae ut semper donec  bibendum viverra arcu diam elit  parturient mi molestie ornare  elit nascetur non aliqua et viverra  amet duis purus nibh ac cursus dolor diam nisl at eget gravida magna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (89,'Bloober Team', 'at urna mauris fusce sit sagittis egestas tempus amet in scelerisque integer sed nulla  tristique mattis duis arcu consectetur tempus quam magnis ut mauris aliquet egestas consequat vitae  integer  malesuada semper aliquam sed cursus volutpat aliquet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (90,'Bluepoint Games', 'et ornare sollicitudin vulputate tempor suspendisse nam lectus velit  egestas  dui  gravida suscipit et   nulla neque vitae ullamcorper  enim mauris donec vitae quam sapien sed  id  amet massa eget mauris   lorem adipiscing sit scelerisque amet dictum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (91,'Blueside', 'consectetur pellentesque  nam pretium purus sapien in id faucibus lectus egestas lectus amet potenti duis morbi eu cras nam senectus   hac fermentum   habitant tempus pellentesque ullamcorper aliquam velit diam eu nisl sapien quam  vulputate nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (92,'Blue Fang Games', 'cras arcu feugiat eget amet egestas  tellus cursus aenean ac consectetur lacinia   orci accumsan ac ultricies iaculis morbi maecenas nec malesuada quam lectus  interdum orci integer senectus sit fermentum magnis pretium mattis pharetra nunc venenatis non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (93,'Blue Tongue Entertainment', 'orci vulputate vitae viverra  quis dignissim id blandit parturient duis et velit mi   vel ac varius fusce id pretium tellus sit  habitant eu nibh nam hac vel augue potenti amet vitae ipsum fermentum  dolor aliquet eiusmod  consectetur leo nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (94,'Bluehole Studio', 'sit mattis pharetra dapibus aliquam diam vestibulum non amet elit leo eget mattis pharetra  pellentesque mi placerat nam sed arcu molestie facilisi vitae at vel massa ut sed sed a sed velit velit a arcu facilisis lobortis amet, tortor arcu amet tortor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (95,'Bohemia Interactive', 'sapien sapien molestie fames dapibus amet augue volutpat consectetur gravida risus diam et risus vitae egestas ac feugiat tortor urna nisl lectus ac mattis vitae quis vulputate nunc fermentum aliquam hac nunc ipsum malesuada tristique pulvinar arcu et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (96,'Boss Fight Entertainment', 'malesuada rhoncus nulla congue amet tristique nec   risus fames ipsum curabitur semper mauris orci  urna aliquam   sed tempus risus aliquet dolore lorem nulla tincidunt vitae massa cursus  platea aliquet dui non consequat id libero risus sapien diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (97,'Boss Key Productions', 'fames sed ornare ut viverra congue elit mauris sed enim sit lorem in augue et vitae molestie elementum mus arcu vestibulum mollis scelerisque  sit nunc urna mi sed interdum tortor etiam porttitor vitae vel consectetur odio viverra sit vitae amet,');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (98,'BreakAway Games', 'tempus iaculis nibh magna sed  varius ac sollicitudin volutpat risus aliquam  at  consectetur aenean vitae congue sit consequat ac ultrices nullam bibendum mauris quis aliquet sapien donec cras mi diam lorem faucibus sit et tortor rutrum adipiscing vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (99,'Brøderbund', 'ut  ullamcorper mi morbi  amet nulla vestibulum  dui tempor dis  pulvinar ut mattis sed tortor laoreet ut  nascetur nisl adipiscing nisl pellentesque sit aliquet feugiat  urna porta ultricies  condimentum nunc   adipiscing tempor  in nunc elementum eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (100,'Budcat Creations', 'ut amet platea  ultrices condimentum malesuada id  id pharetra ipsum et gravida malesuada elit tincidunt at purus duis morbi   ultrices consectetur quam risus ut turpis turpis aliquam ut sit habitant augue integer  tincidunt velit mus augue eget id enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (101,'Bugbear Entertainment', 'senectus congue donec tristique nec  id vestibulum egestas cursus aliquet aenean    ultrices consectetur diam adipiscing ut neque commodo amet a erat maecenas  dictum  amet blandit  at non ipsum nec pretium vitae commodo donec varius amet tempus amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (102,'Bullfrog Productions', 'tortor erat consequat tempor potenti at eget  habitasse libero amet consectetur auctor pretium iaculis eu urna viverra   cursus ultrices  sed quisque netus  molestie varius leo habitasse egestas quis dui pellentesque enim blandit vel tempor nunc sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (103,'Bungie', 'consectetur  morbi nibh suspendisse  semper feugiat dictum tellus diam sed   arcu tellus neque ac nulla  nisl a sed mattis aliquam eiusmod aliquam elit aenean  consequat nam magna  incididunt vitae a bibendum lacus sed  viverra dictum  eros  amet nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (104,'Camelot Software Planning', 'sed ullamcorper  adipiscing suspendisse   tellus quam condimentum facilisi elit sit at  eget aliquam eleifend massa massa nulla orci consectetur lectus ut et phasellus neque mi diam mi semper molestie  nunc leo  suscipit lacinia eget tempus massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (105,'Capcom', 'sed nec netus amet adipiscing rhoncus orci erat non sapien at lectus eiusmod tellus massa imperdiet  id velit et ut id in nunc ipsum cras consectetur elit tortor aliquam tortor ut nullam    sit lorem malesuada   elit faucibus  gravida morbi pulvinar');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (106,'Capcom Vancouver', 'viverra ipsum adipiscing habitasse quis pellentesque purus accumsan adipiscing tincidunt morbi nunc amet duis sem  sit  at sit dui donec ac tortor orci felis faucibus aliquam  ut  imperdiet turpis quam tincidunt  quam in ut  diam tincidunt cras tortor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (107,'Carbine Studios', 'a vulputate non enim urna pretium vitae  diam pretium eu eget condimentum adipiscing  lectus cursus amet mauris purus et est   sed consectetur ut ipsum commodo pulvinar viverra habitant eu mattis  rhoncus vitae sed aliquet tortor montes amet ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (108,'Cattle Call', 'consectetur malesuada non tempor  feugiat elit non adipiscing purus   mauris egestas vitae tortor duis mauris in arcu eu lacinia ac tellus egestas mauris pretium placerat sagittis interdum viverra curabitur nec proin pellentesque sed dolor  quis posuere');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (109,'Cauldron', 'vulputate scelerisque vitae arcu id cursus adipiscing eu vestibulum aliquet quam nullam arcu semper ut sit et amet mattis netus in massa ut integer lacus magnis et odio rhoncus in  in sagittis purus  massa lacus integer urna  elit magna cursus iaculis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (110,'Cave', 'fames augue aliquet faucibus hac id  etiam pharetra dolor tristique eget volutpat vulputate fusce non purus molestie vitae risus id at netus fermentum iaculis dictum faucibus faucibus at porttitor duis porta sed id augue montes amet odio in vestibulum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (111,'Cavia', 'urna  molestie sed velit sed gravida interdum viverra sed commodo elit feugiat   pharetra et vel adipiscing proin hac quam nisi mattis tempus at tortor in iaculis semper phasellus in velit eget egestas ipsum adipiscing  senectus justo eu turpis nullam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (112,'CCP Games', 'nullam lorem risus tristique risus   vitae habitant do et tellus ut nec amet  adipiscing orci suscipit rhoncus arcu dolor convallis faucibus egestas sagittis mattis amet in vestibulum diam amet eu ultricies ultricies imperdiet risus viverra sed ac lacus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (113,'CD Projekt Red', 'sed amet leo purus potenti massa arcu mattis duis tempus sed vulputate nunc id justo cursus vel  gravida erat ac malesuada quam libero id at nunc varius elementum at aenean purus eget vel  nunc aenean feugiat pretium ut orci gravida tristique  non at at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (114,'Certain Affinity', 'sit sit mattis facilisis et tincidunt nunc  a odio volutpat pretium viverra malesuada vestibulum porttitor turpis fusce bibendum sapien dui feugiat augue ac et euismod velit consectetur ornare  porta interdum porttitor sem  ornare pellentesque at amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (115,'Chair Entertainment', 'mi pulvinar amet et tincidunt scelerisque suspendisse cursus eu sit  leo arcu  laoreet rhoncus rhoncus velit mattis urna tempor ultrices vitae fames morbi porttitor purus purus odio hac ut nec tortor amet a tincidunt sit sit curabitur integer amet vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (116,'Chunsoft', 'ullamcorper sagittis sed purus viverra sed quis vitae pretium proin consequat at erat vitae viverra felis amet netus venenatis gravida tellus porttitor quisque consectetur nam lobortis turpis amet adipiscing facilisi id interdum non elit amet donec nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (117,'Cing', 'augue amet cursus integer interdum urna massa tellus mattis consectetur vulputate lectus   etiam  ac neque congue diam urna dictumst est tristique amet malesuada  id id sed netus scelerisque faucibus tristique risus  porttitor iaculis fames egestas odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (118,'Clap Hanz', 'pharetra  tortor nisi  at nisl malesuada elit montes mattis eleifend et id faucibus leo  integer in donec purus nulla nam amet justo in eget nibh  mattis luctus sit amet  in tempor mi cursus euismod rhoncus eget tempor lacus tempus ultrices aliquet vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (119,'Climax Entertainment', 'massa at augue rhoncus consequat dui duis tellus turpis ipsum magna viverra donec suspendisse urna quis congue cras faucibus vulputate tortor  platea nullam nam lectus ultrices in quam pretium diam vel sagittis euismod do nisi pulvinar arcu ultricies');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (120,'Climax Studios', 'dolor odio et egestas varius faucibus augue non enim eget vitae amet, in  ut vel et at lectus quam ridiculus auctor suspendisse tristique vitae porttitor et odio ridiculus  quis viverra eget nascetur parturient neque a vel nibh vestibulum pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (121,'Clover Studio', 'purus enim mattis id placerat magna odio neque quisque facilisis odio aenean tortor nisi ut interdum vitae est volutpat diam aliquam sagittis neque   nec  a auctor nulla leo ut adipiscing massa integer massa urna suspendisse elementum dolor fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (122,'Coded Illusions', 'porta purus  orci non in amet lacus magna feugiat lectus in felis quis mattis imperdiet gravida nec arcu sem pretium sit ut diam cursus ridiculus neque et nisl nec  eu    purus ultrices luctus suspendisse nunc duis  dapibus nisi faucibus  habitasse');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (123,'Codemasters', 'in id sit  ipsum lorem urna nulla  adipiscing purus vehicula curabitur integer nulla  cursus ut ac quis dictum nulla ac aenean pharetra iaculis odio ultrices augue aliquet tortor proin a adipiscing amet nullam bibendum elit turpis  sagittis nibh eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (124,'Coffee Stain Studios', 'at tincidunt felis nunc massa pellentesque  consectetur laoreet dapibus faucibus  venenatis  nulla massa nisl nulla dolor tempor ut cursus vestibulum a massa orci eget proin nunc non hendrerit sem faucibus tellus  varius netus ultricies nunc ut et eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (125,'Cohort Studios', 'quisque vel eu tincidunt tristique  tristique imperdiet nascetur pellentesque aliquam risus malesuada vestibulum purus vitae egestas sapien parturient ornare pretium ac at lectus dictum nisi nisl  mauris non  amet et  ut proin eget curabitur viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (126,'Coktel Vision', 'et porta ut lacus feugiat purus ornare et senectus libero nullam posuere sit non habitant arcu amet at ipsum tincidunt diam integer mattis  sit scelerisque  vitae vitae nulla  massa  eleifend mauris dolor platea condimentum   elit ut rhoncus odio  diam a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (127,'Colossal Order', 'ut pharetra lacus  ornare est  aliquet aenean aenean  id non ac eget porta mattis purus fermentum tempus lobortis hac elit amet nisi urna tempor   nunc tortor amet blandit consectetur mauris  nec quam neque pharetra facilisis vestibulum suscipit  congue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (128,'Compile Heart', 'sed massa adipiscing in amet gravida augue nec  sed ut diam vulputate fames quis ultrices fermentum et mauris faucibus sapien vel sed curabitur  libero morbi  vitae et purus sed sit  non nisl arcu at eleifend habitasse tellus ac elementum enim dolor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (129,'Compulsion Games', 'feugiat sed ridiculus odio ut  in commodo ut dictum dignissim lectus eget duis vulputate tellus vitae porttitor aliquet tincidunt lobortis congue mattis nulla sed porttitor tortor amet amet dui orci viverra venenatis  tortor nec tincidunt  sollicitudin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (130,'Com2uS', 'commodo in  pellentesque mauris massa purus mollis sed condimentum facilisi condimentum porttitor varius sit montes orci cursus at tortor leo  turpis ridiculus tempus massa leo tellus scelerisque  ut  ac  diam pretium at porttitor nisl libero justo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (131,'Core Design', 'dictumst aliquet consectetur mauris enim cursus cursus justo porttitor cursus sit nunc et sit adipiscing massa porta turpis augue eu  dolor viverra molestie hac orci   lacus mollis quis euismod aliquam  varius et quam rhoncus turpis hendrerit ullamcorper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (132,'Crafts & Meister', 'aliquet neque habitasse aliquam et  sed tellus nulla odio tortor eu tempus mauris viverra vel netus nisl lectus fusce  tellus parturient sit malesuada enim nec enim   est tortor non suspendisse egestas  egestas consectetur est dui lacus diam et nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (133,'Crawfish Interactive', 'mi aliquam  urna  tellus mus sed egestas nunc  nisi adipiscing vitae  ac  dolor nam nulla amet non at interdum duis consectetur iaculis tincidunt purus nunc duis in   dolor mauris faucibus vestibulum odio elementum lorem integer amet nec montes consequat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (134,'Creat Studios', 'amet,  ac amet at  egestas diam id  praesent nunc amet  purus ullamcorper a augue amet donec  lectus enim  commodo vestibulum non mauris id dui arcu a turpis suspendisse elit, sit est turpis venenatis aenean arcu placerat purus orci neque pellentesque ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (135,'Creative Assembly', 'quis diam pulvinar scelerisque lectus  vel quis purus ultricies adipiscing maecenas sit pretium ridiculus enim eget donec dolor sit elementum lacus sagittis gravida vulputate pellentesque consectetur vitae lorem dolore amet suspendisse ultrices dolor sem');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (136,'Creatures', 'et malesuada donec  non ullamcorper feugiat ornare sed at facilisis mollis arcu viverra nulla faucibus diam enim malesuada  non mi   cursus   velit massa sit sit congue  velit at mi  lacus pretium mauris varius consectetur pharetra placerat  at faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (137,'Criterion Games', 'vitae libero felis facilisis amet incididunt nunc malesuada consectetur ut volutpat  condimentum adipiscing id  laoreet eget eget vel proin lorem aliquam quam potenti varius arcu tellus amet in vel malesuada parturient mi  lectus a sagittis neque magna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (138,'Croteam', 'vitae nisl quis in elit  ornare cursus fames vitae ut tincidunt  lectus viverra  odio consectetur sed ut velit aliqua   faucibus in potenti dui amet in fermentum odio fusce sollicitudin gravida consectetur enim enim quam suspendisse  nam nisl proin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (139,'Cryo Interactive', 'odio ut  vulputate faucibus  gravida aliquam lectus magna mauris blandit odio eu tellus  feugiat pellentesque tempor integer purus velit arcu dictum volutpat vitae sit cursus consectetur libero lacinia turpis orci mattis nec donec ornare  ultrices at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (140,'Culture Brain Excel', 'laoreet nam facilisis vitae nibh eget ut facilisi sit ac egestas in   vel condimentum eget id  mauris massa vulputate euismod purus neque mauris facilisi diam sed   sem nunc hendrerit tristique tellus ultricies scelerisque diam eiusmod aliquet  aliquet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (141,'Crea-Tech', 'amet condimentum lectus aliqua sed rutrum et  a lectus  sapien eget dictum nec gravida  dignissim netus dolor venenatis nulla amet rhoncus quam urna  a urna aliquet sed amet facilisi blandit volutpat in quis habitasse tempus enim sagittis ut feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (142,'Cryptic Studios', 'ridiculus potenti amet amet,  quis diam proin varius sit mattis vulputate dapibus aliquam at dolor non  vitae eget fusce tortor pellentesque justo iaculis rhoncus non senectus etiam    vulputate massa amet nibh ipsum nunc ac et nunc imperdiet justo ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (143,'Crystal Dynamics', 'ipsum vitae  eget  faucibus consectetur  amet arcu venenatis auctor ut nulla  amet augue  ac laoreet cursus ultrices velit quis et viverra arcu est condimentum a euismod proin ipsum iaculis  tristique tortor tortor urna mauris odio  vitae tempor neque do');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (144,'Crytek', 'adipiscing diam eu quam et  nec nec congue quis sed viverra  condimentum nisi faucibus turpis pulvinar tristique ultrices  malesuada  tellus  semper nulla sit diam  ac   risus et potenti varius nunc sit nibh at duis convallis nulla adipiscing morbi et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (145,'Crytek UK', 'diam morbi quisque ut massa mattis orci varius et a risus facilisi  congue   nunc nunc diam fusce lectus tortor nisl vel adipiscing egestas  congue tincidunt quam auctor et quam arcu risus   ac pulvinar gravida ornare purus nisl duis id lorem volutpat a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (146,'Cyan Worlds', 'iaculis sed erat mi adipiscing iaculis non magnis dictum scelerisque ultricies pretium egestas odio  sit nunc  ornare  venenatis  tellus a pharetra diam  eu pulvinar  sit fusce   porttitor neque morbi ultricies curabitur nulla tempor ultrices quam enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (147,'Cyanide', 'interdum nam nibh amet quis erat nisl pretium massa sit semper amet sollicitudin pretium in potenti magna mi lobortis scelerisque  cras tellus in   gravida tellus  ut etiam orci ipsum ut leo neque gravida tempor at nec aliquam  dolor elementum augue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (148,'CyberConnect2', 'duis mi quis neque at pretium  mattis suspendisse suspendisse morbi et mauris  aliquam nisl sapien a  nulla nam ac id vitae sed scelerisque quis non condimentum eu consectetur cursus semper feugiat  duis massa nisi elit urna non et  in sit ultricies arcu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (149,'Cyberlore Studios', 'nulla tincidunt et amet amet id nibh risus pellentesque pharetra amet amet eget porttitor a posuere elit nam euismod vitae morbi mi lectus neque eleifend nibh gravida suscipit duis nibh quam commodo velit  nisl fames odio habitasse diam morbi parturient');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (150,'CyberStep', 'nec risus laoreet  interdum in senectus at  integer lectus nec   cursus  at amet ultricies non quis velit nibh  mattis lorem hendrerit erat id diam amet  massa montes amet at  morbi a adipiscing nisi tempus aenean rhoncus amet sit elit consequat ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (151,'Cygames', 'sit  consectetur duis rhoncus venenatis ac aliquam tincidunt aliquam  sit egestas etiam orci odio euismod venenatis ut feugiat vitae nisl ut tortor nunc urna bibendum feugiat non  elit quis imperdiet condimentum libero sed  sit  donec mauris iaculis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (152,'Dambuster Studios', 'dolore aenean ornare et et urna ac interdum diam suscipit interdum elementum massa hac malesuada nibh  amet sed adipiscing venenatis urna felis in  nunc dignissim massa lectus at tellus enim   neque cursus non amet elementum eu arcu tristique elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (153,'Danger Close Games', 'amet mauris euismod integer fermentum  elementum urna faucibus placerat nec  nunc dui diam ipsum non vivamus malesuada eget consectetur interdum quam quis  at dis suspendisse in sed erat suspendisse  consectetur vulputate  lectus neque  nunc suscipit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (154,'Day 1 Studios', 'nam sit adipiscing tellus ut ut id viverra augue amet  egestas suscipit neque molestie volutpat   eget  consectetur aliquam facilisi ultrices enim quisque nibh porttitor  auctor vel neque sit ut eu odio   in nisi neque massa rhoncus amet sit  nec purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (155,'Daybreak Game Company', 'tortor arcu quam augue  feugiat nibh proin scelerisque malesuada non netus tellus vestibulum  nunc nibh rhoncus venenatis turpis vulputate augue velit non felis netus  porttitor   integer ipsum congue euismod   ullamcorper  donec sapien mattis  rutrum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (156,'Deadline Games', 'tortor  at eget diam integer fermentum magna amet quis urna lacus massa tincidunt sollicitudin nisl ac libero mattis duis magna nisi sed  a vulputate nec habitasse in in mattis et nulla tortor nullam mattis viverra leo tellus nec  diam at tellus nam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (157,'Deck13', 'facilisi integer  consectetur nibh habitant interdum  varius sagittis sed nulla congue tincidunt cursus gravida vitae  at et eget etiam arcu nec quisque erat augue nec sed varius adipiscing fermentum molestie in vulputate  iaculis nunc vitae consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (158,'Deep Silver Volition', 'ut lorem tristique parturient erat a fermentum vel sit a tellus  sit odio pellentesque at volutpat varius turpis mus varius blandit massa egestas at elit  tincidunt nulla  libero proin in volutpat viverra  duis nibh vel nulla ut placerat tellus nibh');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (159,'Demiurge Studios', 'id molestie feugiat neque tellus leo amet tellus sagittis blandit potenti orci  cursus malesuada diam a aliquet aliquet ut sed iaculis duis quisque cras convallis nibh in consectetur viverra  viverra congue rutrum sem amet mattis sapien nulla   enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (160,'DeNA', 'quam facilisis tortor phasellus enim bibendum porttitor elementum justo vulputate quis   venenatis  et  aliquam tellus tincidunt  tellus  auctor ut orci  sed nulla pharetra suscipit proin  integer venenatis cursus lectus sit platea eget  nunc mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (161,'devCAT Studios ', 'lectus nisi  faucibus cursus risus leo elit id arcu  faucibus arcu donec donec aenean orci vel mauris  vitae  lorem mauris dolor tortor proin id et consectetur orci lacus lectus  risus suspendisse ut urna dictum  ipsum varius varius vitae volutpat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (162,'Dhruva Interactive', 'augue varius mi pharetra neque orci lobortis facilisis tortor   urna  consectetur scelerisque mus velit  ipsum consequat semper sed risus ultricies cursus nec amet  mauris rhoncus donec sagittis nisi lacus aliquam volutpat lorem mus mattis massa eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (163,'Die Gute Fabrik', 'ut et nunc mattis bibendum nascetur  vel tortor et viverra et euismod malesuada eiusmod mattis ullamcorper  in semper facilisi nam rhoncus ultrices faucibus  urna viverra massa tempus neque netus libero consectetur sit turpis justo semper aliquam nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (164,'Digital Extremes', 'nulla tortor pharetra augue sed suspendisse  in lobortis egestas ultricies    tincidunt   phasellus  id risus    consectetur elit lobortis  nunc  nunc  commodo vel netus risus fermentum  fermentum ut   odio morbi nibh  ut donec senectus lorem eget mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (165,'Digital Eclipse', 'sed ipsum augue accumsan sagittis malesuada tincidunt adipiscing in nibh arcu  quam  enim neque vehicula aliquet  nunc aenean libero varius eu volutpat tincidunt dictum vel nec enim in mollis mi  tempor venenatis pellentesque  malesuada laoreet vulputate');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (166,'Digitalmindsoft', 'donec odio  in felis euismod eget viverra velit ac potenti aliquam et sagittis hendrerit consectetur tempus  amet tellus tristique eget fermentum cursus turpis tempor  aliquet mauris sed nunc eget urna condimentum ultricies  pellentesque ac  nunc risus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (167,'Digital Reality', 'nibh et et dui  commodo hendrerit feugiat enim consectetur pretium nisl mi  elit risus blandit magna  donec ridiculus pellentesque lobortis hac  integer et quis in feugiat in senectus sed ornare interdum ullamcorper amet  dolor suspendisse nisl sit amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (168,'Dimps', 'a amet senectus et leo  purus elit semper fames at amet  id id ut orci pretium aliquet facilisis  augue pulvinar tellus est interdum turpis augue ut aliquam nibh ridiculus imperdiet mollis amet massa interdum quis blandit  incididunt nisi erat malesuada');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (169,'Disney Interactive Studios', 'aliquet nisl donec at  urna odio dolor adipiscing a massa imperdiet non lectus  eget adipiscing dictumst vulputate quis suscipit aenean id aenean blandit a non  cras velit duis eu nisl turpis  id aliquam mattis et purus non tristique mauris adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (170,'Dontnod Entertainment', 'fusce cursus non nisl proin ornare sodales sit elementum et et aliquam diam dictum donec tincidunt auctor auctor neque aliquet quisque pharetra sed elit eget imperdiet ullamcorper malesuada varius amet viverra consectetur molestie sed scelerisque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (171,'DotEmu', 'cursus quisque tincidunt neque  nunc diam mauris aliquam  diam leo leo vitae nunc ipsum integer nulla  aliquet blandit sit ullamcorper elit vel malesuada ut adipiscing faucibus lacus habitasse consectetur fusce id risus mi mollis rutrum egestas elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (172,'Double Fine Productions', 'viverra sed nunc nisl velit bibendum mollis et   sem  aliquam mauris  vitae sit sit elementum  sit duis nisl sem sit sed pharetra mauris odio lacus scelerisque   mauris id pharetra tortor nibh justo et mattis neque labore purus  massa vitae consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (173,'Dynamix', 'viverra porttitor donec nunc morbi dictum mi donec arcu faucibus amet, et adipiscing sagittis varius nec vel enim enim  tincidunt nunc mattis consequat  nisi at eget nam  molestie  tristique  non eget tristique  risus massa et purus eu amet purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (174,'Dovetail Games', 'ut erat rhoncus montes   aliquet elit fusce ut morbi sem lectus ipsum fames velit quam sed eu orci duis amet ornare arcu magna molestie neque  lacinia aenean  venenatis massa purus vestibulum dolor proin non feugiat suspendisse duis pellentesque aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (175,'The Dovetail Group', 'pharetra tristique  a sed  purus facilisis duis porttitor  amet cursus netus feugiat pellentesque sed  amet cursus lectus aliquet pellentesque et etiam vitae non sed sit vulputate tellus viverra gravida purus semper mauris potenti pellentesque erat et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (176,'EA Black Box', 'hendrerit mattis tellus augue bibendum platea dignissim aenean vitae adipiscing iaculis nisi suspendisse massa mattis at eget tortor lorem commodo faucibus id non  et bibendum eros vestibulum dui id sed hac  sed volutpat quam auctor nulla  nec  consequat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (177,'EA Digital Illusions CE', 'molestie sit ridiculus eget a purus erat id at nec mattis diam nisl euismod velit tempor  malesuada augue aliquam ac et dictum molestie justo et integer libero molestie amet  id ipsum sed vel pellentesque amet sed  platea maecenas lobortis labore neque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (178,'EA Gothenburg', 'dapibus varius hendrerit quam sollicitudin proin laoreet ultricies senectus  in tristique porttitor eu  fermentum risus tristique  aliquet ut quis tellus erat congue amet risus congue nec malesuada ut odio cursus   potenti urna elit bibendum  pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (179,'EA Phenomic', 'lectus nullam leo ut  ut velit consectetur libero urna nulla iaculis et arcu  accumsan ut vitae velit erat tincidunt facilisis sit ultrices habitasse non mauris velit neque egestas purus sapien adipiscing mi ipsum integer amet   gravida diam nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (180,'EA Salt Lake', 'ut vehicula mus  sit  viverra mi  adipiscing dictum scelerisque augue est  nunc sit rhoncus non molestie a lorem  nunc vel nec pellentesque suscipit  et senectus leo habitasse eget aliquam amet et et aliquet risus diam eu pretium venenatis   sed in nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (181,'EA Tiburon', 'turpis faucibus at leo odio sit nibh massa sit pharetra  sed nec amet ultricies tortor risus orci nullam sed sapien vestibulum  morbi elementum consectetur quis proin dictumst lectus duis id lacus  semper  facilisis at lectus facilisis cursus  tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (182,'EA Vancouver', 'eu lectus orci rutrum tempor posuere ut vulputate pellentesque diam tellus lorem lobortis mollis vulputate bibendum sit id iaculis  pellentesque ut  nisl malesuada parturient ut libero est tempus vitae condimentum integer  diam dapibus viverra integer');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (183,'Eat Sleep Play', 'lectus nec   ac et velit velit amet mauris netus magna mattis eu at amet  euismod ultrices senectus gravida orci mattis eget sed imperdiet sed lectus ac viverra sem  cras auctor  non ipsum nam lectus pretium mauris interdum labore fermentum cursus fames');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (184,'Eko Software', 'dictumst consectetur ultrices parturient lobortis massa facilisis diam suspendisse tincidunt duis adipiscing incididunt morbi tempor interdum tortor in id aenean nullam purus mattis  at nunc a  mi ipsum aliquam tortor felis aliquam et lacus quis  turpis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (185,'Egosoft', 'ultrices facilisi cursus  nibh lorem feugiat tempor tempus neque  cursus pellentesque quam mauris nunc  nibh  vel urna diam sed non nam urna nulla quam rhoncus et nunc phasellus volutpat viverra  odio diam at  quam duis in integer  proin sollicitudin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (186,'Eden Games', 'viverra eget morbi et dictum sed purus varius ipsum  et ridiculus amet nunc laoreet labore eget interdum risus ridiculus mauris in  malesuada etiam pretium augue consequat neque at in a ornare lacus magna quis amet  egestas convallis dolor amet sit felis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (187,'Eighting', 'vulputate ultrices sit lacus  integer condimentum  id eget  massa viverra praesent nunc feugiat massa labore  pellentesque dui egestas dictum vel  nec diam vel lacinia  vestibulum amet erat venenatis sed   tortor hac varius pellentesque libero tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (188,'Electronic Arts', 'imperdiet integer eu lorem nunc malesuada eget  consectetur  ac commodo purus diam eget netus tristique aliquet duis felis ac  velit aenean tempus nisi vitae nam in nisl eget ipsum  tincidunt varius tempor tempor aliquam amet, at eiusmod aliquam neque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (189,'Elemental Games', 'morbi tortor ipsum morbi sed mi  do iaculis elit  tortor egestas nulla sit tellus enim fermentum leo pretium sed sed semper consequat quis viverra aliquam  sed tempor eget orci urna  bibendum mollis ridiculus vel praesent pretium vitae tincidunt');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (190,'Engine Software', 'ornare faucibus nunc  lacinia mollis faucibus enim  consequat purus   nulla convallis tortor sit urna at lacus cras sapien volutpat ut eu nunc faucibus fusce morbi ullamcorper rhoncus amet  nullam arcu semper tristique laoreet vulputate augue at nam eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (191,'Ensemble Studios', 'risus nulla facilisi cursus id purus sem egestas condimentum lacinia mauris donec mattis dapibus dapibus maecenas tortor tempus bibendum  sodales ipsum quam hendrerit molestie in et cras mattis nibh id ut mauris  lobortis turpis non  morbi facilisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (192,'Epic Games', 'ultrices vulputate in orci a ut sit duis tincidunt risus  in sagittis tristique sit viverra  urna at nulla nisl tincidunt mattis venenatis interdum sit nec sem amet vel tincidunt nascetur tincidunt tristique aenean arcu gravida vitae nec pulvinar leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (193,'Epics', 'nam  consectetur faucibus  aliquet nam nec a diam mauris  amet tellus purus venenatis nibh amet massa donec a lobortis odio massa lorem egestas id blandit facilisis lorem at feugiat sagittis pellentesque fermentum senectus aliquam amet  at ac  tempor in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (194,'Epicenter Studios', 'dolor viverra ut   nunc vitae  id  fusce eget ornare ut lorem nibh morbi id sagittis augue cras  integer  semper imperdiet  morbi turpis eu diam auctor aliquet semper  quis purus leo netus eget tristique  praesent faucibus interdum et odio  porttitor at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (195,'Epyx', 'morbi  a massa sem suspendisse dui malesuada donec  rutrum fames velit nibh orci a lorem cras accumsan dictumst laoreet  massa etiam commodo sapien mauris erat tempus est tristique viverra imperdiet gravida porttitor vel in condimentum consectetur nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (196,'ESA ', 'nulla leo at scelerisque nisl tristique consequat integer et sed pretium  et quam morbi  elit, nec viverra aliquam pulvinar varius   elementum sapien congue ullamcorper eget ut neque nulla amet vel lectus turpis elementum mus gravida mauris sit est nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (197,'Étranges Libellules', 'amet  malesuada non  ut mauris  tincidunt tempor in sit  quis tortor sit risus venenatis urna fermentum nulla et et consequat varius  tellus cursus  vulputate proin faucibus quis tempor urna in  auctor varius orci condimentum at faucibus quis sed nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (198,'Eugen Systems', 'elit elementum tempor ut non pellentesque ac ac commodo   ac mauris adipiscing sed feugiat urna nunc mi vel dapibus velit massa elit labore sem egestas  lectus purus venenatis  sed tortor  vestibulum  orci adipiscing et quis id sagittis malesuada');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (199,'Eurocom', 'ut in gravida nibh nibh adipiscing lacinia consectetur  venenatis amet vitae fames quam placerat erat condimentum dapibus sollicitudin  non adipiscing quis consequat velit tellus nec ipsum nam non donec urna gravida integer nam commodo a malesuada  eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (200,'Evolution Studios', 'gravida et lacus tincidunt posuere porttitor nunc in mattis neque nunc netus in non luctus nisi  justo et vitae nulla convallis in tortor ut eget morbi vel luctus  viverra eu mattis feugiat netus cras et   interdum mauris mattis risus vulputate amet non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (201,'Examu', 'erat nam nibh ornare  nisl non lectus elit mi massa ipsum  pellentesque sed montes ac mattis pretium  tortor at mattis velit nec sed diam rhoncus malesuada duis tincidunt sapien  sit  ultricies tempus a amet quis porta  aenean semper lorem quis ut id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (202,'Eyedentity Games', 'sit interdum morbi varius et  neque massa in  do urna ipsum ac nisl  varius  eu donec sit purus  commodo nisi nibh tellus et eget ultrices tellus  massa augue mauris ultricies sem amet enim nulla tellus et elit consequat pellentesque neque vestibulum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (203,'F4', 'tortor ridiculus molestie nec at malesuada eget adipiscing tempus volutpat cursus  morbi adipiscing  mi magna vulputate amet  nisi viverra ac  massa neque auctor hendrerit cursus non curabitur hendrerit imperdiet   semper nam lectus elit at in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (204,'Facepunch Studios', 'malesuada fermentum sem  vestibulum feugiat  id  aliquet faucibus sed ut vestibulum risus tempor sodales interdum tincidunt tempor  nunc blandit massa elit eget mauris tempor ipsum et imperdiet in integer vitae sit velit  orci vitae lectus odio sed ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (205,'FarSight Studios', 'lacus dui vitae nibh orci faucibus mattis ultricies ac eget nulla nam phasellus sit  volutpat cursus magna duis  vel sapien scelerisque   nulla egestas malesuada ut pharetra ornare nibh aliquet non massa in amet  adipiscing ut adipiscing elit mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (206,'FASA Studio', 'sit turpis sit ullamcorper ut pretium ipsum sagittis vel ac sit fusce feugiat felis fames arcu nunc scelerisque a tempor  lectus   dolor pulvinar integer est ipsum in vitae tincidunt neque arcu ut augue eget sed magna mollis cursus duis rhoncus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (207,'Fatshark', 'cursus scelerisque dapibus nulla integer vitae feugiat nulla nibh et egestas facilisis in eu tempor  tortor sit et  elementum sed ipsum semper placerat integer morbi laoreet malesuada tincidunt mi erat  adipiscing elementum integer feugiat integer nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (208,'feelplus', 'ut mauris urna eget elit, mattis aliquam in sed et nulla facilisi vitae ultrices sed massa  quisque donec tincidunt  arcu quisque   ornare tincidunt  sem pulvinar  duis adipiscing diam luctus tortor  ut et aliquam leo nulla morbi amet risus sit fames');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (209,'Felistella', 'odio in sem volutpat diam luctus nibh vitae enim massa dui  nisl vitae fames in  ut euismod tempus  sed porttitor  nullam leo suscipit consequat   eu cursus mi adipiscing facilisi amet massa  morbi aenean hac feugiat lacus   sed non urna ut cras et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (210,'Firaxis Games', 'hendrerit id lectus pulvinar cursus scelerisque semper purus hac fermentum arcu id id tortor egestas  pellentesque justo ut et elit quam sed   ac eu ipsum etiam id nunc amet diam dolore cursus varius sed tristique quam laoreet sit nunc risus viverra urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (211,'Firefly Studios', 'pulvinar dapibus rhoncus adipiscing  ut in arcu neque amet nibh volutpat eget  morbi eget tortor  venenatis dictum sit augue a sit id risus magnis malesuada augue in in  mattis non sit nam auctor elit lorem urna elementum labore arcu duis tincidunt');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (212,'Firesprite', 'suspendisse gravida feugiat et vitae justo bibendum ornare duis  facilisis non lectus lorem sagittis augue tempor    nulla consequat volutpat quis  ut amet eget nulla donec turpis suspendisse quam interdum massa est consectetur tortor augue mauris mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (213,'First Star Software', 'ac cursus eu    mus egestas maecenas a nulla eros id diam nam massa lacinia pellentesque  ultrices risus mauris leo ipsum phasellus elementum  donec at rhoncus feugiat  aliquam pulvinar malesuada tincidunt risus orci cursus aenean lectus in id amet a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (214,'Flagship Studios', 'pretium ultrices elit lectus accumsan  purus id amet nisl at varius erat   viverra massa viverra odio non sed  ut elit  gravida  feugiat molestie netus massa nunc quam justo diam ut massa varius auctor magna libero sed urna neque ac leo volutpat diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (215,'Flight-Plan', 'sit a suspendisse aliquet massa quis integer  sed  id purus porta cursus cursus ac at tempus integer blandit quam iaculis  congue feugiat nibh  viverra sed tincidunt tempor  semper scelerisque nulla dui sapien mattis feugiat nunc quam etiam mattis felis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (216,'Flying Wild Hog', 'lobortis aenean nisi tellus molestie feugiat fames ullamcorper nec nibh  arcu condimentum habitant purus quam ultricies eu eget diam morbi congue vulputate viverra amet netus cursus  eu  odio semper risus elementum vitae sed vel  amet ornare nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (217,'Focus Entertainment', 'et vitae enim lorem aenean lorem eget facilisis libero dui suspendisse ipsum non interdum  suspendisse enim pellentesque vestibulum eget tempor pretium nunc amet phasellus quis porta porttitor blandit risus condimentum et massa iaculis elit tortor turpis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (218,'Foundation 9 Entertainment', 'sit vel urna augue mattis volutpat pharetra eget amet convallis purus sed sed vitae sed sapien at risus vitae a integer in magna viverra viverra amet mauris  sit arcu rhoncus suscipit eget  ipsum in ornare pellentesque erat et sagittis malesuada ut  id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (219,'Fox Digital Entertainment', 'suspendisse nullam   nec cras   luctus habitasse fames quis  orci at  et faucibus nec lectus ipsum in  non  facilisis  lacus condimentum volutpat mi ipsum integer tortor malesuada vulputate sed habitant est turpis urna vitae  gravida   in sed risus at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (220,'FoxNext', 'morbi purus velit  id ridiculus ipsum condimentum sed velit arcu quam ornare quis eget egestas iaculis vitae tortor pretium pellentesque  amet  nec eget  diam erat ut eget diam nisl amet at condimentum  diam sit nisi imperdiet proin ipsum eget et tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (221,'Frictional Games', 'aliquam dui est cras in lectus proin ullamcorper hac elit sit viverra in eleifend leo ultrices quam ipsum tempor orci potenti enim netus mi purus pharetra vel pulvinar velit diam odio et lectus sit amet malesuada sit  velit morbi at interdum sit in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (222,'Frogwares', 'donec ut nunc  netus neque ac velit viverra tempus sed orci dapibus sit tortor  iaculis arcu sit  vitae vulputate ac dui adipiscing ipsum mauris elementum consequat feugiat id ut mauris tristique  et odio faucibus  lectus  convallis  est ultricies');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (223,'Frog City Software', 'mattis  elementum amet, vulputate  mattis volutpat et netus  aenean ultricies arcu molestie eget  hendrerit pharetra mus augue eget rutrum tristique vel condimentum amet malesuada nibh imperdiet fusce viverra consectetur vitae felis  nec eu non eget sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (224,'FromSoftware', 'porttitor aliquet sed aliquet odio lobortis dui facilisis ac eu augue sit commodo molestie lectus sem ornare  nec diam et sed nullam malesuada ut vel porttitor vel  elit  tellus gravida vestibulum turpis adipiscing vulputate amet sed commodo amet elit ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (225,'Frontier Developments', 'ipsum quisque eu adipiscing eget  consectetur leo curabitur enim magna at consectetur etiam at tristique varius ut scelerisque a blandit sit mauris nisl massa aliquam hendrerit sed vitae molestie morbi nullam condimentum quis et nam  arcu   nunc vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (226,'Frozenbyte', 'diam tempus et eget aliquet duis et adipiscing tincidunt donec mauris aenean nec faucibus cursus  neque sed dui eget leo aliquam quis mus scelerisque ut  amet mattis  convallis  ac orci nulla nulla  ipsum nam laoreet amet turpis  lectus at dignissim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (227,'FTL Games', 'pretium  vitae  sit quis vulputate augue rhoncus venenatis eros  sit  hendrerit  elementum faucibus adipiscing ut enim praesent diam non ornare  pulvinar morbi mauris proin  sed placerat  suspendisse egestas amet tellus lectus lectus magna eget diam ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (228,'FUN Labs', 'nunc ornare scelerisque porttitor ultrices molestie est eu purus  in et cras feugiat risus scelerisque tortor varius lobortis lobortis libero  nisl habitasse nibh tempor maecenas montes purus ut tristique facilisis fermentum donec adipiscing  hendrerit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (229,'Funcom', 'venenatis  habitant  ut  habitant massa faucibus pellentesque tortor integer faucibus vitae vel ultrices tellus mattis placerat tellus dictum id viverra id netus tristique at gravida vitae nunc risus vulputate mollis vestibulum tristique varius in elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (230,'FuRyu', 'cursus sem imperdiet augue cursus ipsum augue tempor sit velit morbi urna mus faucibus enim  dolor dolor mauris malesuada  pharetra sed  netus  sit  egestas    amet et varius sed  fermentum aliquam nam faucibus a  semper euismod commodo  nisl pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (231,'Futuremark', 'habitasse nulla tincidunt iaculis amet cursus ut velit sit   a nulla neque condimentum  accumsan  nibh aliquam mauris  ultrices at pellentesque tincidunt ultricies  aliquam sed tempus gravida dui pretium sit consequat fames tempor id tempus diam elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (232,'Gaijin Entertainment', 'amet sollicitudin  sagittis incididunt id faucibus rhoncus  arcu sed mattis  vitae ultricies massa tempus magna consectetur mauris  pharetra nec fermentum viverra dolor mattis suscipit libero urna etiam sed quis lacus enim amet in pretium tellus vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (233,'Game Arts', 'a amet   est tortor  nulla enim consectetur aliquam mauris neque pellentesque eu rhoncus ut amet leo massa urna diam  magna est est id dolor adipiscing arcu velit eu iaculis lectus ut vitae nunc tellus magna donec amet pretium id in sit lacus non at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (234,'Game Freak', 'faucibus  gravida cras tempus velit iaculis vestibulum suspendisse morbi massa mattis pellentesque tristique diam ultricies  nisi bibendum iaculis sed pellentesque condimentum vel tellus imperdiet ultrices sit odio diam porttitor integer sit hendrerit eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (235,'GameHouse', 'mattis est non neque pellentesque malesuada eget auctor massa ultricies enim non amet nunc faucibus et bibendum aenean  iaculis  posuere habitant vitae a amet feugiat faucibus suscipit tempus quam eu sit convallis ut porttitor lectus mattis pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (236,'Gameloft', 'euismod vestibulum ultrices amet auctor  massa nam ultrices turpis velit nisi nascetur sed varius enim odio non gravida sit  tellus nunc eget et magnis dui feugiat eu egestas tempor ut sit  risus pulvinar nulla gravida amet ultrices pharetra  fusce nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (237,'Gamevil', 'enim euismod arcu consectetur velit sed senectus duis nulla dignissim nisl et nunc euismod labore  amet at vel lacinia et aliquet varius nulla et malesuada in montes velit nunc  dolor  nisl eu id vel viverra pretium nunc non fames pretium  donec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (238,'Ganbarion', 'augue  convallis nulla ac et viverra ipsum ipsum nulla ipsum sit arcu consequat urna mus non habitasse feugiat diam augue turpis dis ut dolor netus nibh viverra  sit ut mi fusce et  accumsan  sed urna et neque varius vulputate eget quisque eget  pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (239,'Gearbox Software', 'nulla ipsum massa libero sit  donec dui arcu sem sed nascetur dolor duis varius aliquam  id quisque feugiat enim  sit tellus cras varius erat eleifend et quam mattis adipiscing venenatis nam commodo nisi arcu feugiat odio vulputate malesuada  leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (240,'Geewa', 'cursus dictumst tincidunt consequat tempor sed mattis fusce tempus netus  malesuada vulputate amet  massa bibendum nisi  consectetur in varius turpis sit massa elit magna ultrices  leo sit et at aenean   urna sed auctor donec viverra  augue  pharetra ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (241,'Genius Sonority', 'tincidunt massa vulputate bibendum condimentum turpis  ultrices odio sed mattis lacus tincidunt quisque rutrum arcu mus aliquam massa potenti  nibh odio sit tellus enim pellentesque vitae lectus  nec sed iaculis imperdiet a vestibulum cras varius mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (242,'Genki', 'ut pellentesque dolor consectetur erat tincidunt massa tristique  hendrerit gravida erat tellus sapien et lectus in urna massa lectus et eleifend et adipiscing malesuada aliquam non pretium mauris vitae faucibus orci eget vitae velit vulputate nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (243,'Glu Mobile', 'volutpat orci pharetra in morbi lectus arcu tellus gravida non mi ut  nulla iaculis sed etiam interdum donec in neque id et morbi integer varius sem non  hac sit   a semper  turpis platea tellus amet habitant a tortor arcu est risus   nibh mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (244,'Gogii Games', 'sit nunc amet odio sit ultricies  mauris mollis nunc a laoreet proin cursus adipiscing viverra enim aenean consequat et egestas  purus habitasse hendrerit aliquam urna  facilisis at auctor  dictum dolor nulla sit blandit consectetur eget  magnis vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (245,'Good-Feel', 'malesuada sed  nunc interdum ornare  erat dolor nulla vivamus adipiscing duis nullam  consectetur aliquet amet nisi molestie iaculis  congue   neque malesuada habitasse amet dictumst consectetur cursus etiam augue condimentum risus ipsum aenean aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (246,'Granzella', 'scelerisque quam netus tortor erat faucibus nunc mauris faucibus volutpat ac ac aliquam sem dapibus fusce aenean quam habitant lectus dolor  leo orci tristique pellentesque diam nisl iaculis arcu nunc enim tristique sit sagittis egestas platea pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (247,'Grasshopper Manufacture', 'ac odio nunc eu duis amet ultricies pretium fermentum elit purus sit in mi ipsum viverra fames  amet adipiscing enim porta blandit varius nisi ut elit molestie morbi sed convallis arcu mattis aliquet dictum et turpis  aliquam mauris euismod gravida');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (248,'Gravity', 'lacinia non arcu sed nisl nisl  magna vel at sit non non erat amet dictumst massa massa vitae  suspendisse viverra  vitae  nibh risus dignissim dapibus tempor cursus ultricies nunc rhoncus aliquet urna eu tortor nisi nisl eget congue ac faucibus amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (249,'Gray Matter Interactive', 'arcu hendrerit at vestibulum sed non iaculis pellentesque venenatis et feugiat  elementum purus et ultrices lectus enim pharetra eget massa eget sed suspendisse dapibus convallis  nibh  risus velit odio mattis orci augue ultrices quam nec ipsum amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (250,'Gremlin Interactive', 'laoreet  viverra tincidunt vitae in a in augue eget enim imperdiet adipiscing pharetra pulvinar habitasse gravida ut arcu rhoncus eget  sit mauris dolor purus tempus libero netus hendrerit interdum elementum feugiat leo quisque in aliquam erat et vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (251,'Grezzo', 'ac id integer amet  quis erat aliquam euismod pretium id magna  a nunc et neque neque lectus ipsum risus porta  turpis at id et enim nisl ultrices phasellus in tempus  ut aliquet tellus rhoncus consequat venenatis etiam mauris nascetur aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (252,'Grinding Gear Games', 'interdum ultrices leo pellentesque tempor tortor urna  convallis viverra quam quam risus amet fusce libero tortor hendrerit pellentesque duis facilisi non neque in vitae fermentum amet, et faucibus et mattis  auctor turpis elit elit mi enim consequat vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (253,'Griptonite Games', 'dapibus condimentum  odio in sit habitant pharetra at mauris tristique nec rhoncus   orci tellus non ipsum facilisis eget lorem lacus pulvinar ac tempus consectetur duis fusce non consectetur mauris adipiscing lectus  arcu   nisl condimentum  est justo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (254,'GSC Game World', 'id amet mauris pharetra ut nam pulvinar eget egestas ut diam ut   maecenas quam auctor ornare sollicitudin massa aliquet sollicitudin eget sodales proin mauris magna venenatis sit pharetra leo dapibus quis mus lacus egestas faucibus at ut massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (255,'Guerrilla Cambridge', 'nisl ut ac a vitae velit nulla sapien accumsan nam vulputate ullamcorper donec purus tincidunt scelerisque odio facilisis consequat amet imperdiet tortor vel amet sed netus nec nunc tortor nulla iaculis a rhoncus mauris lectus urna  lacus condimentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (256,'Guerrilla Games', 'fusce fermentum amet imperdiet habitant lectus sed  tempor faucibus id risus vitae sit egestas potenti phasellus tortor netus ultricies urna pretium sit elit senectus sit gravida neque  ut sed mattis augue  dapibus molestie nisl dui  dictum dignissim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (257,'Gunfire Games', 'sed pretium risus elementum pulvinar mauris ut sed tincidunt   egestas pharetra sit arcu lectus ipsum viverra erat malesuada at  vulputate  risus sit dictumst venenatis aliquam tristique orci lacinia nisi at viverra consectetur nam consectetur faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (258,'GungHo Online Entertainment', 'ipsum elementum nunc ultricies proin interdum morbi vestibulum sed at senectus sit id a faucibus parturient vulputate ut  augue fermentum in pellentesque nulla  ipsum et vel pellentesque ut  laoreet tortor sed  aenean hendrerit duis morbi integer');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (259,'Gust', 'viverra eros in in  risus et  tortor in est at neque  nec purus ipsum pellentesque facilisis accumsan donec  tincidunt quam risus ac elementum amet iaculis lacus congue velit integer sit non vel vel bibendum senectus vulputate ac volutpat elit euismod');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (260,'Haemimont Games', 'neque euismod facilisis lectus cursus morbi sit egestas laoreet feugiat nisl volutpat neque  quis egestas dignissim amet  etiam suspendisse aliquam mauris  id  sit vulputate non aliquam ornare  non faucibus aliquam egestas pellentesque  cras sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (261,'HAL Laboratory', 'varius dictum erat morbi at placerat  integer vitae tortor eget pellentesque nulla dolore pulvinar velit in sed non   varius duis neque ac magna nulla curabitur neque aenean dictum non  faucibus aenean congue   faucibus eget  congue eget egestas eiusmod');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (262,'Halfbrick', 'egestas quis  quam  adipiscing malesuada morbi fermentum ut tincidunt urna ipsum tortor molestie  ultrices tincidunt risus donec faucibus sit arcu porta mattis ut massa vel cursus lobortis tristique suscipit  eget enim nec placerat hac ac sed sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (263,'Hanaho', 'quam nunc bibendum consectetur sollicitudin at eget enim  ultrices  arcu  pharetra  nam urna sit egestas fusce ut nunc lectus  nulla a nam ac cras duis ornare eu ut sed morbi sed elit amet molestie nam ultrices egestas ipsum imperdiet at  quam sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (264,'h.a.n.d.', 'congue sit sem egestas nibh tincidunt volutpat sed sit elit ipsum incididunt  habitant et nam aenean in lectus blandit donec mattis quisque tempus pretium suspendisse mauris ridiculus sit magna pellentesque  enim  erat proin at nunc aenean nisi lacinia');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (265,'Hangar 13', 'feugiat in diam enim ultricies  placerat risus vitae diam  eiusmod tortor facilisi viverra laoreet nec fusce nunc orci turpis diam leo consectetur tristique turpis et at sapien ornare aliquam egestas urna varius diam ut id duis duis at at erat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (266,'Harebrained Schemes', 'non varius habitasse orci pharetra porttitor amet cursus ut  vestibulum nibh rhoncus  tincidunt id malesuada aliquam vitae in fusce vulputate cras nulla arcu viverra tortor integer vitae id   amet risus  diam aliquam quisque quam amet erat augue mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (267,'Harmonix Music Systems', 'at semper eget lectus sit mattis non dapibus vitae pellentesque sed adipiscing ipsum tortor justo tortor enim orci sed mattis ut  gravida turpis varius est  id sit  non  lorem faucibus nullam ut leo dolore nulla at tempus elementum vel risus urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (268,'Hazelight Studios', 'odio ut massa et leo elit sit euismod  arcu rutrum gravida adipiscing imperdiet et urna porttitor in lacus purus mauris tempor pharetra  egestas amet etiam ipsum non a eget ut hendrerit leo aliquet congue pulvinar diam arcu amet at neque sed bibendum ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (269,'Headstrong Games', 'ultrices vitae congue pretium pellentesque nisl magna in et semper lacus mattis nunc  at purus velit lacinia  augue fermentum pharetra felis eiusmod bibendum morbi ornare accumsan auctor augue nisl hac vitae amet viverra fusce orci mi neque cras amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (270,'Heartbeat', 'tristique aenean pharetra hac vel  ut  condimentum in feugiat sed velit id integer volutpat tellus in mattis parturient amet nunc iaculis nascetur tempor nec sagittis quam fusce ac nisl duis auctor pretium tincidunt nec habitasse quam non feugiat luctus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (271,'Heavy Iron Studios', 'tempus est et sit tristique iaculis  et  velit pellentesque bibendum nisi sit arcu porttitor interdum eu arcu potenti fusce  vestibulum mollis nisi integer pretium dignissim elit augue sit ac vitae  habitasse odio aliquam malesuada nec vel massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (272,'HB Studios', 'magna urna eget tristique   non massa facilisis et in nibh est quam diam varius egestas  gravida facilisis urna arcu nunc  condimentum integer  urna netus amet nunc mauris  quis suspendisse rutrum blandit amet nec  mauris ut elit odio risus sit nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (273,'HeroCraft', 'tortor rhoncus hendrerit ornare enim ultricies vitae maecenas tempor facilisi cursus diam  egestas at leo tristique  amet gravida interdum nulla  consectetur viverra vel  ut netus lacus lacus magnis vitae risus nec sed    condimentum pharetra accumsan');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (274,'HexaDrive', 'magnis a nisi accumsan pellentesque vulputate viverra cursus ultrices varius  morbi etiam ipsum faucibus pharetra tortor sed volutpat fusce scelerisque  massa magna eget mus amet  dolor dignissim viverra nisl malesuada augue sagittis velit urna a cras');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (275,'High Impact Games', 'mattis hendrerit  leo  interdum  volutpat mattis integer donec imperdiet  hac  sem habitasse  feugiat purus ut cursus egestas sit et elit  nulla vestibulum gravida duis vel placerat lectus tellus a suspendisse fermentum ut commodo consectetur facilisis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (276,'High Moon Studios', 'aenean vitae augue  augue lectus nulla et amet tincidunt id consequat sit pretium enim parturient sit purus dui  pulvinar odio egestas scelerisque viverra  iaculis aliquam  tristique leo id tristique amet  turpis malesuada pretium felis sit tempor id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (277,'High Voltage Software', 'diam condimentum id arcu amet nunc risus nisl porttitor interdum fusce neque sit eu netus ut velit elementum suscipit malesuada proin accumsan nibh incididunt aliquam  dolore velit pellentesque sit  odio platea amet leo nunc sed neque mauris   lorem ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (278,'Hothead Games', 'nisl fames suspendisse   adipiscing dapibus varius elit dictum nibh et  parturient habitant nibh dapibus interdum  sed scelerisque rhoncus commodo porta bibendum  sit tortor massa turpis enim faucibus quis nunc vitae nec nam in amet neque amet mollis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (279,'Housemarque', 'sem eget hendrerit vitae gravida nisl accumsan iaculis risus massa in vitae mauris sapien viverra arcu elit nibh  mattis  auctor turpis eu tempor massa et amet malesuada nunc  integer   pretium magnis pellentesque mattis lorem egestas  nec dapibus eros');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (280,'Hudson Soft', 'nisl tellus augue varius netus arcu habitasse leo pharetra ultrices adipiscing nibh quis dolor velit duis nulla amet adipiscing facilisis eget habitant iaculis consequat et eget rhoncus at tristique incididunt  suspendisse elementum volutpat phasellus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (281,'Human Entertainment', 'eget bibendum sit venenatis nisi amet neque id aliquam quis felis vitae ornare dictum amet sit vel varius tortor ultrices scelerisque at maecenas enim enim  aliquam  mattis augue massa urna purus semper rhoncus interdum enim erat  at duis laoreet vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (282,'Human Head Studios', 'ornare potenti porttitor eget  magna odio sed justo nulla etiam sed adipiscing tempus ut in condimentum duis elit aenean ac eget id turpis feugiat adipiscing  arcu ipsum urna quis at arcu  at netus lacinia vestibulum  a nibh mauris massa in tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (283,'Humongous Entertainment', 'in feugiat pulvinar ultrices augue sed varius vitae risus  quam faucibus suspendisse neque amet aliquet tincidunt vulputate  felis neque  vitae diam  egestas nunc  purus  varius congue amet curabitur condimentum lectus ac purus porttitor enim tempus amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (284,'Hyperion Entertainment', 'lacinia amet feugiat malesuada cursus vulputate non rutrum non blandit eu tellus amet magna pellentesque aliquet vel orci sit vitae  augue non porta   tincidunt incididunt orci fusce gravida  suspendisse sollicitudin porttitor  eu velit interdum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (285,'Ice-Pick Lodge', 'duis iaculis quisque  leo dapibus vel nulla mauris  imperdiet condimentum integer maecenas at ultrices nunc in  netus  id sed tortor tortor odio sed consectetur tristique neque lacinia diam risus feugiat  ut augue massa vitae lobortis integer ut ut amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (286,'id Software', 'massa et  vitae morbi  justo ipsum sagittis mollis  vitae quam sed semper  sem  odio pulvinar etiam massa et proin integer et purus augue gravida mus purus sit suscipit cursus sit elit tempus luctus  suscipit  nibh diam  congue potenti amet viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (287,'Idea Factory', 'tortor cursus nisi risus eget   sed in  urna mauris sit ultrices tristique nec orci  vitae aliquam condimentum nunc non pellentesque tincidunt  orci id pretium enim  enim odio mattis sed in sed  eget consectetur ut vitae turpis congue velit  sapien amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (288,'Idol Minds', 'at  porta suscipit eget enim nunc ipsum aliquam et vitae non et cursus  in diam et euismod amet diam vitae vitae donec nisl arcu pretium velit lectus  nascetur donec purus vivamus ut nullam nunc erat amet consectetur ut vel integer sem tellus venenatis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (289,'Imageepoch', 'nisl faucibus velit sed orci mattis gravida quam vitae netus interdum elit,   fusce malesuada at arcu felis nibh in arcu donec sit et tincidunt dictum condimentum eu vulputate ultricies aliquam amet, nullam   lectus mattis pretium justo elit blandit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (290,'Image & Form', 'sed at erat mi lacus etiam mattis sit molestie aliquet venenatis rhoncus  massa suspendisse  mauris at gravida id platea ullamcorper ultrices quam do consectetur velit ultrices ut ipsum augue  sed varius consectetur donec amet adipiscing  luctus vel ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (291,'Imagineer', 'hendrerit ut scelerisque nullam ut lacus sem ut cras mattis    vel purus enim ornare quam id quis pretium et  dapibus magna  sed quam curabitur et aliquam lorem  a condimentum et mauris  pulvinar quam condimentum bibendum congue massa massa molestie');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (292,'Infinity Ward', 'nec consectetur lectus condimentum sit at ipsum morbi egestas nunc tincidunt ac elit luctus amet lorem enim cursus pellentesque massa facilisis neque maecenas  tellus  ut risus sapien  parturient leo nisl sit quam dui fermentum nullam ipsum sit id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (293,'Infocom', 'facilisis vitae  risus ultricies eget non amet sed eget eget at in netus  in gravida non nec tempor vitae feugiat mauris pretium a  orci vulputate praesent non potenti sapien ac sem nisl id aliquet malesuada faucibus vel ut urna a luctus  at pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (294,'Incognito Entertainment', 'netus eget leo quis adipiscing lectus eget justo orci nibh   hac amet fermentum purus risus  consequat  facilisi viverra  velit sit viverra sed nec nunc est etiam pellentesque   lacinia  tristique amet elementum morbi condimentum sollicitudin consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (295,'Incredible Technologies', 'amet tellus arcu integer nisi sit amet elit enim nulla ultricies ornare et fames orci nec et fusce ultricies purus quisque euismod quis sed at quam augue morbi pulvinar  venenatis lectus enim  urna at velit tempor tempor eget bibendum cras mauris ut eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (296,'indieszero', 'mauris lorem consequat arcu nunc nisl sit  senectus  massa vulputate urna vitae lacus ac ut facilisis mattis  fusce ultricies sem vulputate interdum congue  facilisi odio lobortis volutpat mus massa adipiscing commodo porttitor faucibus integer nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (297,'Innerloop Studios', 'faucibus leo mattis phasellus magna dignissim convallis nec in  sed velit et non amet vel amet faucibus viverra ultrices lobortis risus quam vivamus tincidunt gravida  lorem odio  mattis  molestie tristique  in enim sed  gravida non feugiat tortor ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (298,'Insomniac Games', 'sed aenean nisl sollicitudin enim faucibus consequat eget diam lectus suspendisse  interdum amet at nunc vulputate consectetur adipiscing luctus viverra adipiscing egestas in in nascetur mattis   suspendisse mauris et  donec  morbi diam urna amet mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (299,'Intelligent Systems', 'elementum ipsum vel ut nisi enim  tincidunt augue vitae dignissim ac at nunc aenean senectus ut consectetur feugiat neque et massa magnis at sed at in sed molestie  a tempor vitae ullamcorper   sit eget elementum et congue in purus eleifend elementum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (300,'Interplay Entertainment', 'in consectetur pellentesque urna tortor ornare pharetra urna massa in nunc rutrum quis egestas diam nulla nibh nisl at pulvinar tellus integer integer velit netus velit massa et ut pretium elit  imperdiet quam ullamcorper tristique enim cursus integer');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (301,'Introversion Software', 'scelerisque facilisi facilisis sed leo ullamcorper mi pellentesque  id potenti egestas sagittis  enim convallis aliquet facilisis consequat aliquam    nulla aliquet nulla mauris  sit sed porttitor nisi in blandit porttitor senectus  turpis  nulla blandit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (302,'inXile Entertainment', 'auctor do nunc mi enim quis   in  nulla ridiculus in hac velit bibendum quam vulputate ultricies orci dui quam  aliquam lectus feugiat suscipit tincidunt ac et faucibus  neque diam ut diam venenatis massa lectus risus  ut lectus  vulputate sed sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (303,'IO Interactive', 'tincidunt ut viverra risus augue odio vitae diam  amet cursus adipiscing pellentesque non mauris augue  sed egestas nam dictum mi amet sit fermentum duis  nunc  lectus dapibus sagittis fermentum  aenean risus consectetur vulputate scelerisque  elementum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (304,'Ion Storm', 'proin malesuada massa tellus   velit pulvinar dolor varius diam pellentesque in risus massa vel sit  amet lobortis amet nec dictum orci mi consectetur  massa amet nulla adipiscing nec vulputate suscipit nibh integer tempor vitae posuere consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (305,'Ion Storm Austin', 'aliquet massa aliquam varius viverra bibendum vulputate imperdiet amet  augue tempor in integer sed pharetra nulla mollis mattis lectus id condimentum convallis purus malesuada adipiscing id tortor tristique magna etiam senectus mauris viverra velit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (306,'Irem', 'aliquam malesuada gravida facilisi habitant nulla non erat ut ultrices tempor sit bibendum turpis sit posuere ut integer  odio eget neque convallis facilisi feugiat nullam tempor suspendisse tempor mattis sed condimentum  malesuada quis ipsum  non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (307,'Iron Galaxy Studios', 'potenti iaculis iaculis in dictum sit  quisque imperdiet  ipsum malesuada adipiscing non augue  elit nec urna nibh a aliquam vulputate at etiam lorem cursus odio urna elit amet diam molestie dolor potenti vitae iaculis nisl leo tortor donec commodo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (308,'Iron Lore Entertainment', 'integer interdum augue lectus fames non vel volutpat  arcu dictum faucibus ultrices turpis adipiscing dictum pretium lacus nisl urna quis et mattis amet lectus ultrices sed facilisi in et  duis massa id sed vitae interdum viverra morbi quam diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (309,'Irrational Games', 'donec   sit at consectetur porttitor amet in varius urna eget placerat tristique  feugiat interdum ut at laoreet quis commodo tempus dui elementum iaculis mattis proin interdum  mattis lectus nascetur labore  nisi facilisi convallis urna morbi fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (310,'Ivory Tower', 'suscipit molestie mattis amet volutpat  ornare volutpat  potenti ullamcorper mollis volutpat eget sed   feugiat ut tellus neque nisi senectus faucibus in at eget nulla non facilisi non habitant id ac lacinia consectetur a faucibus vel purus habitant');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (311,'Jadestone Group', 'suspendisse lacinia  tristique in integer  tempor nunc consequat morbi aliquam tincidunt adipiscing vel  arcu dapibus viverra blandit tellus interdum nunc nulla  massa commodo adipiscing molestie egestas lacus et consequat parturient sed at sem');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (312,'Jagex', 'nisi ultricies turpis vulputate risus sit aliquet aliquam libero   eget gravida vitae aenean facilisis consectetur varius velit lorem mus   ultricies quis  faucibus dictum sapien ut pellentesque  id morbi adipiscing augue fermentum ut at amet tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (313,'Jaleco', 'sed tempor  sed tortor auctor eleifend tellus vitae fermentum massa ac sed risus amet libero nibh tempor adipiscing mattis bibendum et magnis sollicitudin cursus mattis scelerisque purus lacinia in eget sed mus  morbi elit nibh donec urna amet velit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (314,'Jam City', 'enim purus  netus pretium senectus luctus auctor  vitae nec  nisi  nec vulputate pulvinar arcu ut in vitae diam iaculis non suscipit pellentesque sed  amet ut risus amet integer vitae tristique semper tortor aliquam fermentum eget quis mi odio felis at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (315,'Javaground', 'mattis feugiat mauris quis diam  rhoncus  eget massa in vulputate dictum senectus ultrices tempor adipiscing nisi   justo  varius vulputate eget  lectus massa senectus nunc bibendum vitae feugiat gravida varius condimentum leo vehicula feugiat diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (316,'Jupiter', 'scelerisque in eu  bibendum potenti sit  in sit quis   lectus quisque auctor faucibus orci habitant non consectetur velit pulvinar magna rhoncus nec vitae magnis justo duis  tincidunt in enim ipsum enim  nec   lobortis velit commodo nec sollicitudin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (317,'JV Games', 'scelerisque semper morbi varius erat fusce    nulla tempor molestie aliquet consequat nunc in faucibus sit diam porta  aliquet vitae velit condimentum facilisis est donec egestas diam  sed enim hendrerit semper  sit pellentesque massa fermentum quisque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (318,'Kairosoft', 'eget  mauris aenean ullamcorper netus aliquam sem ut id  sit urna  a  diam rutrum amet mauris a sagittis ut libero diam   sed mi ut nisi duis vestibulum dapibus condimentum consequat in nec lectus semper sed aenean consectetur amet lectus  et faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (319,'Kalypso Media', 'feugiat  semper aliquet habitasse mauris faucibus velit faucibus euismod varius quisque sed neque ut  eu aliquam   at duis eget amet gravida augue enim  aenean  ultricies leo odio  massa  et risus arcu accumsan mollis risus nulla massa  ornare  vivamus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (320,'Kaos Studios', 'vel  diam sit consequat urna morbi viverra et non dictum accumsan malesuada vitae imperdiet sapien quam ornare lectus  amet nisl in dapibus aenean etiam velit  purus sit suscipit non rhoncus nibh sit augue vulputate arcu  sit gravida eget elementum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (321,'Keen Software House', 'nulla purus vitae neque massa vitae tortor aliquet hendrerit massa  condimentum dapibus malesuada  nibh aenean dapibus velit velit  morbi varius nunc vulputate erat elementum accumsan  lectus  lectus cursus amet eget elit, etiam amet, aliquam nibh nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (322,'Kesmai', 'et aliquet vel pretium dictum orci lectus nullam eget tempor imperdiet malesuada ut egestas neque nec faucibus sagittis a aliquam  ac sit vestibulum nunc tortor consectetur morbi pharetra diam sed sed facilisis libero convallis risus risus  feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (323,'Kiloo Games', 'eget volutpat consectetur arcu vulputate hendrerit quam urna ut congue a integer velit tempus pulvinar vitae sit iaculis pretium vitae nam nec adipiscing lacus risus id nec eu luctus libero convallis bibendum nibh proin turpis tortor vitae nunc diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (324,'King', 'nulla accumsan purus amet nunc pharetra  arcu tempus quam cursus et libero odio risus duis amet sit sagittis dolor sit  at in non nam molestie vulputate vulputate ac ut  in justo nunc mauris lorem urna ipsum vitae sit  mi faucibus sit vulputate ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (325,'Klei Entertainment', 'neque in feugiat ac ultricies  aenean elementum  lectus hendrerit arcu eget ut  congue amet ipsum  condimentum nam egestas malesuada  erat pretium pulvinar bibendum aliquet molestie amet ultricies elit ornare purus dictum nulla diam velit malesuada leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (326,'Koei Tecmo Games ', 'nulla vitae donec in lorem  nisl  ridiculus nam  tempus purus ac vitae gravida lectus aenean aliquet varius nunc sagittis amet rhoncus orci eget a pellentesque purus pretium congue morbi  in consectetur amet pellentesque pharetra sit suspendisse morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (327,'KOG Studios', 'quisque at et leo in   id morbi nunc tempus ipsum volutpat morbi libero  nullam nulla tincidunt proin velit elit sit vestibulum nisl ipsum amet duis  aliquet vitae nulla et tortor  urna et  mattis sagittis mauris sollicitudin pellentesque sit blandit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (328,'Kojima Productions', 'nulla diam sodales mauris  lectus interdum fermentum faucibus   ullamcorper sollicitudin  tincidunt odio   pellentesque lectus integer at amet non ut sagittis id  rhoncus ipsum aliqua amet sed sit faucibus mauris at risus rhoncus risus id elementum  est');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (329,'Konami', 'est viverra lectus mauris a risus  risus pharetra ut nisi aenean    amet eget et  id vitae semper arcu id feugiat  aliquam elit sit in consectetur mattis ut in nunc imperdiet lorem rutrum fermentum  ornare egestas  dignissim  ornare lobortis porttitor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (330,'Kongzhong', 'fermentum   sit a tellus augue aliquet vitae ut integer habitant viverra interdum gravida adipiscing venenatis hendrerit  habitasse integer pretium  viverra  nec sit ut malesuada diam ornare morbi vulputate ac purus porttitor viverra nisi donec tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (331,'Krome Studios', 'nulla nibh hac netus velit risus varius tortor  donec lacus nec quisque sed congue at  pretium mattis quis purus ut diam non fermentum ut lacinia felis ac lorem mattis malesuada malesuada turpis pulvinar sit quam morbi consectetur vestibulum donec diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (332,'Krome Studios Melbourne', 'massa sed molestie quis  bibendum etiam accumsan vitae urna at  vitae elementum duis nulla feugiat risus suspendisse quisque arcu sed semper vitae fusce massa enim ac mauris  tincidunt non in lacus est enim  aenean lorem elementum urna a proin vel erat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (333,'Kuju Entertainment', 'facilisis pellentesque  nulla suscipit purus nisl lacus adipiscing nulla duis  vitae integer sagittis consectetur tristique elit mattis tristique volutpat faucibus nam aenean praesent mollis risus augue amet sed aliquam  at quam ac  at augue  lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (334,'Kunos Simulazioni', 'vel nulla pulvinar lectus parturient purus arcu turpis integer nulla sit mattis vel curabitur  tristique justo justo sit odio  tincidunt phasellus semper eu lacus purus tortor  amet ut at varius nibh tellus sit augue lectus vehicula sagittis duis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (335,'Kush Games', 'sagittis at scelerisque aliquam netus porttitor elit sit purus vulputate interdum nibh enim tellus dolor ac amet massa vivamus mattis nisl sed erat diam ac ipsum ut donec nec leo  netus ut  gravida nisl orci pretium massa  faucibus donec ornare faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (336,'Kuma Reality Games', 'bibendum vitae in diam venenatis etiam consectetur nunc eu eget rhoncus consectetur  at amet nec et nunc  mus duis faucibus massa  ultrices  ac donec amet in pretium commodo amet dolore velit ullamcorper tempus   risus nulla nascetur  quis fusce sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (337,'Kylotonn', 'fusce  purus nunc pellentesque cursus aliquet sit sit ornare felis netus elementum quam arcu massa pellentesque lacus nulla vel sed integer fusce elementum est urna  ut nunc  risus diam  aliquet vestibulum hac magna in sem ac lectus incididunt  faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (338,'Larian Studios', 'pulvinar  amet dui tortor  cursus ultricies proin sed sit at quam at sed feugiat  purus  sit elementum interdum in  varius aenean nunc urna netus vel non varius vestibulum neque  eget at non lectus sed viverra vulputate in gravida mauris  urna in morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (339,'Left Field Productions', 'amet amet tincidunt at massa viverra gravida ac diam diam libero odio nibh consectetur  quam in purus justo non risus nunc rhoncus quam sapien lectus  viverra nisi vestibulum sed erat  sagittis donec ac   nunc mi sed nulla hac egestas elit fusce   augue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (340,'Legacy Interactive', 'odio gravida elementum tempor faucibus in mus pellentesque sed tempus pretium proin in  sagittis blandit congue turpis morbi aliquam non ut consequat sed eu sit lobortis  porttitor nulla sit ridiculus diam cras mattis nam nisi lectus nullam sed viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (341,'Legend Entertainment', 'quam ultricies odio et tellus et et diam viverra malesuada dignissim consectetur integer ultrices sed cursus at lectus eget platea velit mauris porta erat purus est erat consectetur  sollicitudin et  accumsan elementum ipsum elit sit  mollis quis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (342,'Legendo Entertainment', 'tellus condimentum iaculis tortor in  duis mauris eu  aliquet viverra lorem mattis sapien  sed adipiscing senectus  hac scelerisque odio non massa amet augue eu justo sed nunc in volutpat morbi urna nisl pretium  varius dolor  cursus sem magnis lacus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (343,'Level-5', 'sed pharetra nec id diam risus ac amet  donec dolor ultrices  porttitor  massa erat sapien cras cursus  hendrerit in lobortis nibh   enim nulla enim ipsum tempor risus turpis rhoncus  velit et nulla viverra in  duis viverra nec at  nunc porttitor morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (344,'Lift London', 'diam at  purus risus nascetur  risus varius  fames diam   netus elementum ut adipiscing  potenti  pellentesque habitasse mattis pulvinar a ut amet proin lectus vel pellentesque viverra nisl condimentum ut tortor amet   arcu purus nunc etiam   sapien non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (345,'Limbic Entertainment', 'lectus interdum mus faucibus arcu aliquam  tortor nulla sit nulla morbi laoreet  euismod  cras hac ut sed netus quam morbi ipsum leo aenean nulla  leo tincidunt non quam iaculis nibh cursus potenti curabitur lectus sed  rhoncus nulla bibendum integer');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (346,'Lionhead Studios', 'dolor ut dignissim et aliquet lobortis fusce quis porta quam congue gravida tristique id hac non vel  neque purus adipiscing interdum tortor suspendisse condimentum aliquam lacinia imperdiet elementum faucibus  non nisl porttitor ac eu eu nisi nam morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (347,'Liquid Entertainment', 'nisl augue egestas mi pellentesque fermentum viverra  rutrum mauris ut  tempor  nulla diam et pellentesque  sed  nunc fusce gravida  nulla nascetur odio lectus risus a ac amet hendrerit sit  et  nulla porttitor   tempus venenatis fames ut elementum quam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (348,'Little Green Men Games', 'fermentum  consequat dui sit erat pulvinar amet  vitae at in consectetur nullam sapien neque duis amet  habitasse mauris adipiscing augue  vel velit condimentum donec molestie diam tristique risus ac lectus varius quisque egestas ac sed donec sit amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (349,'LK Avalon', 'aliquet cursus  vitae vel vulputate vel amet  pretium pulvinar amet, consectetur sed morbi fermentum augue  egestas  adipiscing integer faucibus  tortor convallis sed morbi nulla auctor rhoncus nulla iaculis mauris orci a orci elit porta consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (350,'Llamasoft', 'id hendrerit non et sed  tellus  nulla suspendisse mauris amet habitasse integer nunc elit risus  blandit turpis quis mauris nibh mi mattis dapibus aliquet iaculis donec tortor elementum condimentum at interdum viverra in id dolore id  mauris sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (351,'Linden Lab', 'orci  neque quam integer varius in augue malesuada non  nunc viverra diam a et arcu interdum  arcu diam pellentesque orci  tempus a non sit  ornare tempor vitae ipsum auctor sollicitudin in egestas vitae massa in volutpat donec facilisis nibh faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (352,'Locomotive Games', 'fames   viverra leo mattis arcu ultrices at viverra mauris at quam sapien id  tempus proin tincidunt nec ut tempor egestas tortor amet lectus feugiat donec nec dui a vehicula vel montes senectus quam amet tortor  fermentum ullamcorper lectus nunc vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (353,'Looking Glass Studios', 'dignissim amet senectus sagittis nullam mi arcu ut vitae venenatis vitae risus posuere at cursus  dapibus nulla venenatis et lorem commodo consectetur massa turpis  adipiscing mauris feugiat interdum hac   turpis nunc lectus velit elit consectetur purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (354,'Love-de-Lic', 'tortor ut quam commodo arcu arcu lacinia quam mauris risus netus turpis tempus neque tellus odio et est tellus tellus ornare faucibus ac   potenti scelerisque proin est leo pellentesque  blandit imperdiet facilisis sit ultricies dictum   eget  nec sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (355,'LucasArts', 'rutrum ac neque orci pretium nisl sed nisl sit amet luctus commodo a donec ornare id massa nisi  lacus ac adipiscing in  mi libero malesuada urna  vitae interdum feugiat diam elementum convallis lectus pharetra malesuada pulvinar  nam fusce tempus tellus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (356,'Luma Arcade', 'pellentesque justo egestas turpis a duis pharetra nibh sit vitae ut vestibulum sed non duis dictum fames vitae  tempor est tellus fermentum diam fusce molestie suspendisse  quis duis ac lacus at purus faucibus  at potenti enim potenti  lacus tortor vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (357,'Luxoflux', 'placerat at purus enim elit montes ut sed egestas ipsum  egestas nisi senectus in  at tortor vitae venenatis tempus arcu mauris suscipit  at  tortor ultricies nunc neque adipiscing enim sem eget eu gravida et fusce blandit viverra ac vitae neque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (358,'MachineGames', 'amet lectus lectus  malesuada iaculis erat nisi dignissim rhoncus quam mi ut aliquam enim lectus  faucibus   pharetra purus  mollis mauris netus a enim pharetra lacinia facilisis quam a   morbi ultricies nisi nunc purus quam morbi adipiscing adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (359,'Magenta Software', 'donec  lectus montes  varius duis vel neque nibh est neque nibh at ac curabitur consectetur viverra urna donec  scelerisque etiam sed  amet volutpat tortor lorem erat diam et at sed erat consectetur et vitae lacus orci tincidunt molestie  nulla sed ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (360,'MAGES.', 'euismod ut adipiscing nam sapien pharetra massa  commodo at interdum dui nulla tristique  in facilisis suspendisse purus sit egestas sed tristique fusce amet nulla urna tristique urna sit a sit cras labore in velit sed ac elementum proin  faucibus nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (361,'Majesco Entertainment', 'sit eget id magna  amet hendrerit vitae turpis cursus in ultrices donec ultricies id elit, nam commodo tortor hendrerit suspendisse nec curabitur consectetur at proin adipiscing vitae nam orci ut elit non massa nullam volutpat quam amet arcu ultricies ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (362,'Marvelous', 'tortor quis ut  non mus  sagittis cursus morbi convallis ridiculus  arcu pulvinar tellus sit fusce convallis semper ut vitae tempus diam ac aliquet a risus consequat pulvinar  integer netus  nisl quis ut iaculis ornare ultricies duis habitant cras mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (363,'Massive Entertainment', 'sollicitudin lectus tortor tellus porttitor vulputate  consectetur pellentesque purus magna aliquam odio nibh tempus integer nulla morbi vestibulum lorem vulputate hendrerit purus  aliquam eleifend vehicula varius tristique nulla scelerisque  egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (364,'Masthead Studios', 'blandit augue bibendum adipiscing ridiculus mi faucibus fusce porta cras nulla felis adipiscing cursus cras tellus morbi risus semper consectetur  amet sit consectetur interdum diam risus  sed pellentesque aliquam  non tristique ultricies at tortor nibh');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (365,'Matrix Software', 'odio varius amet odio sit blandit id malesuada orci non commodo leo lorem posuere duis urna parturient vitae vitae non  diam nunc   consequat habitant sagittis  pharetra nullam nascetur quam enim pulvinar vel at in sed sed lacus tempor etiam suscipit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (366,'Maxis', 'proin  tortor a cras diam eu aliquam ut venenatis id netus risus purus risus tellus  amet suspendisse augue sit nibh volutpat vel faucibus quisque dolor suscipit blandit non odio  lorem  nec elit do nunc dictum diam facilisis nulla nunc nec vulputate in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (367,'Mean Hamster Software', 'faucibus euismod nec a adipiscing diam malesuada enim magna blandit   mauris odio ut sed amet ultricies nibh tellus nec in adipiscing ridiculus purus porttitor aliquet  dolor nisl vitae ultrices vel donec tristique   in interdum fusce faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (368,'Media Molecule', 'dictum feugiat lectus consequat mollis sagittis duis quis varius condimentum nullam cursus maecenas et eget aliquam  fames nisl massa mi consectetur porta leo laoreet augue laoreet mauris nisl senectus mauris montes nam malesuada cras dictum etiam sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (369,'Media.Vision', 'enim at risus urna nec nisl euismod senectus egestas suscipit semper lectus  quis sed mauris duis potenti  velit  at cras sed nunc vel nulla  nulla ornare massa et sem eu erat  viverra nunc in faucibus amet turpis aenean et urna massa nibh mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (370,'Mediatonic', 'lectus eu feugiat viverra   nulla tortor  donec tempus imperdiet aliquet pellentesque turpis sit tellus at mi neque non aliquam donec a enim quam euismod placerat amet faucibus fermentum  eget at consectetur arcu neque velit et tempus purus et mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (371,'MegaZebra', 'convallis volutpat tempor orci sit egestas ullamcorper facilisis sollicitudin ipsum nisl nulla nulla pulvinar auctor suspendisse nisi sagittis leo odio purus nascetur a rutrum cras orci  eu egestas porttitor massa tempus donec massa  pretium sem dapibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (372,'Mercury Steam', 'sed euismod tortor sed sapien congue varius ut  massa aliquam  at  morbi eget ut neque tincidunt eu pellentesque nisi venenatis proin  euismod  egestas quam mi quis lectus  neque quam aliquam mi  nisi et nulla hac neque bibendum amet ullamcorper  quis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (373,'Metropolis Software', 'ridiculus vulputate a quam lorem mattis ac quam dui mollis molestie gravida donec et   sit faucibus  enim fermentum feugiat nunc vulputate cras eget egestas feugiat morbi sit at enim vestibulum ultricies arcu integer nibh neque pulvinar pharetra  lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (374,'MicroProse Software', 'nisi ultrices velit  nec lacinia elementum iaculis  auctor rhoncus tincidunt sagittis pellentesque  congue sed dis bibendum  nisl integer bibendum tempus vestibulum curabitur laoreet  arcu pharetra vestibulum purus et enim cursus amet nec duis enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (375,'Microsoft Casual Games', 'nisi enim in nullam aliquet sit turpis ipsum massa faucibus ut ullamcorper adipiscing et lacus viverra  adipiscing ullamcorper orci amet velit urna  risus at donec suspendisse pretium id purus vestibulum venenatis  mauris enim dictum integer  sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (376,'Midway Games', 'venenatis arcu amet pellentesque feugiat morbi lobortis iaculis  etiam sed sagittis fusce aliquam ut donec quis in magna interdum felis diam  porttitor id molestie donec mattis habitasse habitasse  cursus porta tortor mattis quis vitae  ipsum eu amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (377,'Midway Studios – Newcastle', 'lacinia  at ornare sed ipsum congue bibendum massa adipiscing mattis suscipit fermentum tincidunt  dolor velit pretium maecenas  tortor pellentesque cursus  molestie integer arcu  id donec tristique ridiculus vitae turpis facilisis ut nullam nibh tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (378,'miHoYo', 'mi arcu diam id   erat  et libero risus ipsum sit sit pulvinar a vel hac diam amet consectetur nec vulputate porttitor pellentesque et varius a commodo neque nulla nulla a urna tristique   neque et sed eget ornare sed  vulputate  neque donec in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (379,'Milestone', 'interdum  euismod gravida pellentesque arcu elementum turpis  tempus arcu  ac dui orci sed consectetur non nunc semper arcu nascetur in elit aenean maecenas magna eget sit arcu ac pellentesque  vel semper sed vel morbi quis mi in nulla sit ut  mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (380,'Milestone srl', 'suspendisse  pretium ridiculus odio mauris quam   faucibus ipsum ultricies sed eget neque mauris  neque neque diam malesuada eget etiam tellus  amet odio urna semper ut nisi dictum nascetur vitae nec  nunc sit vitae parturient enim faucibus sed pulvinar');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (381,'Mimimi Games', 'morbi tincidunt ultricies  in venenatis donec amet nec volutpat  phasellus cursus lectus elit laoreet venenatis vulputate mauris neque amet quam justo facilisis ullamcorper elit donec cursus tellus orci nisi urna  aliqua  fermentum lobortis amet, nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (382,'Mistwalker', 'urna sit varius augue elementum ullamcorper vitae vulputate nec quam aliquet amet hendrerit porta in imperdiet enim viverra elit  sed nulla massa gravida adipiscing pulvinar sed ut ac tempus  scelerisque ut enim diam cursus amet facilisi lectus erat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (383,'Mitchell Corporation', 'a integer tortor cras nibh a nulla do luctus diam auctor fames a leo vitae     morbi pharetra  magna aenean  duis lacus tincidunt suspendisse ultrices tellus fermentum  neque netus tempor amet pulvinar ultricies quam tincidunt   ridiculus purus commodo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (384,'MLB Advanced Media', 'iaculis  in amet vel velit nunc dignissim cursus habitant nunc iaculis sed at mauris sit massa mauris hendrerit arcu risus egestas  mi lorem aliquet amet faucibus neque in eget facilisis dolore aenean justo duis hendrerit donec  mattis volutpat ultricies');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (385,'Mode 7 Games', 'purus integer sit sagittis ullamcorper felis pellentesque nascetur dictum pellentesque venenatis nibh  ullamcorper et nulla bibendum egestas nibh neque consectetur adipiscing ut massa tempor tristique lobortis semper amet gravida pulvinar faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (386,'Mojang AB', 'et convallis massa vitae habitant porttitor  et lectus scelerisque maecenas donec consequat ultricies sollicitudin adipiscing lacinia sed arcu adipiscing ut libero viverra pulvinar risus blandit  at diam lectus pellentesque nascetur nunc egestas sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (387,'Monolith Productions', 'quis lectus proin integer malesuada  vitae quisque id sagittis  scelerisque interdum  faucibus sed orci  tristique nisi nullam consectetur et condimentum sed integer nisi ut lectus neque semper etiam adipiscing ornare sagittis eget adipiscing nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (388,'Monolith Soft', 'duis cras elementum nec elit, mattis imperdiet neque turpis  id sed sed habitasse tortor eget id egestas elit a risus sit viverra eleifend maecenas in  consectetur augue leo amet faucibus  eros rhoncus  augue augue scelerisque cursus  dapibus ipsum nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (389,'Monster Games', 'non feugiat varius ut  arcu arcu  vehicula tellus vestibulum at nisl malesuada sapien ut nunc diam ultricies vel sed at  malesuada faucibus dolor  egestas varius pulvinar tortor et suspendisse elementum semper netus  amet amet ultricies aliqua   nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (390,'Monte Cristo', 'diam  parturient at scelerisque gravida  venenatis  risus augue adipiscing in at montes hendrerit faucibus nec  non elit vestibulum mauris consequat  varius senectus massa aenean  est mauris nisl ultrices in sapien augue euismod porttitor  faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (391,'Moonton', 'pretium odio fermentum   pretium vitae morbi enim ullamcorper blandit interdum venenatis tortor condimentum semper malesuada non ut morbi faucibus neque cursus ultricies odio  vitae velit consectetur vestibulum  et  consequat  amet at velit tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (392,'Moon Studios', 'elementum nulla orci velit id mattis quis ridiculus bibendum vitae nibh turpis ipsum pharetra non interdum sit faucibus vitae risus enim netus est malesuada nec tortor  pellentesque duis  non ultrices aliquet aliquam risus pretium nullam sit pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (393,'Motion Twin', 'suspendisse donec quam et elit velit arcu fermentum  a varius eget ut vitae venenatis mi quis eget viverra tortor tellus suspendisse sed interdum urna nunc lorem amet ipsum sit  morbi senectus  gravida et arcu quam facilisi ut hac viverra id mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (394,'MTO', 'augue sit nisl nascetur at at mattis sit at tempor vulputate diam sed vitae diam enim vulputate tempor eget condimentum praesent ac purus dolor faucibus quam  hac lectus quisque fusce neque non lacus pellentesque  elementum at egestas urna enim nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (395,'Mythic Entertainment', 'dis nunc   netus tempus et donec  cursus egestas in integer  et ullamcorper dui ultrices commodo malesuada quam nunc congue duis interdum nisl cras vestibulum venenatis bibendum faucibus faucibus varius lacinia nunc lacinia imperdiet ipsum est orci');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (396,'Nadeo', 'tempus urna malesuada  pellentesque egestas mauris lacus morbi amet eu porttitor aliquet orci luctus sit   consequat consequat aliquet   non eu volutpat adipiscing suscipit sit mattis cursus elit risus pulvinar tortor nunc feugiat egestas vel facilisis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (397,'Namco Tales Studio', 'quam sit massa in dapibus at dapibus pellentesque cursus egestas vel  ac bibendum amet tristique id condimentum quam  non sed amet sit in semper ultricies blandit habitant nibh elit ipsum id nec odio mauris et tristique  non quam sit in ipsum non  quis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (398,'Nanobit', 'consectetur dictum elit  sit mus aliquam eget lectus vestibulum egestas cras viverra massa dapibus lacinia ipsum suspendisse quis faucibus lectus amet sit tempor vitae pharetra  amet faucibus facilisi quis tempus in fames sed leo morbi duis id massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (399,'NAPS team', 'ut faucibus  pretium at massa mattis nunc tortor erat  elit urna gravida ac  magna mauris quam convallis sapien sed vitae  scelerisque quam nam nunc in odio erat nascetur  orci quam tempor volutpat neque justo rhoncus amet vestibulum quam diam fusce');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (400,'Natsume', 'nisl eget sit purus amet commodo potenti  fusce malesuada amet  aliquam quis labore amet, nisi duis non   at augue  parturient eros tortor do amet eget integer tellus vulputate amet viverra mauris egestas non adipiscing nisl tempus ac odio faucibus nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (401,'NaturalMotion', 'vel tellus habitasse pellentesque risus sit sit volutpat in vitae a sed eu donec varius aliquam amet tortor dolor sit nunc dictum id vestibulum  sit donec  imperdiet ac nibh  scelerisque mattis duis nibh tellus consectetur in elementum enim fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (402,'Naughty Dog', 'non vel  nulla tempor dapibus adipiscing justo nisi non  sit tristique aliquet sit pretium vestibulum varius consequat proin  lectus amet donec molestie  erat enim augue bibendum amet nulla diam id commodo curabitur in netus mauris auctor pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (403,'NCSoft', 'cras ut massa  libero id montes a neque nulla vel bibendum  vitae molestie odio nec tristique  ut at fermentum  malesuada  ut amet sit hendrerit  erat vel quam ipsum   pharetra tempus erat habitant justo at non facilisis nibh ipsum tincidunt a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (404,'NDcube', 'laoreet nisl justo viverra sapien id enim nam sed condimentum urna vulputate  risus   viverra hac iaculis sit tincidunt nec augue tempor id sed integer  velit pharetra lectus in sit  nulla condimentum et in volutpat ut interdum tristique ullamcorper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (405,'NDOORS Corporation', 'fermentum libero adipiscing parturient interdum convallis nunc consectetur commodo urna   eget et at amet condimentum  sed consectetur venenatis nibh lorem  sed  id  lectus et montes  mattis gravida odio quis  eget nisl risus gravida  dolor scelerisque a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (406,'Neko Entertainment', 'nulla in viverra fusce risus erat  tristique sit nulla viverra vitae pellentesque ultrices nibh velit tellus arcu risus suscipit sit enim imperdiet sed amet volutpat mattis eu ut donec  ipsum euismod nascetur tincidunt potenti  quam mauris donec egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (407,'Nerve Software', 'platea tristique quis at elit elit viverra consectetur   porta venenatis augue  at ornare ultrices mauris turpis ut elementum risus enim morbi sapien turpis sed cursus nulla consectetur amet vulputate  egestas in volutpat diam auctor labore laoreet elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (408,'NetDevil', 'id iaculis eiusmod velit sed nisl nascetur at nisi nec elit condimentum nisi in pretium  arcu facilisis est vitae a augue quis viverra nunc elementum sit etiam nibh consequat rhoncus luctus fusce fames augue ac tortor netus urna elit  turpis tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (409,'NetDragon Websoft', 'tristique scelerisque sem bibendum malesuada tortor dis adipiscing arcu   quam in duis sem tellus arcu aliquam diam purus lectus pretium  purus sed velit fames enim purus lectus egestas sit vel ac arcu at aliquam etiam non suspendisse eget fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (410,'NetEase', 'dapibus sit et blandit id aenean egestas egestas integer tortor  purus vitae mattis adipiscing felis etiam varius et ridiculus  augue sit scelerisque   ut pellentesque dictumst sit massa ut ut tincidunt id mauris dapibus  adipiscing cursus     venenatis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (411,'NetherRealm Studios', 'viverra laoreet consectetur amet arcu nulla nibh dictum mattis mattis est nisl  nibh diam faucibus pellentesque dolore nunc  hendrerit  neque in suscipit et augue varius  eget nunc massa egestas  ipsum at  nisl in viverra fames ac pharetra eget massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (412,'Neverland', 'euismod aenean duis consectetur dui ut integer diam molestie dapibus fusce ut sed  mi a ornare elit faucibus  vitae pellentesque amet iaculis lectus non lectus suscipit sagittis arcu risus dolor semper pretium  malesuada vel dapibus faucibus sit neque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (413,'Neversoft', 'in lectus aliquam euismod risus tortor est gravida aliquam urna  sapien congue neque  cursus rhoncus id vulputate varius consequat sed molestie ut ut  dolor adipiscing fusce quisque nunc cursus  velit laoreet netus a pulvinar  adipiscing sodales');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (414,'Nevosoft', 'dolore purus nisl semper  scelerisque pretium vitae  ut  vulputate  proin nibh id id orci tellus risus hendrerit nisi tempus et aenean sit  orci adipiscing sit ipsum nibh accumsan morbi  enim tellus   ultrices viverra  sit facilisi nec lectus aliquet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (415,'New World Computing', 'ipsum  vitae magna venenatis cras facilisis justo  turpis molestie leo ipsum diam elementum a neque diam  sit tortor sed  sit consectetur sit lacus orci duis nisl adipiscing iaculis quam mi  amet faucibus varius nec  nunc commodo vestibulum  suscipit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (416,'New World Interactive', 'aenean  amet pellentesque risus aliquam  sollicitudin bibendum cras  eu  orci eu fermentum ut  lobortis aliquet sed lectus risus  vel nunc elementum risus ultrices vitae fermentum feugiat consectetur  massa mauris varius sit a varius nec etiam euismod');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (417,'Nexon', 'elementum volutpat amet nullam et consequat dolor  commodo malesuada massa ridiculus at viverra nullam consequat eget  lectus eu vitae sed rutrum integer vulputate   nisl morbi ac vestibulum pulvinar  senectus amet  odio tristique tortor ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (418,'Nexon Korea', 'mauris iaculis neque a imperdiet nisi et libero fusce tristique  condimentum pharetra arcu nascetur convallis consectetur nisl blandit  non incididunt nibh integer  congue egestas blandit  lectus velit in eu erat leo quam vitae vitae dui netus viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (419,'Next Level Games', 'sit urna viverra feugiat nisl adipiscing mauris habitasse lorem viverra quis pulvinar purus congue ac massa adipiscing  aliquet nunc enim  sit gravida ultrices malesuada  iaculis eu turpis malesuada velit sodales fermentum morbi adipiscing viverra est');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (420,'Niantic', 'faucibus leo at id  elit fusce duis tristique feugiat est urna proin et tellus nunc ipsum porttitor  cursus sed nulla  aliquam congue elementum elit viverra non etiam sit sagittis at commodo aliquam diam nisl consectetur vitae in habitant  malesuada nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (421,'Nibris', 'purus auctor commodo tempor habitant pretium lectus sed bibendum rhoncus neque vestibulum  gravida  porttitor quam sapien facilisi ut nisl risus vestibulum risus id netus nisl adipiscing ornare magna etiam et et fermentum ut pellentesque mauris amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (422,'Nicalis', 'lobortis  mi fusce porttitor et tellus tellus malesuada id morbi faucibus eu faucibus  odio orci elit mauris placerat tristique condimentum tempor quam  lobortis ultricies ut in iaculis et molestie amet et facilisis faucibus ut vulputate amet sem');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (423,'Night School Studio', 'consequat at magna aliquam hac rutrum suspendisse risus amet et et vel sit venenatis suspendisse fames  lobortis nisi cursus diam suscipit purus volutpat dolor neque tellus mattis nam   sit ipsum vitae at elit enim vel id viverra diam non feugiat ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (424,'Nihon Falcom', 'at et facilisis a pretium neque velit nisl erat risus arcu habitant eget diam sed nullam nunc  id justo tortor ac at varius tempor tristique ut orci sapien  iaculis vestibulum in eros fusce nisl elit viverra sagittis nisi cursus ipsum orci  dictum leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (425,'Nikita Online', 'tristique cursus consectetur eu eu  nunc et augue  et dignissim mattis vitae in amet   tortor volutpat morbi vitae nam amet  neque purus leo turpis aliquam  montes egestas quis arcu potenti urna sed  parturient tempus  sed tortor nunc maecenas sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (426,'Nimble Giant Entertainment', 'ridiculus tempus convallis  mauris et tristique aliquam molestie varius vitae mollis lectus fermentum tempor viverra nunc feugiat tortor nisl eleifend risus quis  odio enim vel sagittis nulla quam  porttitor sapien et purus pellentesque sed id cras ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (427,'Ninjabee', 'at integer  duis in  vitae aliquam nibh condimentum integer cursus aliquet aliquam at nascetur nam quis pellentesque sit pharetra gravida nascetur fames amet sodales  orci   elit augue amet leo donec mus ac risus nulla quam vitae accumsan vulputate');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (428,'Ninja Theory', 'at morbi facilisis aliquet viverra pulvinar  nibh hac donec ultricies ipsum fermentum at mauris   aenean a  tristique nulla sed enim et ac tristique mauris sed ut elit arcu vitae sit vulputate auctor in arcu fusce  neque adipiscing in eget in duis eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (429,'Nintendo', 'purus sed neque  volutpat mauris ut quis morbi amet, eget venenatis proin ipsum varius nisl auctor porttitor risus et augue amet  leo donec semper amet quis turpis amet eu sapien  sit fermentum tempus  sodales aliquam vitae imperdiet ornare accumsan mus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (430,'Nippon Ichi Software', 'ipsum at id risus  amet  non netus quam habitant nullam a et commodo ornare erat nam pellentesque auctor aliquet lobortis leo ut elit, urna nunc enim ultricies massa    aliquet lacus semper tortor donec sed velit urna venenatis mauris tortor  pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (431,'Nival', 'pulvinar eu aliquam auctor erat nulla condimentum sodales nibh eu amet id nisl lectus eu purus  adipiscing habitant aliquam non sit  vitae bibendum incididunt porttitor at orci diam tellus nisl eget cursus sed fusce enim odio neque sit fermentum nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (432,'Nordeus', 'ut et dictumst adipiscing ridiculus  sit quis non urna et amet dictum sit tincidunt viverra sed   nibh eget diam  massa suspendisse  a pellentesque  at  diam pulvinar aliqua  ullamcorper nunc sed non pretium vel  vel placerat  molestie amet  quam tempor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (433,'NovaLogic', 'volutpat nibh luctus augue dui vestibulum sem ultrices aliquet aliquet donec lorem risus id nisl hac ullamcorper et  amet amet quisque amet ac a sed blandit adipiscing  tempus cursus pellentesque sit et faucibus consequat nascetur rhoncus  arcu sit  amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (434,'Novarama', 'massa rutrum quam   suspendisse luctus id enim tristique aliquet purus tincidunt tristique at integer pretium dolor suscipit  velit pharetra elementum feugiat   quis non quam  sit eu scelerisque magnis mi nulla nunc viverra vitae fames netus tortor at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (435,'Now Production', 'bibendum integer et   et diam odio do facilisi nascetur rhoncus   eget quis faucibus parturient diam massa gravida  rhoncus eget nisl fames velit magna sed sollicitudin augue pharetra at sed  sit sem fames vulputate consectetur consectetur arcu cursus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (436,'Nude Maker', 'tortor  nunc  interdum  id  gravida velit justo eu  eget  ipsum massa aliquam arcu eget elit integer molestie amet semper nunc magnis fermentum feugiat pulvinar  arcu velit nisi  pellentesque nisi  viverra curabitur scelerisque habitasse pellentesque sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (437,'NuFX', 'ut urna sed id elementum tempor in  eget donec tempor feugiat  tempus fusce aliquam eu sit dictumst vehicula turpis massa ipsum eiusmod in in at massa sit eget faucibus eget  in  maecenas tempus egestas sit massa in proin augue mattis ultrices fames sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (438,'n-Space', 'sed in dolor vestibulum  urna ultrices consectetur ac at vitae  elementum vulputate sem enim in sed lectus ultricies in ornare morbi ultricies  morbi ac purus et morbi nunc amet,  enim interdum adipiscing eu pretium morbi nibh vulputate ut amet vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (439,'Obsidian Entertainment', 'dictum tellus tortor sagittis in at pellentesque  urna sit sagittis aliquet dapibus dictumst sed tristique a mus mauris integer orci ut sit ac vel rutrum purus non massa felis mattis nulla sed mauris est et vitae tellus  odio  enim mauris suspendisse');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (440,'Oddworld Inhabitants', 'vestibulum ut et amet sed sed ipsum nisl faucibus diam sodales ac non sit curabitur viverra   venenatis sit aliquet pretium ipsum consectetur nunc arcu interdum imperdiet tempus ut  nulla tincidunt  amet purus nunc iaculis scelerisque sapien ipsum neque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (441,'Omega Force', 'nunc morbi cursus orci elit mauris ornare in netus donec ipsum ut vitae lacus dignissim mattis tellus sed sagittis nec feugiat vitae tempor tempus neque cras leo odio leo sit  neque aliquam amet at quam non aliquam pellentesque vitae donec vestibulum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (442,'Origin Systems', 'pellentesque id eu vivamus  pulvinar aliquet tempus sit eget hendrerit dictum lacus neque  vitae hac ultricies nam faucibus amet etiam eget  egestas et egestas sapien et dui a sit nulla arcu  cras vel non turpis potenti nunc sit quam dignissim vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (443,'OtherSide Entertainment', 'amet ac consectetur nisl  ullamcorper etiam bibendum venenatis  duis laoreet leo nec   quam consequat aliquam bibendum eu viverra do non montes sit et purus feugiat mattis risus ac sem mattis augue viverra ipsum et morbi sit lacinia senectus nec in massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (444,'Outfit7', 'ac scelerisque  mauris quam suscipit phasellus amet eget  nisi ipsum hac donec  ac sit volutpat  id facilisi lacinia consequat nibh nam ut orci tempor porta aliquet dolor sed tellus sed tempus iaculis nibh eget sed tempor morbi parturient lacus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (445,'Outrage Entertainment', 'ornare urna turpis tristique leo  nibh mattis tortor lectus aenean rhoncus  ut ut euismod vitae tellus amet nunc pulvinar fusce  potenti ipsum mauris varius diam nulla amet nibh augue pretium   nam egestas ultrices duis  ultrices nisi sollicitudin vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (446,'Out of the Park Developments', 'ut velit velit viverra lorem lectus amet purus quam eget integer eros magna malesuada tincidunt elementum dolor nisl euismod pharetra pulvinar mauris urna  id interdum  morbi sit aenean  neque non dapibus faucibus sit massa ornare   non  donec ipsum at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (447,'Overkill Software', 'dictum vel sed eu  tincidunt euismod sed at massa gravida faucibus viverra ut ultricies quis neque dui netus adipiscing hac sit a eget faucibus sit venenatis malesuada neque sed sed leo malesuada  fermentum egestas orci consectetur nisl tempus et semper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (448,'Oxygen Studios', 'sit elit non vel  risus et ut nulla consectetur pellentesque et malesuada nunc iaculis senectus faucibus leo quam vulputate quam et id  varius id integer et ultricies ornare  nulla viverra leo sit sed nec aliquet et elementum vehicula sed facilisis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (449,'Page 44 Studios', 'hac elit non et quis at elementum sit pellentesque tellus ipsum sit nascetur labore enim lorem lectus tempor non tempor et   donec aliquam sagittis faucibus  pulvinar vulputate volutpat elementum nibh sit morbi tempus cursus nam a porta velit convallis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (450,'Pangea Software', 'ut mi tristique mattis  at ridiculus diam amet mauris fusce donec tempor tristique  sollicitudin gravida elit,  sit tortor etiam mattis pellentesque id massa at scelerisque at malesuada sed lacinia  pellentesque augue neque faucibus erat pellentesque ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (451,'Paradigm Entertainment', 'vestibulum vitae non  mauris ultricies bibendum  ac ut diam duis et  consequat aliquam tortor erat amet  cursus vitae suspendisse nunc pulvinar   consectetur  interdum aliquam viverra lorem orci sapien vestibulum  laoreet  tellus semper congue feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (452,'People Can Fly', 'ornare ultricies  nisi mauris facilisi consectetur diam at et faucibus purus velit  leo enim rhoncus at odio eget sit mi auctor adipiscing amet nec velit ut  porttitor sit nisl volutpat vulputate  non  consectetur sit tellus nec fermentum non cursus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (453,'Planetarium', 'scelerisque diam tortor erat  tellus tincidunt urna id massa laoreet suspendisse tempor purus euismod  in aliquet etiam  morbi nibh  congue nulla do dapibus consectetur suspendisse risus hac  sit commodo non elementum et  diam netus lacus porta nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (454,'Project Sora', 'nibh interdum eget ut cursus praesent montes ipsum  purus porttitor placerat a malesuada et dui nibh in pulvinar nec  consectetur mattis faucibus at ut amet, quisque eget non auctor ornare neque feugiat iaculis id elit pretium nulla   ut venenatis  quam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (455,'Purple Lamp Studios', 'sed mattis consectetur massa magna lobortis in diam odio sit nulla urna elementum venenatis incididunt iaculis amet massa quis   eu cursus tristique consectetur pretium nam sed elit ornare vel sed ornare  varius sit venenatis habitasse  blandit malesuada');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (456,'Papaya Studio', 'enim pharetra  viverra et sit  in rutrum hendrerit arcu elit, nibh vitae volutpat et non tempor nulla diam suspendisse enim molestie  viverra scelerisque orci tellus purus dui tortor at enim mus nam  ultrices fames  eget amet tempor quis et massa lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (457,'Project Soul', 'imperdiet morbi in interdum  risus sit suspendisse congue magna iaculis fermentum sed orci sit justo tincidunt egestas congue volutpat nam sapien pulvinar arcu fusce neque facilisi sed  tortor adipiscing eget et urna tempus tempor luctus lectus duis id a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (458,'Panther Games Pty Ltd', 'volutpat  ut  scelerisque vel et quis nullam condimentum ipsum amet nibh libero eu proin quis venenatis  iaculis enim   ut nunc a nibh orci   tortor ut fermentum nulla imperdiet sagittis dapibus sit donec lorem tortor consequat   viverra nisl  erat in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (459,'Paradox Development Studio', 'purus quam tellus egestas ornare   viverra tortor nec potenti lobortis arcu faucibus condimentum  duis nunc nec massa elit quam  et adipiscing sed dapibus amet ac tempor nibh  mauris  gravida varius at ultricies mauris faucibus  parturient eget  sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (460,'Parallax Software', 'neque  id fermentum laoreet quisque sit ut  consectetur vitae malesuada lacinia est a suscipit dictum urna  aenean pellentesque dolor adipiscing mi morbi elementum sit non est  a praesent varius  fusce nisl commodo eget molestie interdum morbi et  et eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (461,'Pandemic Studios', 'elementum vitae in scelerisque leo viverra est vestibulum eu vel  morbi cursus neque pellentesque mi  massa tellus  at dis varius aliquet non morbi sit sollicitudin laoreet euismod mi urna sem nisl nec  lectus  luctus pellentesque magna cras tincidunt');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (462,'Pendulo Studios', 'nisi enim justo arcu eget duis vitae sed augue erat habitasse purus sapien tellus commodo sed mi  amet nunc diam facilisis vitae hac egestas non sem  tincidunt placerat eu nibh sagittis sit vel laoreet dignissim massa nunc suspendisse neque ultricies non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (463,'Penguin Software', 'at sit hac pellentesque risus dolor vitae faucibus sit quis pellentesque sed urna sit scelerisque egestas in porttitor lobortis consectetur vulputate morbi dictum elit, nec amet mi augue urna eget  duis nisl interdum purus ipsum amet urna mus duis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (464,'Perfect World', 'in accumsan id molestie  convallis sit gravida sollicitudin viverra  vitae lectus sit accumsan augue  eget  in  pulvinar montes mus condimentum sagittis amet tempor et enim nibh ultricies tempus sagittis aliquam neque pellentesque ultrices aliquet eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (465,'Petroglyph', 'aliquam amet velit facilisis in tortor augue   morbi  quis nisl amet aliquam velit massa tellus proin mattis ac porttitor vel sed consectetur euismod mi tortor nulla arcu  viverra consequat  venenatis adipiscing erat amet cursus ut nibh elementum lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (466,'Phantagram', 'sit  rutrum quis urna duis viverra massa feugiat  cursus sed dapibus diam suspendisse vehicula proin purus dapibus cursus  elit   dolor  morbi amet tortor a incididunt pulvinar hendrerit viverra est commodo amet justo imperdiet id amet  nulla mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (467,'Pipeworks Studios', 'proin erat facilisis cras congue sit  congue pellentesque odio ultricies sed elit, suscipit sit id eu  montes at diam at sed libero  semper lectus id aliquet libero curabitur tincidunt faucibus in sit lobortis laoreet lacus  adipiscing in augue vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (468,'Piranha Bytes', 'venenatis mauris viverra pulvinar gravida  et massa amet sed tristique   amet faucibus ornare etiam  sit  aliquam nulla aliquam quis aliquam aliquam non in ut et tortor sit pharetra non augue porttitor est iaculis at  vulputate eu quam sed urna sed et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (469,'Piranha Games', 'arcu maecenas pretium ultricies amet tincidunt tincidunt elementum bibendum eu id in cursus adipiscing pretium dictum imperdiet convallis facilisis at congue sit curabitur proin sit eiusmod lacus neque mauris ut integer id sit fermentum   parturient');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (470,'Pi Studios', 'pulvinar integer velit  amet  ornare diam quam   sagittis aliquam nullam id pretium amet dui tempor mauris neque amet vitae non  pretium  est viverra eget ut  velit eget quis tempus quisque egestas purus sed  in justo   nunc urna curabitur imperdiet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (471,'Pivotal Games', 'massa quisque fermentum lectus eget odio ipsum et  mauris non amet proin velit urna facilisis eget tempor ut tempus et suspendisse iaculis feugiat sit diam non vivamus  lacinia nibh duis urna elementum risus et ultrices  adipiscing  odio massa nullam ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (472,'Pixel Federation', 'nullam in non  varius aliquam mattis nulla tellus lectus nibh tempor arcu mattis turpis ullamcorper eget habitasse dolor et tristique senectus consectetur  tempor faucibus mauris pharetra sit rhoncus in aliquet arcu  urna fusce senectus nulla viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (473,'Playdom', 'velit arcu donec diam nec mi vel arcu mauris  vel semper a ut gravida ut in a elit   vestibulum habitasse et eget egestas tortor arcu duis integer sollicitudin non quis facilisis sit id consequat egestas in cursus etiam  nibh imperdiet ornare ut amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (474,'Playfish', 'libero vitae augue in   sagittis ac pretium at massa mi enim ut non  cursus augue aliquam  nunc proin aliquam sit semper nascetur netus nam pharetra at semper nibh quam dapibus eget elit nec cras nulla id id condimentum orci viverra sed nulla amet auctor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (475,'PlayFirst', 'mauris purus cursus   scelerisque enim nibh adipiscing et velit sed et  non dis viverra dolor et cras amet congue porttitor orci  volutpat vitae dignissim bibendum pharetra lectus aliquam ultricies odio enim dapibus hac turpis et eu tortor tortor mattis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (476,'Playground Games', 'vitae adipiscing non quis ultricies et  massa  gravida  orci  libero platea a semper  arcu nascetur sit malesuada  porttitor sit semper montes lobortis risus  enim nam integer dictum quisque  nisl lorem  ut tortor vulputate sapien fermentum ipsum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (477,'PlatinumGames', 'consectetur urna congue tincidunt donec eu tempor blandit neque  diam malesuada congue suspendisse ut turpis mi vitae eget do a feugiat cursus vitae ut quis id iaculis malesuada sit massa cursus ultricies erat lorem  diam purus   vitae facilisi   eu leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (478,'Polyphony Digital', 'aenean adipiscing aliquet vulputate  elit  morbi diam facilisi  morbi et fermentum ut duis sed dolor nibh interdum proin  eu egestas tortor purus ut risus mattis at vel sem porttitor pellentesque sit sit lacinia  tortor fermentum non tincidunt at et orci');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (479,'PopCap Games', 'viverra lacus vulputate amet viverra netus libero ac fusce tincidunt ultrices integer tortor malesuada sit rhoncus nam commodo aliquam erat blandit sed lectus sed lacinia ultrices  vitae id pretium et consequat sed ornare ut velit vitae nunc pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (480,'PopTop Software', 'tellus fames sem morbi sit consectetur neque sed nunc sed eros  non condimentum arcu lectus  nulla mauris magna mattis velit fermentum vel sed elementum condimentum vestibulum quis aliqua parturient malesuada integer urna consectetur nisl duis tempus  a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (481,'Press Play', 'massa  feugiat amet amet nisi tristique in risus et amet ut   imperdiet faucibus id mus aliquam dis potenti dolore magna ut tincidunt  tempor neque iaculis duis orci eu faucibus scelerisque purus venenatis laoreet eiusmod  quisque tincidunt  blandit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (482,'Psyonix', 'eleifend adipiscing condimentum adipiscing nulla praesent adipiscing  in massa id pretium  urna et dapibus lacus diam lectus tellus mollis scelerisque eros et  tristique ipsum nunc varius amet eu faucibus ipsum morbi incididunt pharetra vulputate');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (483,'PUBG Studios', 'gravida  malesuada  nullam sed cras arcu tempor quam tortor morbi diam massa lectus posuere in nullam aenean non  odio feugiat tempor sollicitudin quam dictum augue mauris tincidunt sit amet sed  nec rhoncus egestas massa   diam volutpat tellus sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (484,'Punch Entertainment', 'pellentesque amet ac maecenas pellentesque gravida et urna ridiculus quis convallis ut amet purus pharetra vitae  pellentesque sed  ipsum faucibus a sagittis nunc  tortor vitae  potenti mi vel tellus tempor arcu ultricies adipiscing eget arcu  vestibulum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (485,'Pyro Mobile', 'lorem duis eget fusce interdum sed pellentesque mauris at pharetra id  neque sit cursus nibh et  sem sed tempus adipiscing cursus ultrices pharetra tristique incididunt auctor ac lacinia in ut vel quis tincidunt laoreet molestie congue id  viverra vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (486,'Q Entertainment', 'ultrices habitasse molestie pellentesque ac  ut malesuada et ornare tellus aliquet nec risus velit  nunc consequat nibh lobortis augue sit pretium ornare purus lectus lorem non vitae imperdiet tempus nibh et sit adipiscing semper consectetur sit mi at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (487,'Q-Games', 'augue hac placerat morbi sit et ut pharetra sagittis risus   dolor cursus massa etiam odio vitae eu quam vulputate quis in in mauris molestie est a sit erat mauris et nulla imperdiet  urna amet  ultrices sit purus sollicitudin in mauris lobortis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (488,'Quantic Dream', 'purus ultrices in id mattis condimentum in feugiat tristique dui tempor ornare dolor tortor amet nulla   vel sem rhoncus potenti malesuada sed  et vel  porta eget ut nunc vehicula donec amet integer quis arcu porttitor non varius orci nisi sit at  auctor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (489,'Quest Corporation', 'consectetur ipsum mi sapien vulputate  ut pretium morbi risus varius nulla  amet massa imperdiet porttitor aenean varius vitae purus mauris ipsum in sit elementum et aliquam non nulla tortor eget tellus nunc egestas vel condimentum porta fermentum a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (490,'Radical Entertainment', 'ipsum  augue enim pretium turpis id aliquam pellentesque sed sit mattis venenatis pellentesque  mauris aliquam dolor duis quis est sed tempus duis  sollicitudin fusce amet augue suscipit pretium accumsan et pretium nullam sit donec mauris vitae quam a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (491,'Rage Games', 'a faucibus ornare massa  nisl vitae vestibulum  arcu tempus euismod amet nisl in pulvinar egestas amet lorem ut justo id nisl quam accumsan sem volutpat viverra nisl  ut egestas sit scelerisque varius ultrices commodo porttitor amet at mattis consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (492,'Rainbow Studios', 'morbi fames tincidunt malesuada vitae arcu incididunt in nam diam nunc mauris vitae sed consectetur sed donec nec cursus  non congue  aliquam orci vel at     amet suscipit orci sed ultricies amet nulla amet id faucibus quam vitae amet, ipsum eu quisque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (493,'Rare', 'tellus bibendum gravida in nisl odio neque sit duis ut rutrum risus congue a aliquam feugiat ut viverra   suspendisse rhoncus mus tortor fusce sit  aliquam non amet venenatis nascetur sed aliquam porttitor mauris vitae nunc tellus vestibulum cursus at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (494,'Raven Software', 'diam consectetur nascetur rhoncus amet consectetur  volutpat adipiscing consectetur pretium risus mauris et in in purus sit pretium aliquam sed arcu ultricies est orci enim aenean  euismod  erat tempus eu integer fermentum malesuada id amet pharetra nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (495,'Ready at Dawn', 'molestie ac donec integer porttitor scelerisque molestie vitae purus  nisl ullamcorper velit  sit fames pretium consequat massa nullam viverra nibh ac massa amet gravida fermentum pulvinar mus gravida nunc ullamcorper aliqua eget lobortis amet  non purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (496,'Red Entertainment', 'et arcu id integer orci velit iaculis integer nulla donec tempus pharetra neque ultricies libero in velit at mattis diam  sed nunc congue tempus id  consectetur bibendum quis nunc morbi nisi nullam sapien    dolor adipiscing in  duis urna sit feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (497,'Reality Pump Studios', 'arcu ultricies adipiscing rhoncus et  sem sit adipiscing dapibus orci mattis non  lacus lectus tristique amet lacus consectetur interdum sed sed  fermentum viverra a  non diam viverra at ipsum odio eget dolor mattis at sed molestie eiusmod nunc arcu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (498,'Realtime Associates', 'dapibus at integer etiam  parturient tempor arcu non sed iaculis enim ut malesuada sagittis sit vitae nunc lectus vel pulvinar mus augue pulvinar   sed integer pellentesque venenatis  malesuada proin elit ut auctor  elit at   massa vitae odio pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (499,'Realtime Worlds', 'integer sapien sed imperdiet aliquam tempus quis ullamcorper mollis duis netus et dolor condimentum  pharetra odio habitant  amet  purus aliquet ut sapien amet, cursus risus gravida duis id potenti id eu  interdum  mauris et   id scelerisque  et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (500,'Rebellion Developments', 'suscipit arcu pellentesque suspendisse hendrerit urna adipiscing turpis sit et quisque potenti   est  fusce dolor fusce pharetra nisl nunc donec   tortor vitae nisi  consequat vestibulum  pharetra nascetur ipsum donec suspendisse ipsum nulla  viverra sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (501,'Rebellion Warwick', 'adipiscing viverra sit quis tortor adipiscing gravida arcu semper neque nam diam ut purus faucibus  integer vel hac ullamcorper rhoncus  sem lectus nulla duis pharetra ut aenean vulputate viverra diam amet  nisl  mauris elementum mauris nec scelerisque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (502,'RedLynx', 'et aliquet varius lacus vitae lacus diam mauris nibh faucibus adipiscing egestas mus at tellus elementum proin  tincidunt neque amet varius laoreet amet sem  sed et amet  urna nulla purus volutpat lorem ut a suspendisse lectus vitae lectus aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (503,'Red Thread Games', 'enim condimentum vitae  nulla viverra incididunt phasellus bibendum a sit sit libero fusce bibendum scelerisque sit lorem adipiscing  eu fermentum ridiculus  urna at mattis euismod diam ultricies cursus non rhoncus neque consectetur amet eu diam viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (504,'Red Storm Entertainment', 'magna fames tristique  rhoncus quisque molestie ac semper eget quam  morbi vitae vestibulum lacinia tempor magna ornare donec interdum   ut amet lacinia lacinia phasellus auctor sit in ut pretium risus suscipit  ultricies  donec adipiscing id lorem in at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (505,'RedTribe ', 'egestas  nulla tellus etiam pulvinar  in et habitasse   est orci nulla diam in integer nisi massa eget  eget et amet turpis pulvinar nullam platea massa elit sed justo facilisi tellus in rhoncus malesuada sit elit facilisis sit consequat congue amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (506,'Reflexive Entertainment', 'risus  non dictum cras    enim elementum scelerisque in amet ultrices tempus augue accumsan vulputate donec   eget mauris in sapien accumsan id egestas nisl facilisis lectus nibh rutrum eget adipiscing enim congue nec vestibulum  nunc pretium   ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (507,'Relic Entertainment', 'sit massa dignissim amet  pulvinar vestibulum mauris elit rhoncus pretium cras pulvinar donec amet ut porta lacus aliqua amet  malesuada nunc  aliquet elit  feugiat ultrices aliquam  enim ornare interdum nisl nisl a quam vitae quisque mattis nunc ut ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (508,'Remedy Entertainment', 'pulvinar neque morbi vel ut quam mauris habitant eu sapien ultrices phasellus vitae sit eget viverra dictum fermentum sit pulvinar enim mauris nec vel a viverra eget malesuada ultricies urna sem mi aliqua at libero nisl nunc arcu mauris lectus est');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (509,'Respawn Entertainment', 'quam non lectus amet vulputate amet in consectetur   congue arcu feugiat sed  id venenatis nec amet  sit sed  diam habitasse convallis amet vitae sed sed quisque elit amet vel nascetur semper vel commodo non enim eget suspendisse a  eget risus viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (510,'Reto-Moto', 'congue orci odio ultrices nunc  vitae cursus nunc adipiscing habitant ullamcorper non duis ac euismod sed pellentesque vulputate vulputate enim ut et nam in odio justo nibh dolor elementum vitae imperdiet semper  condimentum morbi vitae pretium volutpat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (511,'Retro Studios', 'amet massa neque lectus odio duis adipiscing    lectus sagittis elit aliquet vulputate  adipiscing egestas velit  amet consectetur  pulvinar tincidunt ipsum dictum dapibus velit pretium elementum adipiscing tempor eget in sed orci eget  morbi convallis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (512,'Revolution Software', 'at lorem elit   tellus aliquam tellus incididunt malesuada pharetra  sit facilisi cras rhoncus sapien cursus enim integer ut condimentum vitae aliquam et augue elementum consequat ipsum dui mi eget diam ut faucibus montes nulla  iaculis duis commodo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (513,'Riot Games', 'amet fames  urna quis erat enim ullamcorper arcu sit vestibulum purus sed in felis tincidunt dapibus et  lectus blandit  amet sit orci et massa  nunc dolor lectus at aenean est  id id tristique commodo nisi hendrerit duis nibh dui  quam enim   pharetra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (514,'Rising Star Games', 'eleifend  faucibus purus  ultrices   sed risus erat urna aliquam tellus semper aliquam nisl tempus a est mus cursus interdum pharetra id velit blandit sed vestibulum quam  eu sit aliquet integer elit  nec porttitor ipsum vitae sit semper purus orci nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (515,'Robomodo', 'varius  consectetur sit et dictum ut orci quam  varius  ut ut ut ultrices et mattis id quis at commodo sed senectus ut sed feugiat mattis aliquam sem ullamcorper arcu at accumsan et enim gravida in ultrices feugiat tortor morbi nunc vitae vel malesuada');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (516,'Robot Entertainment', 'tellus odio porttitor vitae ultricies in nullam  amet vestibulum gravida in lectus et  euismod parturient semper aliqua in libero mus ullamcorper sapien suscipit amet facilisi nec congue non pharetra vitae vitae  nunc amet viverra donec tortor vestibulum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (517,'Rockstar Games', 'suspendisse  id magna condimentum a sodales malesuada tortor lorem erat vitae tortor iaculis tellus morbi  quis  vitae  tortor vulputate egestas bibendum orci eleifend sit mattis diam nulla pharetra tempor nibh a porta cras nulla quis elementum est sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (518,'Rockstar India', 'odio sit  non massa at in pellentesque urna cras  dolor cursus risus non tortor mauris faucibus rutrum nisl commodo neque sit erat commodo amet porttitor mauris vestibulum dui magna leo sed adipiscing  vitae tellus rhoncus non nam in quam etiam viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (519,'Rockstar Leeds', 'integer  integer vestibulum  at  magnis neque nulla nisi ornare vulputate sed  dolor lacus vulputate ipsum molestie massa lobortis proin cras  odio non  curabitur malesuada  mauris neque orci faucibus potenti rutrum sit adipiscing feugiat suspendisse in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (520,'Rockstar Lincoln', 'ullamcorper  et netus facilisi elementum a  non tellus duis dui nisl sit sed lectus elit purus  mauris nunc   non malesuada facilisis gravida interdum nec aliquet adipiscing risus tempor et malesuada tellus velit nulla  faucibus enim   varius');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (521,'Rockstar London', 'augue neque  mauris vitae tempor quam  dapibus eget eu congue et nisl dolor at purus quisque in a egestas nunc morbi libero tempus morbi imperdiet sapien venenatis aliquet pellentesque massa suspendisse ultrices donec non ornare massa   erat nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (522,'Rockstar New England', 'nulla aliquam interdum vitae ac   lectus purus purus  tortor sapien feugiat morbi faucibus fusce urna lectus in sit  at condimentum ridiculus vulputate mattis dui fermentum massa nascetur pulvinar facilisi  et sit suscipit faucibus egestas ullamcorper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (523,'Rockstar North', 'nunc in aliquam lectus hendrerit  vel  tellus ornare suspendisse tincidunt neque condimentum non blandit nibh quis amet convallis tempor faucibus sapien nullam  consectetur sed nascetur pharetra pellentesque consectetur consectetur cursus fames vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (524,'Rockstar San Diego', 'mus sed et  faucibus pharetra erat duis nec  morbi orci sagittis duis tincidunt suspendisse et sapien elementum faucibus mus lectus lacus hac auctor in facilisis nascetur curabitur venenatis amet   convallis cursus vulputate scelerisque leo eget mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (525,'Rockstar Toronto', 'turpis potenti enim quam pellentesque netus aliquam semper sit dapibus id nisl nunc nibh  ac sapien vestibulum arcu  scelerisque facilisis id vitae ac  scelerisque quis  non  sit non id eget orci  molestie iaculis  tempor velit nec    malesuada');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (526,'Rockstar Dundee', 'malesuada  a feugiat etiam sit massa id sit pulvinar senectus enim nulla  est consequat mus vitae nulla at  tempor aenean tellus sed sit  sit  mauris nibh augue  tellus eu quis ipsum ac tortor suscipit imperdiet consectetur felis dolor urna cras   risus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (527,'Rocksteady Studios', 'ac vestibulum lobortis massa sit mauris egestas massa tellus donec lectus ornare faucibus mattis semper molestie  netus ultrices sagittis feugiat elit proin nisl pharetra nec enim sit in  augue elementum ullamcorper egestas vestibulum  odio viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (528,'Robinson Technologies', 'donec  ac fermentum imperdiet est  cursus tristique porttitor diam semper neque adipiscing molestie ac id vel a eiusmod sed non amet sit  vitae potenti risus at ac tempor eget nibh sit nec suspendisse pellentesque imperdiet ornare nisl erat et aliquet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (529,'Rovio Entertainment', 'ultrices dictum consequat feugiat id ipsum magna hendrerit volutpat eu arcu pretium quis arcu nulla tristique vitae fusce ultrices est quisque molestie ac  purus velit consequat malesuada purus turpis aliquam  nisl at lobortis tempor enim  imperdiet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (530,'Runic Games', 'in senectus porttitor at nunc tempus donec est orci vitae purus in congue sagittis sit  nunc vitae pellentesque faucibus eiusmod  ac a eget massa adipiscing labore  laoreet netus amet condimentum vitae elit  sit malesuada tellus lacus quis adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (531,'Running with Scissors', 'habitant elit quis elit est lacus quam varius massa vulputate venenatis pellentesque velit condimentum  suspendisse quis proin  sit urna tincidunt amet  nisl do eu lorem tortor lectus et gravida varius duis et ut sit semper egestas volutpat semper id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (532,'Saber Interactive', 'sed nec mattis malesuada non  mus pellentesque quis gravida sapien vitae lorem volutpat pellentesque dictum curabitur  lobortis suscipit  nisl nulla ullamcorper eu nibh  mattis proin et fames  tempus netus enim dolor quam maecenas sit quis egestas  augue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (533,'Sand Grain Studios', 'vel vel   augue aliquet etiam adipiscing tortor    facilisis scelerisque volutpat ut nisl diam aliquet  nam  malesuada ut lectus libero tempor blandit dui vel enim  suspendisse  augue turpis sed amet, sapien fermentum et morbi ridiculus  do pulvinar');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (534,'Sandlot', 'mauris quis pellentesque blandit sapien    lobortis est tristique  eget  porttitor elit risus mauris et morbi purus eu nisl vel tellus non augue in  adipiscing amet curabitur nibh dolor erat pellentesque risus et eu  quam senectus diam sagittis ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (535,'Sanzaru Games', 'at sagittis massa sit  habitant consectetur mi nisi arcu eget tempus sed egestas tincidunt pulvinar nisi adipiscing et turpis ultricies at vitae aliquet eget duis erat consectetur ultrices ut at faucibus molestie donec  vitae lectus neque quam diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (536,'Sir-Tech', 'eget scelerisque sed purus risus consectetur sit fames diam eu  risus mi ullamcorper urna dui volutpat aliquam amet at integer et   integer tortor cursus  augue orci ac nunc  lectus id ut viverra eget  ultrices nam aliqua mollis pharetra id ipsum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (537,'Schell Games', 'eget auctor non cras  pretium elit consectetur ut amet donec morbi nunc non commodo diam urna sed tempor enim gravida senectus  tristique condimentum  pulvinar varius dolore aliqua fusce potenti mauris pellentesque quis  diam vitae amet laoreet duis in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (538,'SCS Software', 'nisl aliqua suspendisse ultrices nec dolor mauris bibendum amet nunc dapibus ac id mauris cursus rutrum vel  urna sed amet varius  egestas ultrices molestie non urna ipsum congue  et a rhoncus erat fusce tellus mus sit amet tortor purus mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (539,'Sega', 'nulla etiam  morbi  eget fermentum amet suspendisse pharetra arcu pretium nulla hendrerit amet  arcu amet vitae purus condimentum commodo cras at et nisl eu dolore  amet mauris platea eu  id purus aenean eget ac  velit interdum tempor et adipiscing enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (540,'SEGA AM R&D Division 1 ', 'pellentesque fermentum lectus purus  sed imperdiet suscipit ultricies justo mus egestas   enim velit ornare eu tortor neque vitae amet arcu hac tincidunt et elementum nisi hendrerit ipsum id at odio non turpis nascetur sed amet mauris tellus ac urna sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (541,'SEGA AM R&D Division 2 ', 'sed molestie parturient dui sem quam consectetur  nunc quis eget nibh in vel tincidunt blandit purus tellus feugiat sed congue pellentesque quis ut ultrices sit lacus bibendum at nulla mus enim rhoncus sed interdum urna eget ut sed adipiscing amet massa');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (542,'Sega AM3', 'amet ultricies molestie lectus  morbi  nam felis nec at non lacus  malesuada molestie curabitur malesuada nec adipiscing sagittis sit cras molestie   iaculis mi tincidunt   non  a amet, nunc quam risus  pretium quam lobortis phasellus tellus sed justo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (543,'Sega CS Research and Development No. 2', 'quis tortor eget felis blandit amet pellentesque egestas pretium urna cras id sit   nulla donec tincidunt eiusmod id nascetur duis sit faucibus quis lectus massa ac orci nisl diam et dolore lorem lectus ultricies suscipit amet et ut   ultricies vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (544,'Sega Sports R&D', 'eros in  sapien molestie sed nibh et  aliquet  ultrices cras  et gravida diam cras vitae dolor interdum in dolor sit quam nulla sed magna accumsan amet volutpat sit vitae nec aliquet integer malesuada bibendum et non sit nulla a aliquet iaculis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (545,'Sensible Software', 'massa at nibh risus elementum gravida quis amet massa felis sapien leo in sit sed duis et vulputate donec aliqua diam ipsum augue vitae sed vitae vel  nam  diam neque mattis faucibus donec nunc nibh dictum a sed purus cras non  senectus cursus mi vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (546,'Bend Studio', 'faucibus nisl  pretium egestas faucibus cras molestie massa massa lectus fermentum aliquam lectus dui sit mauris lectus amet donec massa vulputate tempus etiam tortor ultrices  faucibus suspendisse  ac etiam nunc purus lectus auctor morbi nam quis a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (547,'San Mateo Studio', 'augue tincidunt donec amet massa sit facilisis diam arcu nibh varius tristique magna pulvinar adipiscing volutpat sed  euismod  leo consectetur  dolor felis amet nec et aenean pellentesque erat consectetur dui nunc augue feugiat et  convallis ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (548,'Japan Studio', 'turpis in gravida at tincidunt velit feugiat ultrices purus aenean nec enim et mi  euismod amet at nulla cras adipiscing tempus eu in proin tempor velit risus ultricies nibh nisl  nec aliquet nam purus adipiscing   mauris aliquam sed accumsan viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (549,'London Studio', 'non duis vulputate mauris pharetra fermentum et urna amet sed varius morbi labore adipiscing  in sed adipiscing vulputate velit nec a congue urna luctus nulla mauris vel  nisl adipiscing mus habitant ut sed vulputate nascetur odio donec  tincidunt ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (550,'San Diego Studio', 'elit cursus  ultricies a dis nec amet duis tortor laoreet vulputate nunc  netus suspendisse  in dolor tortor enim  vestibulum aliquam ac at  pharetra elit, elit faucibus at habitasse mauris risus at venenatis sagittis luctus semper odio ullamcorper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (551,'Santa Monica Studio', 'arcu enim et diam nulla tortor integer nunc libero feugiat etiam mauris mattis et donec suspendisse elementum fermentum aliquam mauris tellus morbi mi  vulputate tellus congue  nunc viverra sed praesent nec placerat ut eget dictumst amet at sed sit   mus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (552,'Studio Liverpool', 'dolor ultrices  sit vestibulum pretium mauris non sed mi ut in tincidunt at diam quis justo fermentum et convallis libero  arcu odio diam id vestibulum eget scelerisque  sit et  non tincidunt aliquam velit tempor eget condimentum eget adipiscing id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (553,'Shaba Games', 'congue risus ornare  id  tempor quam congue  at mattis fames blandit non egestas vitae viverra ultricies sit augue viverra  nulla vulputate mattis ultricies adipiscing  amet donec scelerisque ac lectus nibh  orci tempor at risus vitae ultrices sit congue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (554,'SIE Worldwide Studios', 'augue ultricies egestas vitae non  sed odio mi integer cursus  vel elit risus arcu lectus ut habitant et arcu eget feugiat eget ullamcorper odio in eget integer netus egestas ipsum orci pellentesque sed consectetur adipiscing aliquam donec nulla amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (555,'SingleTrac', 'ut rhoncus faucibus consectetur  quam adipiscing  habitasse vitae  mauris cras tristique quis posuere massa eu aliquet scelerisque nunc  quis lectus amet ipsum eget proin et tristique varius ac ornare congue aliquet rhoncus pellentesque enim etiam nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (556,'Shengqu Games', 'amet tristique aliqua varius nibh turpis convallis augue   nunc blandit neque amet a vitae molestie euismod  faucibus vulputate velit mi suspendisse elit id eu nisi mauris diam lacinia nam nisi orci sit iaculis sit amet et  sit  aliquam vulputate sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (557,'Sherman3D', 'elementum purus nam tristique proin nisl purus pulvinar risus augue ac integer parturient  ipsum varius eu amet ipsum adipiscing  volutpat congue quis non sapien molestie quam lorem eget senectus mattis ultricies auctor  non et ut nisi condimentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (558,'Shinen Multimedia', 'ultrices enim sit sed do tristique neque sit eu amet sit hac nisi mauris ipsum sed vitae fusce mauris feugiat vel  malesuada mauris eu sed elit   amet mi varius sed commodo interdum dictumst lectus amet tellus faucibus ut ultricies condimentum et aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (559,'Sierra Entertainment', 'ultricies sapien nascetur erat facilisis felis  congue pulvinar lacus potenti gravida ultricies eget amet faucibus orci varius scelerisque turpis massa amet aenean sem elit sit suscipit facilisi tempor  aliquet netus facilisis nunc amet nisl nullam netus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (560,'Silicon Knights', 'nibh et felis at   malesuada amet eu sit faucibus lacus commodo purus sed aenean aenean erat et vel velit dolore congue amet sed vulputate augue tellus  blandit amet  diam sagittis nulla faucibus lacinia nisl vel risus velit tincidunt integer nec purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (561,'Silicon Studio', 'massa rhoncus dapibus sapien at dapibus amet leo ut varius consectetur vehicula et placerat ipsum risus nunc elementum enim viverra felis quam  in varius adipiscing magna sed nulla risus  at consectetur lacus maecenas nisl ac  vitae  quis mauris ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (562,'Simtex', 'pharetra condimentum eget morbi mauris  semper  amet suspendisse fames vulputate massa enim nec senectus vitae lectus velit viverra et amet tortor tristique purus feugiat sagittis velit aliquam tempor mauris euismod ipsum nibh sit et semper ridiculus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (563,'skip Ltd.', 'amet sit duis aliquet amet  a egestas  senectus cursus ac sed aliquam aliquam nibh volutpat iaculis  sit  quam  tellus ut  varius rhoncus urna augue in ut nibh lacus sapien ut quis nulla vitae non sit fusce enim odio convallis dictum molestie  laoreet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (564,'Slant Six Games', 'in viverra ornare iaculis ut consectetur enim nascetur lorem risus varius posuere do aliquet porttitor sit dictum ut aliquet amet in ac  vulputate gravida vitae lectus sed massa sapien lacinia augue arcu odio egestas varius pharetra vitae mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (565,'Sledgehammer Games', 'nec   vulputate ipsum molestie integer urna sit nibh lacinia purus  neque ut in ut  id interdum  id augue elementum risus ut proin risus ultrices vulputate vestibulum neque accumsan in lectus tempus consectetur nunc nunc urna  integer nisi risus  morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (566,'Snail', 'scelerisque consequat viverra  pharetra     potenti semper gravida quis nulla  mattis viverra    netus lacinia lectus ultrices  amet id fermentum nunc sed adipiscing nunc id facilisi quisque nibh urna et amet nullam molestie leo tristique in id arcu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (567,'Snapshot Games', 'magna porta et nulla  elementum et condimentum id dictum tempus  odio  eu consectetur id accumsan adipiscing  et id donec  augue  tortor mauris ultricies id eget lectus  non vulputate egestas nam amet  turpis tempus auctor sed risus   eu vel eget eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (568,'Slightly Mad Studios', 'dapibus feugiat amet orci faucibus sed magna blandit at  nulla neque risus et scelerisque senectus accumsan amet adipiscing id tincidunt lectus etiam neque integer sapien adipiscing tempor aliquam gravida massa id nunc in id sed eget nisi massa consequat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (569,'Slipgate Ironworks', 'aliquam amet felis  semper placerat proin etiam vitae  fusce ullamcorper massa lectus tellus vel imperdiet ut pretium ut sed  egestas auctor condimentum amet  malesuada lacus faucibus ultrices id  massa  ut viverra vitae quis  semper feugiat amet tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (570,'Slitherine Software', 'est etiam nec consectetur dictum sem leo  nibh velit enim in imperdiet auctor  dapibus morbi tincidunt egestas commodo tortor commodo mauris tellus non mollis   suspendisse sit at imperdiet non est fusce purus id  in ullamcorper fermentum eget massa  sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (571,'Smilegate', 'sit feugiat fermentum bibendum vestibulum donec et scelerisque ornare duis tellus nisl massa  tellus aliquam  proin viverra duis in in molestie vitae quam placerat ullamcorper risus suscipit faucibus  egestas  mattis egestas malesuada orci facilisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (572,'SNK', 'nec et  volutpat congue lectus elit velit  ipsum  lectus et consectetur morbi  lobortis ut cras aenean enim non odio erat quam ut congue pretium ut sed  tellus  in in molestie sit a sit porta tristique massa consectetur dolor at  diam convallis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (573,'Sobee Studios', 'pharetra habitant risus    mauris ullamcorper nulla mattis viverra odio amet tempus nec nibh ornare nec turpis ultricies lorem feugiat pellentesque  id mi massa ut pellentesque interdum risus nibh ut laoreet augue nisl amet ultrices vel enim amet amet,');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (574,'Snowblind Studios', 'habitasse vel magna risus tellus  vivamus at viverra ipsum etiam tortor in feugiat sed  ac mattis montes arcu auctor vitae quis ornare elit sed amet nulla  orci adipiscing pulvinar maecenas varius quis aliqua hendrerit cursus est enim feugiat suspendisse');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (575,'Software 2000', 'nam tristique urna nibh venenatis consectetur molestie dictum purus proin arcu varius  tortor adipiscing turpis elit  eget consequat libero pellentesque gravida vitae vel semper  mollis ultricies purus elementum habitasse quam enim placerat pretium vel');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (576,'Sony Interactive Entertainment', 'dapibus sit blandit sem fusce egestas neque feugiat pretium nibh auctor nisl cursus viverra et pharetra massa vitae vulputate  feugiat suspendisse volutpat duis neque eget dapibus ipsum urna  risus fusce viverra nunc faucibus odio  nascetur vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (577,'Sora Ltd.', 'faucibus pellentesque mattis  purus at consequat aliquet  neque amet viverra sit amet sit in et aliquet eu et quis suspendisse viverra  quisque egestas urna  dictum  donec egestas lectus scelerisque fermentum dictum sed lectus posuere   quam egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (578,'Spellbound Entertainment', 'egestas consectetur iaculis nunc mi tempor morbi ut ultrices volutpat lacus orci neque viverra nunc lorem sit  ultricies  interdum eget ridiculus interdum pellentesque hendrerit lobortis eget malesuada viverra sed commodo interdum ipsum nec dictum at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (579,'Spiders', 'suspendisse  lacus in lectus sed massa dolore diam  lorem volutpat ultrices faucibus proin non morbi in diam volutpat imperdiet vitae   ut pretium potenti dui enim mauris nibh ridiculus dictum duis et eu risus quisque purus orci et sapien  augue diam a');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (580,'Spike', 'mattis massa bibendum porttitor ut sollicitudin tempor adipiscing quis eget vitae at id varius  potenti id tellus sed tempus interdum neque senectus nulla  quam condimentum sit consectetur  vitae etiam tortor sed cursus sit suspendisse erat quisque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (581,'Spike Chunsoft', 'hendrerit nec nam nec  aenean rhoncus dis et non pulvinar   ipsum   augue sed purus cursus sed eget sed diam nascetur mi vehicula sit orci luctus nec  tortor faucibus mauris euismod vulputate gravida in potenti gravida aliquam lacus cursus et arcu ipsum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (582,'Spil Games', 'tempor at id condimentum suspendisse gravida  proin morbi in massa tempor tortor convallis praesent quam suspendisse pretium sit cursus neque faucibus non et adipiscing libero mauris cursus  commodo quis ullamcorper volutpat eu  gravida varius  nulla sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (583,'Splash Damage', 'eget et urna dolor consectetur nisi ut vulputate id  quis amet ullamcorper pretium elementum nam neque sit urna  non suspendisse  nunc cras volutpat urna odio eget mi  turpis sit faucibus  adipiscing non  ipsum at at fermentum curabitur  ultricies diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (584,'Sports Interactive', 'ipsum sed turpis venenatis nec consectetur morbi  iaculis congue  eget pulvinar condimentum hendrerit tortor risus vel quisque fermentum  consequat arcu in at malesuada dui vel sed bibendum tristique ut a nisi ut vitae sit magna dapibus  lorem ornare');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (585,'Sproing Interactive Media', 'purus et viverra non velit neque porta diam elit ipsum suscipit arcu at imperdiet sed etiam  suscipit tempor amet vestibulum sit commodo morbi ut ut elementum nunc parturient augue amet  viverra  cursus eget tristique nisl blandit scelerisque odio sapien');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (586,'Square Enix', 'sagittis purus ornare et tristique et dictum quam lectus augue  consequat  mauris dictum quis et nec risus habitant justo mauris feugiat   quisque  cras odio molestie aliquam in neque nulla orci quam consectetur cursus  aliquam elit eget netus gravida at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (587,'Squad', 'diam et duis condimentum  risus aliquam tortor risus  augue placerat pellentesque suscipit   risus   enim in vulputate morbi amet vitae fames mattis adipiscing pharetra quam et tellus nibh egestas  faucibus sed ipsum sit tristique sit elit risus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (588,'Stainless Games', 'eget  venenatis tellus  nulla consectetur id nulla elit fusce vulputate dui suscipit ut volutpat sed mattis    pellentesque massa scelerisque enim et id mauris dignissim sed sem senectus enim enim massa adipiscing id et orci  congue  eget fusce  aenean');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (589,'Stainless Steel Studios', 'volutpat ac pretium malesuada cursus enim nunc duis tempus sit tempus nec cras tellus tellus scelerisque dolor  donec nec  cursus non purus gravida turpis lacus nascetur  elementum mauris senectus etiam tempor parturient  ultrices eu  augue mauris lorem');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (590,'Starbreeze Studios', 'diam lectus varius maecenas tempor  sit lectus  nec donec nam tellus ornare quam elementum non pharetra amet, in etiam vitae tristique fermentum  nunc  dolore turpis curabitur enim parturient eget blandit viverra non nulla velit neque  diam vel dictum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (591,'Stardock', 'a tellus massa condimentum enim molestie pharetra proin quis hendrerit potenti  amet ipsum ipsum neque egestas vivamus nisl ut tellus suspendisse vulputate integer volutpat sed   in amet at nec  vitae arcu amet felis netus nunc tortor mauris  ut sit odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (592,'Sting Entertainment', 'tortor at cursus phasellus sed et nascetur dapibus massa montes facilisis nulla aliquam mattis  et faucibus quam eget  mus pellentesque convallis  in volutpat tortor cursus amet vulputate vitae porttitor libero habitant sit donec bibendum sed viverra id');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (593,'Strategic Simulations', 'viverra donec quis placerat a  eleifend ultricies id consectetur  pulvinar  sit bibendum lorem est mauris at nullam egestas  egestas nulla diam vestibulum nulla et  et ullamcorper consectetur molestie adipiscing faucibus amet mauris massa ornare et nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (594,'Stoic Studio', 'ut   ac nunc vulputate et tristique  nec eget diam enim ridiculus amet  mauris morbi etiam augue vulputate ultrices  consectetur id suspendisse urna consequat ultricies aenean nisl  condimentum vulputate integer ullamcorper non consequat in magnis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (595,'Strawdog Studios', 'scelerisque netus facilisis suspendisse facilisis scelerisque massa sed et interdum risus tempor tincidunt nisi tempus in malesuada arcu ut vitae  mus ultricies sit nibh nulla laoreet sed et  diam tellus at  velit id eu quis integer fusce vel in nisi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (596,'Straylight Studios', 'et sed odio suspendisse quis at labore sapien quis  magna faucibus iaculis risus vulputate nunc erat netus volutpat gravida    et sit dolor sed sapien scelerisque pellentesque tristique elit, ut eros velit lectus  ipsum commodo eget ac etiam mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (597,'Streamline Studios', 'quis interdum laoreet arcu mauris tristique auctor ipsum mauris tortor duis feugiat duis  vehicula facilisi tristique sit nulla dolor  et urna velit  amet enim sit dui ut condimentum elit, mauris ipsum amet nascetur id ipsum etiam  aliquam interdum sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (598,'Success', 'ut viverra  faucibus  duis at sed at dictum amet ut viverra quis pellentesque sed hac  volutpat a ullamcorper non fusce quis tortor habitasse amet   a eu neque urna massa  eros consectetur nisi et tellus tortor condimentum sit augue enim dignissim elit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (599,'Sucker Punch Productions', 'diam nullam  arcu aliquet rhoncus amet viverra diam et amet mauris nam vitae fusce elit porta nisi sit eu tincidunt vestibulum sed ipsum  rutrum in elit,  dolor at  enim quam amet aliquet hendrerit sit non interdum  vulputate urna quisque facilisis at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (600,'Sumo Digital', 'ac augue aliquet in   viverra aliquet  porta consequat ac at feugiat neque  at faucibus  eiusmod  senectus pretium nulla  ridiculus risus amet at donec dolor bibendum volutpat gravida nec amet tortor dolor orci suscipit hendrerit quam vitae purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (601,'Supercell', 'elit in vel nulla quis  quam tristique egestas turpis vitae ut varius ultrices facilisis ut  aliquet  amet elementum ullamcorper  quam arcu pharetra duis massa sed porttitor aliquam venenatis suscipit massa  augue fusce iaculis lorem mauris cursus arcu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (602,'Supermassive Games', 'mus fermentum tincidunt  condimentum faucibus  vulputate lectus  ornare leo fusce diam sit sed  eros sem habitasse justo volutpat risus gravida  aliquam eu viverra  pharetra laoreet urna aenean suspendisse facilisi tempus sit molestie  eu morbi  proin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (603,'Supergiant Games', 'morbi lorem  eget  pellentesque elit bibendum leo viverra integer eget adipiscing mattis adipiscing eu mus risus  quam  eget et sed at  massa sollicitudin turpis sed adipiscing  donec arcu diam vitae lectus gravida lacinia suspendisse  mauris amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (604,'SuperVillain Studios', 'habitant faucibus et etiam orci aliquet malesuada ut mattis phasellus  mauris integer semper adipiscing  eget dolor et netus diam tempus est urna  pellentesque rhoncus lobortis  velit non eu potenti tempor eget  suscipit a neque pulvinar ut  mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (605,'Survios', 'lacus nunc tortor nisl imperdiet gravida vestibulum urna vel purus diam viverra sit nulla nec etiam massa eiusmod tempor consectetur  justo volutpat laoreet porttitor netus  magna suspendisse viverra ac sed tempor sit mauris mattis nisl volutpat et donec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (606,'Studio Wildcard', 'est lorem in pretium aliquam et vel urna  in ultricies in consequat non fermentum  eu eu diam quisque nec feugiat diam amet ultricies a quis amet eros turpis odio elementum mattis id velit sagittis ac vestibulum neque nibh duis mi ipsum nibh leo proin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (607,'Swordfish Studios', 'nisi dolor vitae gravida eu nibh dapibus nisi sed imperdiet nibh risus rhoncus eget lobortis  aliquet habitant  nisl ipsum dui porttitor  sed rutrum at enim augue nibh urna donec iaculis amet cursus ullamcorper cursus ullamcorper congue sapien  magna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (608,'Swingin Ape Studios', 'at porttitor suscipit tempor bibendum aliquet et ornare at aliquet purus  velit molestie  integer feugiat augue dolor fermentum nibh risus lobortis cursus sit potenti ornare vel amet adipiscing et tristique in donec urna velit enim  velit netus rhoncus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (609,'StormRegion', 'aliquet tempor  in vitae diam cras vulputate amet consectetur odio elit ultrices in fames vestibulum condimentum lorem elit senectus mattis congue sit velit suspendisse varius tristique condimentum in ornare lacus viverra facilisis sit pulvinar turpis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (610,'Sunstorm Interactive', 'amet, ultricies posuere vestibulum nulla faucibus sollicitudin molestie est fusce  sed justo diam nisi adipiscing urna leo tempus elit sit facilisis elementum pellentesque sodales tincidunt aliquet amet ridiculus iaculis lectus habitant venenatis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (611,'Syn Sophia', 'suscipit a et commodo purus a ultricies dapibus adipiscing morbi ipsum nec aenean integer imperdiet risus mattis aliquet potenti bibendum diam  nisi porttitor sit varius et tellus facilisi nulla risus amet non mattis ornare sed tempor amet imperdiet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (612,'SystemSoft Beta', 'fusce integer iaculis tempus sit aliquam tortor  at nibh elit condimentum feugiat morbi  lectus diam enim potenti egestas elit et amet volutpat suspendisse a  dolor suspendisse lorem id mauris pharetra tempus magnis congue arcu tortor  dapibus nullam eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (613,'Taito', 'a duis suspendisse pulvinar eget dapibus elit,  libero  ac nunc eu cursus ridiculus pretium  amet faucibus mauris eget venenatis sit montes netus  rhoncus sit lectus nunc ut euismod aliquam urna tincidunt vitae   ut platea bibendum gravida ultricies   ac');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (614,'Tango Gameworks', 'malesuada nisl mattis  neque sed vel urna vestibulum amet senectus pellentesque mauris morbi viverra quis vulputate tincidunt aliquet ornare ornare pellentesque iaculis massa orci pretium pellentesque hendrerit tempus elit aenean sit orci suscipit mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (615,'Tag Games', 'ipsum  amet egestas eu in magna cursus interdum quam   velit  nisi ultrices donec nisl pulvinar erat ut egestas sem lobortis orci velit mi pellentesque aliquet ut rhoncus ullamcorper suspendisse gravida in enim nunc hac nisl enim magna ac  euismod');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (616,'TaleWorlds Entertainment', 'nisi purus nam cursus bibendum  enim sagittis facilisi et sit pellentesque congue pellentesque mauris vitae nec nec consectetur  at lectus ultricies aliquet in pellentesque congue cursus sapien mauris  vulputate  adipiscing morbi at  mauris faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (617,'Tamsoft', 'consectetur amet massa duis iaculis lacinia nascetur nunc nec  leo cras at et risus ipsum enim accumsan mauris fames dis tincidunt pulvinar enim ultrices massa cursus integer at faucibus eu eu ultrices tincidunt odio  sed gravida ipsum hac eget cursus et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (618,'T&E Soft', 'sed adipiscing in tellus id diam massa  interdum egestas  risus lacus malesuada  odio tempor nisl elit iaculis ultricies imperdiet libero lectus nulla ipsum diam quis nibh enim  eleifend sagittis venenatis et velit  consectetur mauris nec lectus  mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (619,'Tantrumedia', 'habitant nunc elementum vitae congue vitae nisi vitae est iaculis porttitor nunc nulla elit euismod ultrices faucibus quam in arcu placerat justo augue tincidunt leo lectus accumsan eget enim diam ut in mauris velit et non blandit mauris eget ipsum non');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (620,'Tantalus Media', 'nam aliquam ut interdum orci sit gravida nisl diam odio nibh sit varius in orci accumsan amet ut  dapibus suspendisse ut ultrices aliquam eiusmod ipsum volutpat ultricies faucibus netus  nisi nullam at parturient imperdiet   felis ac tortor integer purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (621,'Tarsier Studios', 'parturient  morbi do nisi erat   tempor sapien sit mattis lacus suscipit rhoncus dictum senectus laoreet mauris  urna at fermentum dictum   pharetra mauris  quam sed viverra eget enim semper vitae at urna  ut eget eget purus sapien tellus morbi iaculis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (622,'Tate Multimedia', 'ut orci pulvinar velit quis pretium sit suscipit  odio morbi pretium vulputate  nulla nisl felis tempus lectus sit in augue proin non sed malesuada pulvinar urna egestas donec eget pretium gravida nulla adipiscing gravida urna fusce  massa fusce aliquet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (623,'Team17', 'quam nibh mattis cursus consectetur dapibus  purus massa neque odio arcu nec sagittis pulvinar  id et mattis  a ut  et  erat faucibus massa  in nisl  leo sagittis est faucibus congue sit feugiat purus adipiscing gravida bibendum est volutpat gravida');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (624,'Team Bondi', 'iaculis condimentum diam quisque  eget tempus  do malesuada velit risus  ut  odio fames massa in et nisl tempor sed et mi dui est proin platea mattis nunc suspendisse sagittis eget mauris  in egestas vestibulum purus ac bibendum imperdiet  varius tempus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (625,'Team Ico', 'nunc  nibh sapien nec blandit parturient ut odio nunc enim elit ultrices ultricies consectetur purus nunc orci tortor sodales egestas at semper eget laoreet potenti leo in nullam suscipit semper eu ac   vulputate viverra nisl tincidunt  felis sagittis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (626,'Team Ninja', 'vitae purus tortor curabitur nunc malesuada faucibus elementum in tristique adipiscing velit mauris enim morbi condimentum magna mollis dictum vel imperdiet nunc  turpis sed scelerisque ultricies purus erat suspendisse faucibus lacus sed adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (627,'Techland', 'id nunc ut sit orci erat venenatis sed  ut risus vulputate integer sit  nulla amet amet hac et nulla amet id et et ac tempor facilisi eu sit suspendisse  mattis  in diam aliquam massa tellus at pulvinar est ipsum egestas condimentum urna   tincidunt');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (628,'Tecmo', 'vivamus massa imperdiet gravida aliquam et elementum venenatis massa cursus labore ornare lectus    viverra in duis molestie interdum sem dictum vitae molestie faucibus aenean tempor  feugiat eu tortor dapibus purus ultrices tellus cras aliquet imperdiet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (629,'Telltale Games', 'pretium interdum  montes pellentesque gravida nunc et tellus tempus rhoncus lobortis  urna sed  integer vel amet   purus orci adipiscing fusce augue dui sed donec curabitur sed vestibulum  sit suspendisse vitae nam  turpis lectus enim nullam sapien ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (630,'Tencent', 'senectus euismod vitae in sed id cras ac accumsan tincidunt aenean odio varius congue mauris suspendisse adipiscing  ut egestas proin ut sit tristique gravida semper   nec pellentesque dictum sodales ultrices amet molestie semper sit  vulputate bibendum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (631,'Tencent Games', 'integer eget eget  blandit massa magnis nunc risus turpis feugiat ornare pulvinar  ridiculus suspendisse neque bibendum vitae arcu in bibendum eget urna consectetur sem habitasse facilisi semper massa pretium diam massa   non ipsum gravida tortor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (632,'Tequila Works', 'facilisi lectus mus odio lectus nibh mattis amet aliquam purus quis nunc at  integer id  tellus etiam tincidunt neque enim quis adipiscing dui non sed elementum at rutrum lobortis nisi risus  labore molestie pretium mi incididunt   vitae in mollis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (633,'Terminal Reality', 'amet  vulputate consequat consequat feugiat ac mi est euismod dictum varius vitae nisi elementum adipiscing sed aliquam nibh et  duis laoreet accumsan consectetur venenatis nam tristique orci et purus nunc ipsum ultricies egestas cras scelerisque lacinia');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (634,'Tetris Online', 'senectus ut aliquet mattis scelerisque mattis sit sed arcu   consequat eget cursus cursus sed velit tortor dapibus viverra adipiscing viverra varius nec tempus ultrices elementum sagittis  vitae egestas volutpat ipsum arcu pellentesque in turpis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (635,'Teyon', 'lectus hendrerit  scelerisque consectetur  condimentum ornare congue neque donec rhoncus amet  non  dui nisl dictum eu eu quis nascetur  viverra ipsum aliquet  in mattis lectus massa  ipsum vulputate sed varius sit leo non  sed consequat tortor  pretium');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (636,'Thatgamecompany', 'gravida feugiat facilisis tortor  egestas suscipit nam sit mattis lacinia facilisis nunc  aliquet lorem aliquam luctus molestie tellus  ac elit mattis diam fermentum purus aliqua turpis elit  velit pulvinar lectus mattis nulla tristique erat consectetur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (637,'The Chinese Room', 'aliquet gravida  egestas diam nulla urna nisl eget   nulla neque non vulputate sed sit amet viverra non varius morbi elit  interdum bibendum ultrices amet  lacus et quam a dictum tristique enim enim  tellus non purus varius erat enim purus molestie');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (638,'The Coalition', 'amet pharetra fermentum erat arcu adipiscing in malesuada integer neque vulputate at blandit aliquam consectetur odio et vitae varius sed vitae fermentum hendrerit interdum tincidunt consequat nibh  eget nunc tempus montes morbi sollicitudin egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (639,'The Farm 51', 'pretium at donec  duis vitae  nec potenti duis enim urna sit nisl vel risus nec mi vitae aliquam convallis pharetra netus tristique nulla vel   id vitae mattis aliquet duis integer habitant eget blandit varius dolor   donec in semper  curabitur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (640,'The Initiative', 'sit do arcu  sed  lobortis elit, hendrerit feugiat  arcu hac molestie nisl id quis dapibus eu vitae adipiscing  pellentesque gravida pellentesque in dignissim imperdiet turpis mattis facilisi  felis porttitor vitae leo ultricies fermentum amet feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (641,'THQ', 'ullamcorper non mauris nibh nulla tellus in lacinia lectus quis ultricies elit fermentum in mollis lectus lacus sit urna suspendisse amet malesuada massa a varius in risus nec mattis elit at consequat non id sed convallis adipiscing massa  nec ut at nibh');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (642,'THQ Nordic', 'bibendum nascetur   facilisis nunc duis amet sagittis elit diam  diam bibendum lorem tortor hac non nisi ornare malesuada urna at at  quam libero  condimentum a vel et nam lectus augue accumsan  sed  venenatis massa quis  arcu donec nisi diam eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (643,'Three Fields Entertainment', 'sed dictum purus cursus sed venenatis ultrices porta odio urna aliquet scelerisque ut sit lectus sed aenean iaculis eget adipiscing augue placerat pellentesque tincidunt lorem fames mauris viverra nec augue  amet, vulputate commodo urna arcu feugiat');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (644,'Three Rings Design', 'quam dictum neque neque  augue elit amet  vitae diam  ut pellentesque senectus in  curabitur a quisque sed magna mauris senectus risus vitae imperdiet feugiat elit mauris consectetur vitae  ornare et tempus vitae viverra  erat  sagittis nunc massa nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (645,'TimeGate Studios', 'adipiscing pretium magna arcu tempus et aliquam   ipsum mauris orci orci consectetur fermentum nunc vel in integer sagittis amet nullam quam morbi aenean massa placerat gravida tortor urna quisque cras tellus nec egestas pretium id  vitae lectus dictum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (646,'TiMi Studios', 'tellus pretium hac pellentesque nam tempus   vitae nibh pharetra  lectus donec vitae vel orci netus suscipit lacus ut massa condimentum tempor   hendrerit nam massa erat odio sed feugiat mollis dictum ut massa at netus  ipsum elit vel adipiscing semper');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (647,'Toaplan', 'purus fusce id a dolor pharetra praesent ut neque diam nulla suspendisse  faucibus  lacus nulla ultrices velit tincidunt viverra condimentum tincidunt quisque ultrices  in  sed parturient lobortis elementum sapien  at adipiscing vulputate ipsum cras urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (648,'ToeJam & Earl Productions', 'lobortis nibh facilisi facilisi parturient mi   velit mauris fusce sed nisi viverra elementum enim semper faucibus in lacus quis libero orci semper amet varius diam enim imperdiet a mattis netus elementum potenti nunc lectus gravida  tellus eget');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (649,'Tokyo RPG Factory', 'ultrices vulputate feugiat   aliquet at adipiscing  dapibus id donec aliquam potenti ut magna nisl id donec nascetur sagittis consectetur habitant semper malesuada eu ultrices vitae id eiusmod ut a vitae  risus  faucibus orci et cras placerat  proin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (650,'TopWare Interactive', 'ornare sit nec  nibh nibh  mattis a tristique augue elit do sapien elit adipiscing enim tortor malesuada consectetur nunc est ut morbi etiam a quis vulputate imperdiet orci vel massa velit morbi gravida ut ultrices scelerisque hac consectetur orci cursus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (651,'Torpex Games', 'a amet,  laoreet  nec lorem ultrices at ultrices lorem quis nisi viverra leo in nullam feugiat montes lectus blandit in quis varius erat rhoncus  viverra nulla at ultrices donec et aliqua nulla sit tristique nisl eu tempus sit gravida nunc morbi');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (652,'Torus Games', 'iaculis elit pellentesque sed pretium tortor nunc id mattis risus neque in  dui volutpat  etiam vitae  in interdum lobortis mauris a aliquet consectetur massa condimentum  eget odio in orci ipsum cras purus non arcu nibh ut ultrices tempus mollis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (653,'Tose', 'tempus elementum adipiscing  viverra  at morbi etiam quis vel  eu fusce nulla morbi nunc urna urna est fermentum mattis eu nec et vitae nisl magna ipsum imperdiet integer velit duis potenti semper faucibus quam  quisque et dui non  condimentum ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (654,'Toys for Bob', 'ullamcorper arcu sapien consectetur neque dictum et malesuada  mauris enim adipiscing nunc arcu ornare nisi donec at   at pharetra et varius interdum  amet massa facilisi nisi condimentum nibh  semper nec vel malesuada cursus vestibulum egestas  enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (655,'Trapdoor', 'nec nunc gravida urna rhoncus adipiscing  mattis lacus nibh bibendum  accumsan tortor purus sit turpis  integer  non arcu ut  sit cursus suscipit elit gravida et risus malesuada est fames a  hendrerit in nunc consectetur velit erat arcu tellus felis nam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (656,'Transmission Games', 'sed id odio vivamus ut auctor  netus quis lacus senectus pretium eu fames sed nec quam at in quam diam non amet dictum sed enim facilisis consectetur senectus velit neque  in aenean sagittis potenti  in  tempor tellus leo  odio  urna mauris laoreet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (657,'Travellers Tales', 'faucibus  mattis aenean interdum nullam tempor egestas   nibh senectus   leo tellus a diam lectus habitant cras justo urna erat aliquam sapien sed euismod non mi viverra gravida ornare facilisis  curabitur nulla vitae adipiscing quam euismod condimentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (658,'Treyarch', 'purus blandit nunc  massa   fermentum   et ultricies  nisl faucibus porta cursus vulputate morbi   consectetur elit sagittis  quisque vitae dictum et  fermentum malesuada velit cursus vestibulum urna  ridiculus amet enim adipiscing amet semper adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (659,'Treasure', 'mollis porttitor eget gravida tempus libero lacus id volutpat adipiscing blandit tellus quam sit aliquet tempor est in pharetra nam parturient nec tristique enim pulvinar  potenti  mus dolor ridiculus  aliquam proin mattis pharetra mattis a et ut');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (660,'tri-Ace', 'augue facilisis sit consequat cursus velit ultrices ullamcorper  tempor vitae arcu congue aliquet amet condimentum vitae euismod consectetur in netus aliquam risus montes id sapien duis augue pretium et adipiscing suspendisse  eget massa  pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (661,'tri-Crescendo', 'urna tempor quam nibh tristique lectus cursus porttitor  molestie tellus ut vel nibh integer fermentum non a pretium turpis volutpat adipiscing tempus varius urna diam consectetur sit pretium augue   sagittis semper donec sapien nulla in vulputate odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (662,'Trion Worlds', 'donec risus sit cursus fermentum non sed proin eget massa nisl amet libero  gravida fusce eleifend pulvinar leo blandit nulla adipiscing rhoncus at in facilisis magnis sit nec purus at at sagittis ornare nullam proin sed malesuada sit  in mattis laoreet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (663,'Tripwire Interactive', 'senectus orci tellus  amet nascetur purus rhoncus ut  dui scelerisque nunc consectetur molestie pretium aliquam amet at lacinia odio  id dictum viverra eget varius aliquam imperdiet  sed viverra   porttitor amet pharetra potenti mauris cursus habitant');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (664,'Triumph Studios', 'ac sagittis est  lectus nec bibendum id ridiculus nibh id gravida id quis proin adipiscing ut pellentesque diam  ac arcu risus eleifend diam potenti non justo  eget cursus eget gravida elit consequat  mi tempus aenean diam in  diam diam eget iaculis odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (665,'Turn 10 Studios', 'orci egestas  amet massa tristique viverra  et quam duis elit vulputate amet enim consectetur luctus augue tristique porta  elit morbi faucibus semper ipsum nec quisque ipsum vitae lectus  condimentum at in vehicula nascetur  interdum dapibus imperdiet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (666,'Turtle Rock Studios', 'sit a pretium tortor id  ornare tristique netus lectus morbi vestibulum aliquet vitae augue ipsum  nisi pretium ipsum   dapibus dapibus sed amet fusce sit potenti  morbi sit donec dignissim  ullamcorper elit quam nunc hendrerit vestibulum eu vitae netus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (667,'Two Point Studios', 'mattis elit ac    sit mi tincidunt et sit convallis enim vitae ipsum malesuada amet nunc amet facilisi enim eget vestibulum libero  eiusmod erat  consectetur id suspendisse feugiat et elementum vulputate sed  viverra arcu imperdiet sit turpis at mollis');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (668,'Two Tribes', 'molestie mattis senectus consequat  amet,   vitae iaculis facilisis augue pharetra condimentum libero mauris purus tempor sed leo quam tristique mus  vestibulum at commodo viverra feugiat elit  est tellus  libero turpis id  netus nunc habitant purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (669,'Typhoon Games', 'augue massa  nunc ullamcorper sagittis donec ultrices dapibus et vel quam ac ipsum in  lacinia mus amet a orci proin amet mattis amet  lectus fusce  sit amet ac varius hendrerit lectus tortor nisl ipsum habitasse sed vestibulum risus pharetra ut lectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (670,'Ubisoft', 'parturient  venenatis nulla nam  feugiat  ut est purus dolor quis non tristique etiam tortor nec imperdiet molestie ullamcorper pellentesque tortor in aliquam habitasse aliquet pretium  at  ut  in ultrices molestie donec mi  ac et nunc donec  adipiscing');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (671,'Ubisoft Blue Byte', 'sed elementum in   elit id eu magna mattis non nulla id nec proin amet lorem nulla purus pretium turpis diam mollis massa vestibulum urna sed mi aliquet ac auctor placerat eu integer dapibus vestibulum  diam consectetur suspendisse at aliquet tellus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (672,'Ubisoft Leamington', 'quis eu eget velit tempor sem et mollis eget ut consectetur massa sed scelerisque amet   scelerisque et lectus commodo incididunt sollicitudin ac sit sed  amet tortor non sit sed odio et velit aenean auctor venenatis nunc netus neque etiam sit tristique');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (673,'Ubisoft Reflections', 'cursus dui purus pharetra  convallis auctor arcu ut diam  tortor  mollis eiusmod aliquam donec  malesuada nisl a donec urna ut amet urna tempor consectetur mauris sed consectetur ut ipsum neque lectus interdum nibh aenean  consequat nec ac vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (674,'UEP Systems', 'velit ut  netus  mus consequat elit  consectetur lectus odio tortor nunc  dictum leo sollicitudin labore arcu luctus ornare in semper at aenean faucibus sagittis adipiscing consectetur viverra tincidunt vitae mi aliquet in   id iaculis varius curabitur');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (675,'Ultimate Play the Game', 'diam diam in quam  ultrices nisi lacinia viverra vivamus mauris viverra amet eget neque quis  ullamcorper  vestibulum iaculis nisi urna blandit enim viverra tempus eleifend aliquet cursus   tempus morbi et  ut molestie adipiscing  urna sit  ultrices');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (676,'Undead Labs', 'nec tortor ullamcorper velit at nunc sagittis viverra nam imperdiet lorem  porttitor incididunt neque adipiscing condimentum consectetur cursus  purus hendrerit ac cursus  suspendisse sit nunc semper quis tristique urna ultricies non sit pretium est');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (677,'Underground Development', 'feugiat amet amet vitae  ut nunc amet in nulla lorem mauris vitae at morbi  eget sed nisl mattis   nunc vel morbi pretium et ut habitasse at orci at fames nibh  diam leo ultricies eu at  amet varius pellentesque facilisis gravida vitae nam elementum  eu');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (678,'United Front Games', 'vulputate eu in quisque sed neque fermentum  sed at sed porttitor amet pulvinar sed quis vel laoreet congue blandit tristique euismod dapibus at iaculis nisi dolor sit  feugiat commodo pretium ac  elit amet malesuada in lorem  nec diam tellus egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (679,'United Game Artists', 'eu   lorem ridiculus sed interdum non parturient viverra  tellus at  dis cursus donec massa et iaculis cursus vitae purus adipiscing habitasse  non odio velit bibendum ut viverra   nulla ut consequat amet quis id varius arcu vulputate ornare felis  sed');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (680,'Universomo', 'pulvinar pretium diam augue semper neque arcu aliquet blandit amet  hendrerit risus lectus ac ultrices ut rutrum malesuada mattis pretium enim sem massa sed donec pellentesque adipiscing interdum  odio   turpis at sit accumsan tellus nibh pretium lacus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (681,'Unknown Worlds Entertainment', 'eget  velit vitae non congue quisque  et nulla fermentum tempus purus quis sit  vitae urna potenti egestas  dolor nam  imperdiet eu nullam vel quis   amet  pharetra sem  viverra  diam at consectetur senectus leo sapien ipsum id neque eget in  vitae');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (682,'Valhalla Game Studios', 'pretium netus malesuada adipiscing molestie nam pellentesque tortor diam donec eu ac tristique ullamcorper tellus facilisi venenatis pellentesque  tristique pharetra  orci nisi velit at elit cras elementum  erat velit imperdiet pellentesque blandit nisl');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (683,'Valve', 'elit tempus  malesuada feugiat vitae mauris tortor malesuada ac morbi  sed et tempus et diam augue odio viverra quis risus ultricies urna porttitor mauris odio    id adipiscing blandit mauris pellentesque maecenas in amet egestas nec  mi neque dolore');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (684,'Vanillaware', 'volutpat tempus ac libero leo ridiculus pretium quis donec ut nunc  dui urna dictum tincidunt eget congue lorem tempus diam elementum non mauris augue nunc ipsum  quam tempor  erat eu viverra nisi turpis blandit vulputate ultrices ipsum luctus  dictum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (685,'Vanpool', 'sit ipsum mattis non non duis  tellus sed et justo aliquam facilisis   fermentum duis ridiculus viverra convallis adipiscing in consequat  ultrices fusce ut  dictumst lacus condimentum ut venenatis sollicitudin iaculis morbi amet ipsum tortor vitae in');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (686,'Venan Entertainment', 'urna adipiscing  pretium ac condimentum lacus interdum diam mi quam tempus odio parturient congue lorem nisl imperdiet adipiscing magna mauris amet amet scelerisque ullamcorper  tellus a sed eget ultrices vitae duis suspendisse habitant  morbi faucibus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (687,'Vicarious Visions', 'nisl tellus proin auctor iaculis arcu ultrices sagittis laoreet eu rhoncus mi id mi nibh volutpat tortor diam dui a  porta blandit mattis pharetra lectus  malesuada sed ipsum pellentesque nascetur aliquam donec tincidunt nisl  consequat rhoncus amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (688,'Vigil Games', 'nam ac pharetra nulla  sapien et lacinia   habitasse in ipsum adipiscing id adipiscing fames at  tincidunt suspendisse et sapien laoreet mattis proin gravida adipiscing  faucibus mauris turpis sagittis  nulla ac eu ut urna ut aenean elit et a maecenas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (689,'Virtual Heroes', 'sed quam sed augue et cursus suspendisse varius velit sed aliquam gravida nibh nunc ridiculus diam iaculis bibendum habitasse pretium tortor urna  sapien sit risus molestie tristique labore consectetur consequat vitae  ut lorem id malesuada nulla egestas');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (690,'Virtuos', 'sem  habitasse pretium nascetur vivamus suspendisse et aliquam mauris dapibus at donec nullam dolor mi pellentesque nec a mattis pulvinar ut velit porta ornare  nisi eu suscipit non non suspendisse at dui pharetra tincidunt  cursus risus id sed et aenean');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (691,'Visceral Games', 'malesuada varius pellentesque in amet curabitur lectus orci tincidunt nunc  habitant ipsum elit velit elit eget nec quam purus nulla feugiat purus   aenean velit do consectetur sed  amet ut vitae adipiscing sed eget sit  ut sed aenean sed vitae sit  leo');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (692,'Visual Concepts', 'amet augue nulla eget  non at facilisi elementum aliqua in aliquet  urna mi  lacinia ultricies et feugiat  neque porttitor etiam vulputate lectus  ultricies fermentum libero tellus semper cursus  malesuada  facilisis suspendisse leo amet  in fermentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (693,'Vostok Games', 'odio urna cursus in sit fusce nunc mi elit massa id amet ultrices convallis donec  tellus sit enim in eget cursus   et potenti malesuada ipsum  adipiscing  tortor augue eget  interdum ut scelerisque nascetur   neque lectus mus gravida tortor magna diam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (694,'VoxelStorm', 'mus mattis cursus nisl molestie quisque arcu sodales  et aliquet nisl elit pretium nec elit vel ipsum elementum sit tellus sem  erat  risus at aliquam vitae viverra vestibulum ut non pharetra tempus faucibus dolore dolor  semper consectetur id  sed nunc');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (695,'Wahoo Studios', 'eget tortor lacus faucibus   morbi congue arcu fermentum sed odio in orci  turpis massa et tempor turpis viverra in   erat non dictum potenti vitae iaculis scelerisque auctor pharetra enim ut molestie non vulputate vitae malesuada morbi mi purus mauris');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (696,'Warhorse Studios', 'elit diam at aliquam at  fusce netus scelerisque pharetra ridiculus  nec habitasse pellentesque  egestas amet nulla nam vivamus consequat a ornare vulputate viverra blandit quis diam id elit facilisi diam hendrerit augue purus dui amet montes nulla');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (697,'Wargaming', 'purus purus consequat vel mattis nibh quis eu dolor magna nec aliquam diam arcu sagittis ultricies aliquam a nibh nisl molestie dapibus lacus amet  neque tortor consequat elementum varius lectus mauris vel   ut sem auctor adipiscing  nunc quam vitae  at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (698,'Wargaming Saint Petersburg', 'erat vitae condimentum odio pretium quam  ornare neque in vitae odio volutpat lacus et pellentesque condimentum iaculis sit proin eu convallis  sit amet et magna maecenas  tincidunt amet enim lectus pellentesque lectus dictum risus  vel  tempus purus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (699,'Wargaming Seattle', 'convallis a  nullam ut platea pellentesque malesuada vel  ultricies vitae id  sed tristique sed fermentum integer morbi sit magna adipiscing massa in consequat sapien et quam cursus mi nunc ultricies  condimentum proin amet auctor pellentesque aliquam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (700,'Warner Bros. Interactive Entertainment', 'vestibulum diam  tellus vitae etiam id  mi massa mi morbi imperdiet fames morbi placerat pharetra integer mauris  faucibus tortor amet lacinia adipiscing dis ipsum mattis nulla at suspendisse tellus sed cursus lectus   lorem consequat sit amet proin quam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (701,'WB Games Boston', 'ut dui dictum etiam mi lectus aenean donec  mattis turpis varius suspendisse volutpat tempor amet varius  non purus est adipiscing egestas sed quisque neque erat purus luctus sit vitae nascetur semper molestie sit commodo tellus iaculis tellus nec');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (702,'WB Games - Avalanche ', 'quisque netus odio in  non quam diam arcu a lacus et amet morbi aliquam tincidunt lacus hendrerit ultricies duis at ultrices mauris rutrum sit aliquet  tincidunt pretium imperdiet imperdiet aliqua dapibus  vitae a euismod  sit integer massa libero');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (703,'Webfoot Technologies', 'platea ut malesuada et  dapibus diam nec quis  suspendisse vel bibendum fermentum lectus erat arcu pulvinar imperdiet  leo elementum pharetra amet  suspendisse  nulla venenatis elit risus vestibulum  morbi et consequat risus nam donec suspendisse sit');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (704,'WeMade', 'eros id pellentesque massa arcu aliquet id eu condimentum varius orci luctus  egestas pretium  eleifend consectetur et ultrices vel eget at  et quam  in sit lectus facilisi amet sed feugiat   lectus senectus semper massa  cursus ultrices pellentesque');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (705,'Westone Bit Entertainment', 'augue ut  senectus libero duis eu nunc velit enim eget nullam condimentum pulvinar velit congue feugiat vehicula elit fusce sed magna mi amet vestibulum nunc elit urna massa donec lacinia purus lorem tempus fermentum imperdiet lacus in nulla lacus enim');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (706,'Westwood Studios', 'montes nibh nisl amet condimentum bibendum ut   lobortis massa duis suscipit  vulputate laoreet velit cursus neque sit montes venenatis adipiscing  egestas  sit purus pretium mollis nunc malesuada varius mauris et nulla nunc ipsum diam aliquet at');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (707,'Wideload Games', 'consectetur dictum consequat   rhoncus aliquam ac diam est massa et  vel felis augue pellentesque non at vulputate  consectetur amet  laoreet vestibulum tortor in porttitor sed purus vitae morbi consectetur amet iaculis mauris hendrerit porttitor amet');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (708,'Wildfire Studios', 'blandit arcu duis  et laoreet sed sem amet adipiscing gravida amet sed non  consequat eget viverra elit aenean sed gravida nulla potenti iaculis sed molestie mauris odio ornare purus lacinia velit et tempus purus morbi mauris imperdiet viverra aliquam et');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (709,'Wizet studio', 'gravida non porta quisque sit viverra quam aliquet  praesent quis erat  lectus libero facilisis  nam at tincidunt lorem ut tellus nibh purus aliquet eu ac libero fusce id pretium  tincidunt tortor massa  proin mattis mauris massa at vitae viverra viverra');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (710,'Wolfire Games', 'netus congue velit at leo lectus elementum risus non nisl mattis elit mattis ipsum sed curabitur erat diam morbi aenean fermentum duis  nulla et arcu tincidunt gravida nullam nisl massa senectus arcu erat vulputate rhoncus mattis vitae sollicitudin');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (711,'World Forge', 'laoreet eget nisl habitant orci massa dui vel mi consequat rhoncus sed tortor adipiscing id aliquet  at aliquam nunc  integer magna nisi ut egestas convallis nunc donec purus dis neque diam viverra ac justo aliquet viverra nulla nec  condimentum');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (712,'Xbox Game Studios', 'amet feugiat mauris aenean sed dictum duis sed  in dolor condimentum adipiscing urna et amet, lectus auctor   semper ipsum elementum    ac fermentum turpis cursus arcu  in  sit luctus duis  ut in et ac sit hendrerit orci tristique velit gravida tortor');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (713,'XPEC Entertainment', 'nisi diam maecenas consequat mattis neque orci integer aliquam non nisi nibh dolore feugiat quisque massa posuere gravida  faucibus sagittis   aliquet  tortor amet varius enim gravida adipiscing  iaculis id quam sed volutpat risus ornare interdum urna');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (714,'Yager Development', 'urna mi risus massa eu fermentum integer in cursus lectus suscipit   eget  ultrices morbi enim semper fames  est lectus  tortor at quis sit dolor aliquam ultricies at dictumst elit arcu  et nec commodo aenean nam varius nec egestas pellentesque senectus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (715,'Yukes', 'pretium erat in netus velit  ultrices mauris feugiat vitae nisl varius mi est pretium adipiscing faucibus nisl vulputate iaculis ornare risus ac eu nunc amet tempor nec arcu leo turpis sapien non facilisis ultrices  sed nisl dictum in  facilisi etiam');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (716,'ZeniMax Online Studios', 'non velit pharetra vitae arcu nec  tellus sem vel sit risus lectus adipiscing id integer mi molestie   eu  sed eleifend vel est eget amet cursus ut vitae varius sed  non ipsum ultrices fermentum id suscipit vel in   sit vestibulum sit nibh pretium cursus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (717,'Zen Studios', 'viverra id tempus cursus iaculis  dictum a  diam pellentesque habitasse bibendum  lacus sit amet ullamcorper ultricies amet id pharetra integer dolor urna rhoncus semper senectus velit adipiscing do platea magna  eu vestibulum faucibus malesuada   odio');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (718,'Zipper Interactive', 'leo ac mattis vel sit  nulla et amet accumsan  id malesuada commodo enim nec vel mattis condimentum tellus viverra  facilisi nunc at mauris vitae ultricies viverra vitae in  a fusce pulvinar rhoncus sit amet quisque a neque lacus integer consequat augue');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (719,'Zombie Studios', 'donec tincidunt cursus iaculis  nisl ipsum elit semper nec blandit mollis luctus nam libero et quis  faucibus  quam integer facilisi nec  nisl egestas senectus et interdum egestas amet elit augue purus morbi cursus orci erat sit senectus  vivamus varius');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (720,'ZootFly', 'eget  congue  molestie nam massa scelerisque nibh facilisis in diam egestas enim odio massa  vitae laoreet  sem ut suscipit integer  sed vestibulum convallis pulvinar euismod in cursus et donec lectus enim  massa cursus varius   aliquet ultricies tellus');
INSERT INTO desenvolvedor (ds_id, ds_nome, ds_descricao)
            VALUES (721,'Zynga', 'nec fames mollis arcu  fames sit vulputate pharetra viverra odio ipsum quis odio platea tellus consequat mi orci arcu ornare ultricies hac sagittis laoreet enim iaculis tempor dolore  ultricies aliquet cursus et urna vel viverra enim nunc adipiscing');
INSERT INTO fornecedor (f_id, f_nome, f_especialidade)
            VALUES (1,'AWS', 'blandit netus ultrices');
INSERT INTO fornecedor (f_id, f_nome, f_especialidade)
            VALUES (2,'Azure', 'at fermentum eget');
INSERT INTO fornecedor (f_id, f_nome, f_especialidade)
            VALUES (3,'Google Cloud', 'tortor potenti enim');
INSERT INTO fornecedor (f_id, f_nome, f_especialidade)
            VALUES (4,'Alibaba Cloud', 'rhoncus ultrices  risus');
INSERT INTO fornecedor (f_id, f_nome, f_especialidade)
            VALUES (5,'IBM', 'quisque feugiat diam');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (1,'odio eleifend iaculis','aliquet vitae at  vitae nec et sed tincidunt urna egestas semper  aliquam ornare  condimentum   luctus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (2,'laoreet nunc quam','quam in mauris sit ac netus neque et arcu etiam mauris enim  sagittis sem fermentum parturient tortor');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (3,'mattis arcu vel et','nulla nisl habitant consequat est ipsum turpis  amet arcu eget sem quam neque vulputate sed ornare in');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (4,'sit quis augue aenean','duis mauris nulla integer hac vitae a magna donec odio ut  etiam velit donec iaculis nunc vitae euismod');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (5,'at sit sit non  vel','viverra duis risus tempor  tempus aliquam viverra cras   urna ut tempor sed ut malesuada nisi  neque dictum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (6,'et tincidunt tortor et','ac placerat euismod  nec ultricies pretium at  quam faucibus donec non gravida condimentum quis facilisis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (7,'lectus amet viverra','congue nunc ac elementum et quis  quam hac vulputate enim rhoncus tortor ultricies consequat nulla at sit');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (8,'ut diam nunc augue','sed ut nisl facilisis at euismod ipsum pretium tellus  pellentesque vulputate aliquet pharetra nisi sit id');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (9,'feugiat dui risus','risus adipiscing quam fermentum neque tempus  ridiculus nunc gravida ut nisl nec sed integer non et nisi');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (10,'dictum vulputate sed','urna  diam eget sagittis magna purus pellentesque tellus sit mauris consequat et  semper tempor id tellus at');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (11,'euismod malesuada enim','non et amet hendrerit interdum  nisl nisi semper est vitae consectetur urna tempor nunc dui egestas iaculis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (12,'mattis ut vulputate','amet  dictum diam   amet  ultrices consectetur consectetur nec egestas nec sed nunc vulputate eu  eget');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (13,'adipiscing   sit','consequat habitasse scelerisque  quam nec condimentum nec fames adipiscing pulvinar sed  viverra nulla  sit');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (14,'ipsum lacus aliquet','adipiscing maecenas mi tellus  orci cursus ornare id enim id  pellentesque  tempor  ut iaculis vulputate');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (15,'bibendum integer  vel','vitae ut nam condimentum netus dolor urna sit nibh elit non  nulla aliquet sit sed  faucibus malesuada');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (16,'nullam  risus dolor','hac odio sit lectus arcu condimentum ut pharetra  iaculis lectus at nunc varius lacus quam  fermentum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (17,'risus tincidunt quam ut','ut viverra quis sed mauris diam facilisis vehicula  tellus at libero facilisi  a nulla velit vulputate  sit');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (18,'ut odio lacus','amet iaculis  purus porttitor orci arcu orci sed at  elementum facilisis nulla in nunc  dui integer in cras');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (19,'donec nisl egestas','ornare et sit nibh lorem mauris scelerisque arcu urna  viverra nisl  tempus fermentum convallis ut  sed');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (20,'vulputate ipsum  erat','amet gravida ultrices varius semper scelerisque  ut viverra velit tempus mauris etiam ac tortor gravida');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (21,'gravida integer varius','pharetra amet diam risus ipsum diam lacinia ac id mi lorem massa faucibus eget interdum a faucibus purus at');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (22,'consectetur ornare eget','amet viverra malesuada tincidunt tempus  non in sit dapibus libero porttitor molestie sed aliquam vitae');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (23,'diam risus  dui egestas','feugiat massa justo sed   semper id bibendum sit nisl vulputate mauris cursus volutpat dolore sapien');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (24,'sit   elementum','quam risus integer consequat tristique eu sit purus quam sit amet id mollis venenatis tellus scelerisque');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (25,'adipiscing nisi urna','purus euismod ut iaculis ut nascetur amet  id ac nunc sed auctor tempor vel pellentesque tempus integer');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (26,'sit  eget sapien  in','id sed bibendum viverra amet sit sit amet cursus risus bibendum  ut luctus tellus aliquam venenatis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (27,'mus interdum','nulla amet dolor erat integer condimentum aliquam lectus vulputate felis ac vel  dolore enim euismod elit,');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (28,'fermentum aliquam','vitae ultrices cras sapien nec  sit convallis ac nullam magna semper  dolor nunc ipsum sit risus blandit');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (29,'vestibulum elit','aliquam  libero mattis nam morbi magna orci dolor mi  tempor diam sed ipsum massa consectetur blandit a eget');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (30,'hendrerit euismod amet','tempus venenatis  tellus magna nibh sed sed lectus viverra consectetur quisque bibendum  euismod lacinia');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (31,'amet sed  leo habitant','nibh vitae euismod augue  consectetur amet rutrum  montes risus aliquam  ac morbi elementum dui vulputate');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (32,'vitae egestas  amet','ornare lectus sit vestibulum sit in non  turpis ullamcorper id enim egestas congue duis leo vestibulum nisl');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (33,'quis dapibus   eu elit,','ultricies amet semper sit odio  etiam aliquam ut volutpat ut dolore pellentesque augue amet, sed nibh est');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (34,'eu dolore   id leo leo','quis nulla mauris lacus elementum  a semper a sit eu nunc mollis amet facilisis nulla sed nibh elementum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (35,'a sagittis molestie','tincidunt neque tincidunt donec pellentesque aliquet iaculis nam ut  in eu varius proin pharetra augue amet');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (36,'non massa amet odio','vulputate non vitae id  dolore ridiculus adipiscing  ultricies id nec ut laoreet  consectetur faucibus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (37,'faucibus varius sem','condimentum ut ultrices nulla eget nunc sit ac ut justo nam hendrerit pellentesque tempus  neque luctus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (38,'aliquam faucibus tempus','urna ut orci proin euismod nulla vitae id et aliquam mattis adipiscing condimentum lacus sed aliquet ipsum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (39,'amet odio  maecenas','fusce adipiscing   eget  nunc euismod egestas diam bibendum augue ut amet  ridiculus et egestas nulla');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (40,'condimentum in tempor','feugiat nulla mauris nullam non in odio duis nisl etiam nullam  eu  condimentum vitae adipiscing malesuada');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (41,'augue etiam lectus','lectus cursus duis scelerisque eu cras odio orci eiusmod  enim massa leo interdum eget id sollicitudin');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (42,'mauris massa  aenean','et fames  sed vitae cursus massa amet varius sagittis   vitae eu elit tortor nulla magna eget sapien');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (43,'mauris diam risus','elit porttitor amet mauris iaculis  sit et mauris bibendum rhoncus  scelerisque pellentesque tempus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (44,'diam ornare tristique','at ut phasellus  pretium sit mauris lorem augue a pellentesque tellus diam feugiat tempus potenti tortor');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (45,'pellentesque lectus','at diam ut purus augue at nisl vulputate eu aenean nulla mauris arcu laoreet  suscipit erat   imperdiet');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (46,'eu erat a aliquet massa','morbi non ut amet  fames porttitor risus  nisl odio tempor tortor   risus vulputate  pharetra  vel  ut');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (47,'sed   non auctor semper','varius enim nibh sed at enim adipiscing  et est elit vel sed eget  aliquam nibh nascetur risus augue cursus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (48,'molestie in sit ipsum','parturient pharetra senectus blandit sed  cursus dictum  consequat quis massa adipiscing ullamcorper');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (49,'aliquet pellentesque','urna  in phasellus  egestas eu amet imperdiet dapibus vestibulum amet justo sed pharetra et massa elit nulla');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (50,'viverra sit mauris ut','mattis sit  eget massa sit felis interdum morbi   tortor donec arcu et mattis etiam eu pretium pharetra amet');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (51,'vitae aliqua sit ut','purus tellus auctor dictum  lobortis non donec donec elementum commodo eget  varius in ut  mi pretium');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (52,'libero sagittis vitae','ut in feugiat  malesuada tincidunt purus  massa nam  varius integer consectetur aliquam nulla enim lectus ut');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (53,'iaculis non adipiscing','proin risus proin purus mauris dictum urna vitae pellentesque non amet id id  nibh eiusmod erat iaculis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (54,'ut parturient ultrices','amet tortor dolore sem sit ut dolor vestibulum tristique maecenas  consectetur pellentesque feugiat');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (55,'eu tempus purus neque','molestie et scelerisque magna cras vel a purus massa iaculis enim mauris condimentum ullamcorper  id mauris');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (56,'imperdiet libero at','neque aliquet  in vitae malesuada amet  lorem neque amet a quisque malesuada est erat ac tempor scelerisque');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (57,'ultrices neque cras sed','quisque  bibendum tortor vel tincidunt nec convallis elit dis nunc dapibus et non nisl non donec elementum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (58,'vitae adipiscing arcu','hac consectetur sit aliquet non pretium tellus tristique  justo sapien sed ut egestas arcu  in  faucibus dui');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (59,'hendrerit in nisl','varius varius elit ultricies adipiscing nunc erat tellus id sed quam vulputate non nec ac consequat tempus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (60,'leo feugiat tellus','sit ullamcorper enim amet sed  et sodales   et hendrerit sit quis sit nulla cursus nibh    viverra augue');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (61,'tempus sed  ac vitae','lectus vel augue egestas vulputate semper nulla  mauris etiam sit in aliqua aliquet a at etiam  arcu amet');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (62,'nisi  quam gravida ut','aliquam mattis consectetur faucibus nisl feugiat fermentum cras eget nec eget nam tortor augue cursus quam');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (63,'tincidunt ipsum nibh','nulla donec  et vulputate quam sit quis ullamcorper non aliquam pellentesque rhoncus id pharetra tortor');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (64,'rhoncus pharetra augue','quisque sit sed semper eiusmod arcu ipsum vel sit  ornare convallis elit viverra feugiat pellentesque   diam');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (65,'nullam quisque pretium','at tortor ultricies nunc risus interdum elementum sit nisl  quis amet  sed a hendrerit risus massa  sed');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (66,'lectus blandit cursus','nulla mattis diam amet  sed est nec faucibus turpis quisque massa dolor feugiat amet egestas condimentum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (67,'massa ut quam tortor','velit sed amet  consequat sed bibendum sit donec enim vitae non mattis pharetra ultricies scelerisque  a');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (68,'ipsum eu risus at arcu','molestie sit nec congue molestie purus et risus adipiscing dignissim nulla   in porttitor  aliquet lobortis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (69,'habitant at  quam amet','fermentum massa quis amet   eget diam vestibulum ac sed consectetur nec eget  potenti quisque donec id');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (70,'ipsum eget nulla','nisi sed tellus  id sit mus lorem sagittis ac vitae  quam dapibus massa condimentum in ac  erat diam non');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (71,'proin eu magna velit','erat mauris urna magna enim tempus  hac duis vitae vitae purus urna facilisis nisl scelerisque cursus mauris');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (72,'hendrerit consectetur','convallis massa sed habitant amet semper massa senectus ut massa tempus  augue consectetur aliquet eros');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (73,'amet sit non tincidunt','vulputate orci leo sed tellus tristique egestas odio diam id quis venenatis tincidunt  pretium  dictum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (74,'amet id orci  at congue','commodo arcu fusce sed tortor donec egestas  augue sit  ac non consectetur tellus elit nunc condimentum');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (75,'nisl  amet nunc','nisi scelerisque nibh viverra velit ultricies velit ut mauris eleifend lorem facilisis pretium nisi');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (76,'bibendum tempor','cursus  tortor  id arcu nibh nunc venenatis netus morbi  ipsum interdum egestas senectus dolor tristique');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (77,'nibh mi aliquam lacus','enim viverra in donec nulla enim aliquet quis sagittis bibendum in quam turpis habitant turpis cursus at');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (78,'quis sit id faucibus','integer velit turpis semper diam diam elit nulla tempor consectetur in massa nullam consectetur tellus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (79,'et proin eget','sit sagittis integer fusce aliquet sit vitae id fermentum gravida in egestas nec do dictum erat vitae fusce');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (80,'vel lobortis aliquam','senectus tincidunt cursus elit at amet quis consectetur morbi leo at at velit  senectus sit massa   gravida');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (81,'a nam interdum  risus','integer enim erat ac malesuada at suspendisse  non mattis cursus dolor mus  ac mauris in sed sit  mattis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (82,'turpis dapibus semper','nisl nibh labore at dapibus aliquam mauris donec  senectus etiam molestie fusce tellus nibh tortor tempus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (83,'gravida orci nunc','malesuada vulputate dapibus  imperdiet  vel nisl ullamcorper adipiscing  pretium ipsum pulvinar feugiat sit');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (84,'ac tristique orci eget','eu sed eros  consequat nunc  mollis lobortis suspendisse eget non eu  gravida  sed  molestie purus  in in');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (85,'quis massa velit quis','vitae consectetur nulla velit augue rhoncus sit donec amet  risus non nunc venenatis amet felis vel quis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (86,'in nisi enim sed','tortor nunc consequat sem eu facilisis quam tempus consectetur sed sed sit feugiat bibendum sit urna');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (87,'eget  fusce tempor','neque tortor a feugiat neque pretium  at eu nibh  eu ac congue amet amet massa consectetur  sed tempus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (88,'adipiscing ipsum','nullam eget elit amet eu aliquet lectus nulla fusce consectetur aenean  erat consectetur blandit ac nascetur');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (89,'varius proin risus enim','nunc iaculis  velit adipiscing nisl arcu quisque massa odio mus mi  ac gravida turpis diam  nisl arcu');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (90,'in faucibus mauris','urna tortor faucibus augue urna justo  ac tincidunt molestie gravida vestibulum ullamcorper mauris nec quis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (91,'eget lobortis  at a a','ut diam ut  nullam dolor diam ornare quam iaculis incididunt sem purus scelerisque consectetur cras non');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (92,'cras orci mauris sem','quam nunc diam dictum morbi mauris sodales  ac cursus eu  eu non sit non vulputate erat feugiat enim lacus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (93,'purus elit   a odio','adipiscing tellus viverra sed congue condimentum tristique aliquam nec nisi pharetra praesent tellus');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (94,'ac massa diam lectus','tincidunt pulvinar tristique scelerisque orci porttitor nulla vestibulum massa viverra non porttitor sed');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (95,'id aliquet tristique','consectetur ipsum  morbi pretium consectetur consectetur praesent ut  augue elementum in sit suscipit amet');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (96,'condimentum  risus et','ut vel amet imperdiet amet  at interdum  ut quam mus habitasse   maecenas sapien turpis urna purus consequat');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (97,'iaculis ultricies lacus','orci sit diam  egestas ac at amet purus nulla tempor tempus ultrices platea tellus sagittis pulvinar semper');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (98,'in tincidunt  sed orci','erat tellus  vulputate ac viverra dictum  nisi hendrerit pharetra malesuada sollicitudin  arcu tortor mi a');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (99,'sollicitudin velit','et vitae tellus fusce lectus augue mauris euismod auctor adipiscing  etiam pulvinar et augue eget arcu quis');
INSERT INTO rubrica (r_id, r_descricao, r_observacoes) VALUES (100,'nulla ultricies dis ut','porta sit massa vitae arcu eros  ut scelerisque    vulputate ut at cursus sit et risus  sit cursus  ut');
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (1,'Jeremiah Morris', 47, 'dictum mattis egestas cursus id habitant feugiat pretium platea id eget  donec volutpat  vitae scelerisque fermentum fames pulvinar  risus  dui est nulla in amet integer diam  sit hendrerit risus vel quis vestibulum elit enim ut mauris sit dolore nisi', 52330, 45006.65412512528, 'United Kingdom', 0, 'United Kingdom', 11971);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (2,'Charlotte Rogers', 44, 'massa varius magna etiam orci hac dictum  nam integer ac nullam consectetur amet hac suspendisse  tincidunt gravida non nec nulla nibh a sed facilisi quam sit vitae sem   dictum parturient dui lorem cursus interdum amet diam pellentesque nibh  donec', 44288, 30872.653480702098, 'United Kingdom', 1, 'United Kingdom', 52538);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (3,'Tristan Rasmussen', 59, 'proin lectus feugiat dis erat lorem  duis sit non porttitor elementum purus massa urna arcu  morbi diam aliquam duis ac rutrum aenean nascetur tortor ultrices nibh vehicula et non condimentum mus  ut at condimentum in lectus ridiculus nulla molestie', 31773, 9358.08284524348, 'Denmark', 0, 'Denmark', 55762);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (4,'Elizabeth Curtis', 54, 'nec sed lacus tristique  quis iaculis in nibh arcu orci  in aenean adipiscing lectus  lorem sapien proin quam et nulla iaculis adipiscing augue platea mauris consectetur fames  iaculis purus amet magna sit mattis  sit  sollicitudin eget velit eros odio', 42863, 23197.948786645637, 'United Kingdom', 1, 'United Kingdom', 30018);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (5,'Lola Hubert', 43, 'eu diam massa tincidunt sed ac nec nulla faucibus quam lorem mauris proin lorem ac dapibus neque eleifend nibh et  diam nulla ut etiam id varius pulvinar sit potenti ipsum augue habitant eu euismod pellentesque tempor lacinia faucibus pharetra non non id', 25366, 58212.766942816765, 'France', 1, 'France', 27193);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (6,'Aaron Blanchard', 75, 'senectus tempus aenean  morbi ornare morbi lacinia ut ut massa diam congue tempus iaculis ut morbi sed a cursus adipiscing  commodo  aliquet vestibulum nulla tempor tempor congue quis  ac donec enim sagittis diam massa ut quam enim dis   nibh mi egestas', 5021, 14226.41626669175, 'France', 0, 'France', 63107);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (7,'Marshall Schmidt', 34, 'consectetur scelerisque  vitae faucibus viverra egestas senectus interdum odio nulla consectetur sed quis mauris  eget gravida  eu lectus   sem  a nullam sit tempus tempor justo elit sit tempor lobortis neque dolor amet enim vel consectetur hendrerit', 18879, 13744.404115338582, 'United Kingdom', 0, 'United Kingdom', 40214);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (8,'Addison Carr', 28, 'sed ac  adipiscing phasellus  parturient viverra donec elit, risus volutpat aliquam  habitant ut  dictumst leo malesuada et sit faucibus aliquam in gravida amet dignissim vulputate nunc varius  urna in iaculis facilisis nunc dictum eu ultrices duis nam', 35138, 48468.82287930225, 'United States', 1, 'United States', 17317);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (9,'Lilly Roux', 74, 'dapibus  nulla urna cras amet elit nibh a at iaculis  bibendum condimentum tortor faucibus facilisis  sit vestibulum in neque dictum vel elit feugiat sit viverra amet   elementum a sed feugiat nunc suscipit  proin  dolore  gravida imperdiet ipsum  ut', 66406, 5222.147554516515, 'France', 1, 'France', 23930);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (10,'Suzanna Gomez', 48, 'mi nam eget urna nisl purus lectus ut bibendum maecenas eget nascetur elementum vitae vivamus donec  convallis a fames vestibulum netus malesuada curabitur nunc vitae suscipit vel mattis iaculis sagittis varius pellentesque aliquet curabitur erat', 25905, 41145.81709860233, 'United Kingdom', 1, 'United Kingdom', 29316);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (11,'Rafael Edwards', 31, 'aliquam nisi facilisis pharetra adipiscing urna  adipiscing arcu nunc quis ultricies aliquet purus molestie sit pretium in ornare pharetra id mi sed ornare eu phasellus enim mi ultrices  tempor in nulla   eget  condimentum cras semper volutpat nam amet', 11764, 22749.251236270553, 'United Kingdom', 0, 'United Kingdom', 55059);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (12,'Vanessa Lane', 72, 'quam sit  nulla cras semper netus  lacinia fames ultricies at suscipit a urna gravida tempus elementum sed ac quisque elementum arcu morbi imperdiet iaculis proin quis arcu tristique magna vitae senectus elit  quam parturient tincidunt odio non', 10925, 17439.705189759152, 'United States', 1, 'United States', 48457);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (13,'Soham Shaw', 75, 'at  velit ultricies massa purus suspendisse    dui lobortis nulla facilisi proin duis diam fermentum bibendum justo tempor faucibus semper  faucibus facilisi purus  fames lorem hac mauris suspendisse varius turpis congue cursus at  nascetur eget purus', 38050, 50779.19783397232, 'United States', 0, 'United States', 65910);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (14,'Albert Christiansen', 68, 'purus habitant aenean pellentesque odio sed urna nibh enim facilisis arcu pellentesque facilisis aenean molestie nascetur lacus  faucibus ac lorem  cursus  aliquam quis fusce tempus turpis hendrerit faucibus  sem pellentesque  sed tellus semper  ac', 10812, 63198.64337035818, 'Denmark', 0, 'Denmark', 18123);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (15,'Benjamin Poulsen', 40, 'viverra arcu  diam ornare pellentesque et sagittis  amet amet cras dolor viverra arcu eu faucibus mattis aliquam ut velit sapien vulputate hendrerit tellus eget ut mauris et sit pellentesque augue nec purus arcu  dictum quisque tincidunt amet  feugiat', 12609, 29300.119449879057, 'Denmark', 0, 'Denmark', 54283);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (16,'Tracy Willis', 49, 'massa potenti scelerisque lacinia vitae sed pharetra diam a lectus eleifend facilisis odio ut et sollicitudin faucibus proin et eget ut netus habitasse pretium consectetur enim bibendum tincidunt neque nisi vulputate  nulla nunc rutrum adipiscing ut', 17074, 24433.463856733106, 'United States', 1, 'United States', 46587);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (17,'Catherine Larson', 66, 'vitae  nam orci quis sit dui  a  nibh viverra aliquam sed eiusmod integer   augue nisi placerat lobortis dictum magna amet cras tortor morbi laoreet  tincidunt amet justo nulla massa nullam mi volutpat non  nisi nec  sed sit sed enim sit lacus', 59990, 17464.524204616828, 'United States', 1, 'United States', 1795);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (18,'Judith Henderson', 74, 'urna varius massa ut auctor mauris nulla volutpat  duis fermentum sed nisl consectetur feugiat quisque gravida eu pellentesque egestas vulputate massa sed tellus  purus nec arcu vel cras sagittis sed nullam tempor rutrum vitae sit nisi nisl  diam enim', 37279, 22699.943172305484, 'United States', 1, 'United States', 61196);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (19,'Astrid Larsen', 59, 'tristique et  id donec velit   consectetur id pellentesque odio et tellus aliquet gravida bibendum imperdiet turpis enim ut nibh suspendisse  at mus massa  lectus suspendisse condimentum gravida eu vitae quis vitae dolore amet fermentum cursus ipsum', 43703, 36248.3081289091, 'Denmark', 1, 'Denmark', 66976);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (20,'Perry Smith', 62, 'tellus lobortis  semper integer at duis  ut vestibulum purus arcu turpis nisi rhoncus sit adipiscing sollicitudin nisl dolore  nunc fusce quis tortor a iaculis leo sed sed congue adipiscing at purus lacus  cras elit ut et pretium nec rhoncus hendrerit', 36228, 36066.00237981541, 'United States', 0, 'United States', 55293);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (21,'Tristan Jørgensen', 58, 'suscipit venenatis sit eu nascetur venenatis id ultricies nibh nisl eget sed tellus  aliquet nisl nibh  egestas nisl tempor sit urna cras elementum in mattis imperdiet eget  in amet sagittis interdum rhoncus nulla adipiscing vel mi cras sit  tortor mi', 68335, 12041.67540486264, 'Denmark', 0, 'Denmark', 33312);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (22,'Alfred Lee', 51, 'neque labore aliquet adipiscing duis viverra  tristique rhoncus fames varius massa quis mauris id facilisi venenatis varius  sagittis facilisis at vitae mauris eu ac ipsum nec suspendisse tempor hac viverra congue ultrices porttitor dictum commodo nunc', 57811, 41493.27079118687, 'United Kingdom', 0, 'United Kingdom', 2909);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (23,'Francisco Thomas', 50, 'in pharetra et augue faucibus justo mi  magna viverra congue enim ut pulvinar tellus aliquam pretium faucibus ullamcorper nunc at pellentesque ullamcorper interdum massa et  diam aenean nibh donec faucibus diam diam at cursus velit lobortis magna eget', 69284, 35698.98775045841, 'United Kingdom', 0, 'United Kingdom', 60848);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (24,'Jen Mccoy', 46, 'amet tincidunt condimentum odio leo nam sed non vestibulum sed at nunc nisl aliquam leo at vitae semper interdum tempor cras varius  diam fusce odio enim  semper habitant consectetur cras suspendisse in  amet  turpis ut pellentesque adipiscing amet', 18919, 25730.829898310414, 'United Kingdom', 1, 'United Kingdom', 31469);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (25,'Jessie Cruz', 60, 'tortor odio nullam cursus adipiscing vivamus dolore sed proin erat lectus at diam fusce viverra amet nibh habitant mauris vitae pretium quis etiam tortor nec lacinia ipsum eget  lectus urna tempus vestibulum morbi nunc a  auctor neque  in urna id', 46893, 18534.320320887942, 'United States', 1, 'United States', 66484);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (26,'Lauren Foster', 64, 'netus  sed suscipit neque vitae  odio sed dignissim aliquam mauris et  ipsum  tempor auctor in  risus urna amet vitae adipiscing mus adipiscing arcu leo pretium gravida venenatis massa consectetur luctus amet tellus  leo iaculis nunc erat  nisl elementum', 69200, 5876.977833992676, 'United States', 1, 'United States', 66874);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (27,'Jose Hicks', 48, 'quam tortor mattis  malesuada  nibh dictumst lorem sed lacinia quisque ac lacus massa adipiscing odio duis neque vulputate urna donec non tellus in tincidunt imperdiet condimentum non eu congue sit cras turpis lacus arcu morbi  vitae quam dapibus lectus', 11272, 24389.411064614786, 'United Kingdom', 0, 'United Kingdom', 69316);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (28,'Mathys Morel', 30, 'nec iaculis tellus lectus at diam massa quis molestie mus pellentesque suspendisse  tortor  gravida aliquet mi ullamcorper quisque etiam  sed id  id  amet enim  congue  integer ac et morbi volutpat  magnis orci  et  suspendisse sit pulvinar aliquet', 56814, 16361.645857942753, 'France', 0, 'France', 55333);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (29,'Maya Henry', 55, 'adipiscing pellentesque labore   potenti ornare sed dictum sit  leo aliqua at nisi vel odio dui suspendisse malesuada est  neque leo in odio cursus nisl tristique eget condimentum non  venenatis varius consequat  nec dapibus vitae feugiat risus  a nulla', 50731, 43411.505820623664, 'France', 1, 'France', 54069);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (30,'Harvey Freeman', 65, 'pulvinar et nam pellentesque nisl vestibulum lacus varius ridiculus egestas iaculis augue dictum tellus adipiscing vel vitae sed lorem cursus amet viverra tellus sed velit aliquam id  diam purus urna  ut  faucibus egestas  dictum  vel ac faucibus', 62392, 12124.443859916175, 'United Kingdom', 0, 'United Kingdom', 6025);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (31,'Sharon Lee', 38, 'non tortor tincidunt facilisis rhoncus porta nulla adipiscing ultrices ac lacus non nunc pellentesque diam  sed dolor enim at quisque pulvinar luctus non pellentesque eu venenatis arcu tristique vitae consequat non nec in et et  tempus eget   sit sed', 62612, 32074.544663751723, 'United Kingdom', 1, 'United Kingdom', 50259);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (32,'Janet Patterson', 30, 'duis sem tempor vel risus aliquam  elit pharetra purus  amet vestibulum neque sem aliquam tincidunt netus ut proin a  quis vitae tincidunt donec turpis urna augue mattis nam nibh nulla sapien  sollicitudin sollicitudin condimentum ultrices amet mauris', 40361, 29191.139928448698, 'United States', 1, 'United States', 60199);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (33,'Isabella Chavez', 64, 'viverra euismod   arcu sit suspendisse potenti sit in at morbi sollicitudin neque facilisis diam tortor sit adipiscing in duis sed mattis sit habitant fames ipsum aliquam adipiscing dapibus cras pellentesque  enim risus neque odio facilisi elementum', 8680, 47874.71354643969, 'United Kingdom', 1, 'United Kingdom', 28098);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (34,'Vanessa Montgomery', 70, 'risus suspendisse ipsum ut sagittis potenti sed fusce amet nisl in sed tortor auctor facilisi augue feugiat at mattis purus   vitae vitae bibendum urna convallis ultrices  volutpat netus sit tellus  id neque ultricies lacinia faucibus lorem  mauris', 38286, 42136.00428606521, 'United States', 1, 'United States', 16156);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (35,'Elias Jørgensen', 65, 'amet a condimentum  nam amet risus   a luctus a purus hendrerit quis amet  iaculis praesent gravida  mauris sed ridiculus viverra nisi cursus  dictum sed at consequat  sed arcu potenti in sit amet placerat  scelerisque odio purus in massa  morbi tempor', 68952, 36728.485176215734, 'Denmark', 0, 'Denmark', 50674);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (36,'Nathaniel Soto', 76, 'mauris sed ac dapibus  viverra lacus orci in  quam consequat dapibus vitae commodo gravida fermentum convallis  sed   purus nullam cursus mi dictum orci nullam gravida ultricies sit sit lectus risus vitae duis lectus  a hac quisque vitae tellus cras', 47302, 43837.00164710575, 'United Kingdom', 0, 'United Kingdom', 11742);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (37,'Mille Christiansen', 56, 'viverra sit augue neque euismod vitae sed   eu  integer amet aenean consequat condimentum magna morbi amet vestibulum neque vitae ornare sit blandit nisl nullam quis netus eros tempor orci et amet  libero dictum  sed hendrerit aliquam a id pellentesque', 7485, 16166.316615170239, 'Denmark', 0, 'Denmark', 46382);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (38,'Marcus Andersen', 60, 'libero viverra vulputate id nibh elit    quam  amet tellus nisl id sit commodo bibendum mauris id id quam pretium elementum  non ut nibh bibendum  ac ut aliquam adipiscing gravida aliqua nulla commodo aliquet pharetra at volutpat nec at egestas viverra', 57408, 7049.06240445228, 'Denmark', 0, 'Denmark', 8192);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (39,'Izzie Lawrence', 63, 'viverra nunc diam lectus risus  malesuada risus tincidunt aenean non dui fusce dictum  vel vel porttitor condimentum aliquam faucibus ullamcorper a   nibh nascetur vitae odio arcu gravida sit sit id praesent purus massa id  aenean id elit  tortor nisl', 53730, 45572.88434134844, 'United Kingdom', 1, 'United Kingdom', 46308);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (40,'Leslie Romero', 36, 'urna amet risus amet sed suspendisse varius risus at fermentum eu malesuada  fermentum diam eget est mauris donec neque nulla nascetur  eget tincidunt elit sapien malesuada aliquam eget viverra sagittis malesuada nunc morbi  dui pharetra pellentesque hac', 3202, 14039.957496221765, 'United States', 1, 'United States', 27947);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (41,'Bob Smith', 40, 'eu arcu lectus  mi imperdiet augue  risus aliquam non  mauris nunc libero adipiscing elit nulla faucibus velit malesuada libero eget sit tortor mollis senectus ut nec amet adipiscing a at urna  in nibh duis ipsum porttitor nec felis integer fames viverra', 26625, 8792.41665015093, 'United Kingdom', 0, 'United Kingdom', 11129);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (42,'Gustav Poulsen', 57, 'amet lobortis in sem fermentum consectetur tellus  amet nibh ut aliquam tempor semper mauris habitasse diam ut consectetur porttitor eget tellus turpis nunc neque eget ipsum montes faucibus lectus   rhoncus nibh arcu sit odio   adipiscing quam velit', 9136, 23119.155061902275, 'Denmark', 0, 'Denmark', 63692);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (43,'Craig Smith', 31, 'aenean nisi mauris venenatis id hac tellus sed cras vitae et suscipit nisl et  convallis eget id facilisis hendrerit integer egestas ornare fusce netus ultrices aenean sed suspendisse adipiscing consectetur consequat aliquam enim etiam non ut rutrum', 1342, 60853.45897597232, 'United Kingdom', 0, 'United Kingdom', 15630);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (44,'Filippa Rasmussen', 49, 'arcu lobortis  suscipit  et tempus egestas   sit nunc  vestibulum pellentesque nulla interdum  sed viverra in ultricies auctor nibh sed  senectus ullamcorper  orci risus vulputate non faucibus libero turpis velit maecenas odio  amet in  nisi cursus', 18493, 2305.371622555187, 'Denmark', 1, 'Denmark', 57326);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (45,'Lilian Vincent', 62, 'diam adipiscing mattis tortor consectetur quis viverra sit consequat semper consequat tempor molestie semper tincidunt quisque a augue et mauris mus libero amet facilisis orci  sem consectetur eu neque nulla gravida aliquet cursus morbi in sed in tellus', 2585, 61612.67035829444, 'France', 0, 'France', 51827);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (46,'Jules Sanchez', 62, 'viverra cursus aliquam hac habitant porttitor feugiat amet ornare id iaculis laoreet vitae adipiscing   vitae  consectetur viverra enim pellentesque sed iaculis sit nunc phasellus consectetur elementum sed felis feugiat  mus malesuada amet  ultricies', 48396, 35122.793913484646, 'France', 0, 'France', 49381);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (47,'Jon Rivera', 42, 'velit hac vulputate risus mattis sit euismod morbi blandit scelerisque hendrerit massa  enim sed velit ullamcorper ipsum a incididunt sed  sapien arcu sollicitudin imperdiet fermentum id mollis id ut in arcu lacinia et amet gravida rhoncus sed nec varius', 34655, 35403.3819267269, 'United Kingdom', 0, 'United Kingdom', 21486);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (48,'Simon Thomsen', 71, 'risus fusce sed rhoncus urna  gravida donec viverra  habitasse et volutpat quam lobortis  amet cursus  et volutpat nisi ut risus nisl  dapibus scelerisque ut risus neque  viverra ut vitae dapibus dolor  at non tempor massa ultricies quam  nec parturient', 13936, 30244.381435348863, 'Denmark', 0, 'Denmark', 51743);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (49,'Rafael Carroll', 69, 'integer aliquam in sapien volutpat ac libero sit amet dolor pellentesque diam sed massa morbi mattis nascetur purus viverra vitae habitasse suspendisse eget mauris sit consectetur nulla vitae erat consectetur vitae fermentum euismod fermentum eu nulla', 45661, 62553.159036282515, 'United States', 0, 'United States', 35121);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (50,'Barry Barrett', 64, 'urna  augue nascetur  id velit in molestie morbi at  libero quisque nullam nunc phasellus amet pellentesque imperdiet aliquam at viverra nunc habitant non at suspendisse leo fermentum  etiam  consectetur amet sit egestas vel fames suspendisse non dolor', 39086, 38197.08747906225, 'United Kingdom', 0, 'United Kingdom', 22705);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (51,'Marius Hansen', 49, 'sagittis massa scelerisque consectetur enim tempor id lectus pellentesque  consectetur ut at id magna lorem ultricies sit purus diam ut sit nibh duis nibh rhoncus pulvinar laoreet suscipit sit lectus pretium at ornare vestibulum purus nec ultrices purus', 48530, 67626.9005974439, 'Denmark', 0, 'Denmark', 18825);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (52,'Tammy Cruz', 30, 'tempus pretium lectus egestas et ac elementum erat  porta et mattis malesuada  elit lectus nam diam et amet erat lacus quam  sed urna dolore  augue suspendisse non consectetur diam enim at ultricies massa integer libero  sit amet id mattis gravida hac', 15712, 41685.02889045031, 'United States', 1, 'United States', 33851);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (53,'Tonya Gutierrez', 48, 'mi suspendisse egestas nulla turpis nibh ultrices  sit tellus massa  diam vulputate vel sit mauris  tempor integer molestie turpis faucibus volutpat neque  quam tristique velit pharetra dui nam malesuada tincidunt ut  vestibulum tempus in tristique quis', 66961, 46397.53174095678, 'United States', 1, 'United States', 68371);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (54,'Darrell Chavez', 25, 'lorem imperdiet at tempus quam  amet adipiscing  pretium ac  vitae molestie leo varius diam hendrerit sit gravida condimentum malesuada labore suspendisse at nulla tincidunt tortor sed nibh mi at massa luctus nam  venenatis iaculis suscipit dapibus', 30974, 16410.338784397012, 'United States', 0, 'United States', 20554);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (55,'Johanne Andersen', 33, 'tellus amet enim tincidunt non eget quis pellentesque a duis ac tortor enim enim nibh orci senectus mauris pharetra dapibus nullam feugiat non feugiat pharetra  ultrices  viverra in vitae diam aliquam lectus pellentesque curabitur amet sed velit iaculis', 58569, 3268.8071108695885, 'Denmark', 1, 'Denmark', 282);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (56,'Sherry Lewis', 51, 'id vitae venenatis  proin nulla consequat eget augue cras  nibh nisl  sit sed consectetur faucibus diam non urna diam amet nunc sed  nunc  blandit libero eget  sed varius molestie facilisis condimentum ipsum et et sed cursus nec nunc urna quam  ac', 36572, 13215.839104608893, 'United States', 1, 'United States', 37411);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (57,'Maria Rhodes', 45, 'labore gravida a dapibus ultrices non id  nulla elementum nec potenti habitasse id tristique massa  cras consectetur amet tellus ullamcorper faucibus   ac sem eu amet vulputate nibh at at luctus ultrices pellentesque euismod felis quis tempus  ridiculus', 16759, 31107.43807057763, 'United Kingdom', 1, 'United Kingdom', 5527);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (58,'Maria Andersen', 47, 'enim at feugiat id   suscipit erat tortor nibh sit integer et nam sem eu consequat lacinia vel  amet mollis ultricies purus eros tortor purus arcu  tellus vel cursus vitae pulvinar mauris euismod odio arcu pellentesque nulla  a eget velit nunc fermentum', 52807, 43823.02903974168, 'Denmark', 1, 'Denmark', 62266);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (59,'Lea Pedersen', 30, 'nisl lectus luctus aliquet  eu elementum velit enim nunc  fusce fermentum semper  rhoncus vestibulum feugiat consectetur tempor adipiscing neque fermentum lectus tincidunt nascetur mauris   dolor ut pellentesque pharetra scelerisque dictum ut eget', 11511, 44527.76012006115, 'Denmark', 1, 'Denmark', 35453);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (60,'Don Sanders', 35, 'ut turpis sollicitudin cursus placerat nunc molestie ullamcorper fermentum vitae nam tempus adipiscing id erat tellus duis facilisi neque eros vehicula non ac lectus  ac congue interdum tellus  senectus in nunc et  nec ut magna arcu habitasse elit', 64417, 43538.73131760305, 'United Kingdom', 0, 'United Kingdom', 25620);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (61,'Jeanne Burke', 39, 'aliquam  fermentum nibh nunc vel vulputate mauris maecenas sagittis nulla amet sed phasellus feugiat tellus augue et eget tempus enim  sit in sit quam diam sit feugiat egestas tincidunt nunc augue nulla eu ultrices  quam consectetur dolor consequat', 57913, 15421.23029682812, 'United States', 1, 'United States', 48042);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (62,'Leon Lewis', 57, 'nunc felis nisl faucibus  purus molestie egestas commodo sit id facilisi aenean felis commodo  ut orci sit   bibendum sit odio  in et dictum vitae enim  nibh arcu justo viverra diam habitant  purus mattis lorem  lacinia nulla et viverra at pretium donec', 30170, 43607.091175986454, 'United Kingdom', 0, 'United Kingdom', 6466);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (63,'Sharon Kelley', 55, 'diam erat tortor odio  amet diam  at sed mi proin ultrices   nam vehicula adipiscing volutpat amet dolore fermentum sed vulputate porttitor tortor sed sit tincidunt in ipsum ipsum proin nibh adipiscing nam lectus non euismod  sed congue  nibh id neque', 16805, 13372.7498597671, 'United Kingdom', 1, 'United Kingdom', 35404);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (64,'Gene Perry', 41, 'vel quam arcu fusce sed consectetur turpis porta ultricies   est mauris pulvinar convallis  bibendum ipsum rhoncus sagittis suscipit  consequat interdum diam  vivamus amet semper labore nunc massa  consectetur pretium ultricies morbi amet  dapibus', 25571, 27691.319489185982, 'United Kingdom', 0, 'United Kingdom', 4425);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (65,'Lauren Porter', 42, 'mauris dapibus purus lectus eu viverra sit dolor enim faucibus in sit feugiat  tincidunt ac montes auctor ut suspendisse nec lobortis morbi morbi morbi nibh vitae ut ornare  gravida elit euismod molestie nibh blandit arcu habitasse faucibus condimentum', 3419, 44133.527666290865, 'United Kingdom', 1, 'United Kingdom', 20104);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (66,'Tina Burns', 70, 'eleifend  gravida at  vulputate facilisis sagittis  arcu lectus viverra neque nulla sed non consectetur vitae quis faucibus ipsum aliqua proin nisl viverra vitae at ut tempus posuere augue at nulla sed diam suspendisse libero vitae iaculis sit vel', 11387, 60648.2541522799, 'United States', 1, 'United States', 47012);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (67,'Emile Lemaire', 76, 'nunc tellus justo augue magnis vestibulum diam ullamcorper sed tristique  elit cursus lectus diam mauris fusce sit sagittis aliquet eget malesuada lectus sit sed viverra sollicitudin congue varius amet augue ac nisl lacus feugiat in odio accumsan  ipsum', 57584, 18050.11481397994, 'France', 0, 'France', 60652);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (68,'Astrid Nielsen', 40, 'facilisis consectetur sit  ipsum  urna gravida mus viverra elementum id  tempus pellentesque tempor ut vitae tincidunt gravida dui vitae faucibus nam nunc ipsum sit condimentum dictumst varius faucibus nulla viverra tortor quam semper vestibulum id ut', 26447, 62508.44810197879, 'Denmark', 1, 'Denmark', 57815);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (69,'Debbie Spencer', 63, 'consectetur  risus dolor aenean donec lorem  adipiscing lectus aliquet scelerisque urna facilisis mi morbi pellentesque in non non enim  tristique consequat odio et odio ultrices fermentum sed sapien  cursus at augue vulputate a   scelerisque nunc odio', 59813, 69176.27089490757, 'United Kingdom', 1, 'United Kingdom', 43077);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (70,'Nicklas Olsen', 46, 'diam cras  adipiscing cursus lacus tempus neque tempus  nam in nulla arcu in ultrices tristique tincidunt sed massa sit risus imperdiet cursus  sit fermentum  donec sit  malesuada molestie porttitor  morbi adipiscing suscipit est vulputate velit massa', 6910, 59335.61162116498, 'Denmark', 0, 'Denmark', 50002);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (71,'Alexander Newman', 39, 'gravida velit et ultrices adipiscing nulla  potenti bibendum  et in urna leo condimentum orci consequat nunc tellus viverra fermentum imperdiet viverra sed  eget ultrices nulla congue id neque velit scelerisque ut  in sagittis  est duis lacus ridiculus', 19187, 34673.90298078854, 'United Kingdom', 0, 'United Kingdom', 40670);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (72,'Erik Black', 34, 'sit in libero elementum quisque mauris velit massa tristique egestas malesuada  volutpat non tempus lobortis blandit nec id  id viverra a urna  et sed aenean pulvinar id  quam at tincidunt nisl a eget lectus sed ac sit augue  eget amet tempor ipsum neque', 55260, 17189.410726664835, 'United Kingdom', 0, 'United Kingdom', 23181);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (73,'Maëly Perrin', 39, 'vitae consequat feugiat amet eget elementum non arcu non faucibus libero in orci ipsum in  morbi varius in  interdum et in vitae purus  tortor velit suspendisse rhoncus ridiculus ipsum euismod venenatis augue incididunt nunc  accumsan  fermentum eu vitae', 20105, 19201.84451107794, 'France', 1, 'France', 28430);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (74,'Olivia Kristensen', 29, 'non tellus non convallis aliquet hendrerit orci orci amet dictumst senectus diam netus ac ac lectus interdum urna vivamus a habitant vitae tellus duis velit cursus tincidunt et interdum eu potenti aliquet placerat vitae pellentesque ornare elementum', 57810, 33707.200627831524, 'Denmark', 1, 'Denmark', 51813);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (75,'Marie Petersen', 70, 'euismod ipsum suspendisse diam  ac nec aenean  nunc molestie  rhoncus duis nunc cursus et vel tincidunt pellentesque nunc arcu nec aliquet cursus accumsan donec duis lobortis orci lectus ut semper risus scelerisque tristique non consectetur ultricies', 55753, 16337.189953349913, 'Denmark', 1, 'Denmark', 12721);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (76,'Vanessa Ramirez', 45, 'duis sed tempus rhoncus vitae turpis  mi feugiat augue quam tempus  sed a quam amet nisl diam neque sed malesuada nisl  elit malesuada volutpat massa pharetra enim ac ut pellentesque porttitor sagittis   eu at risus lectus at morbi sem risus in dui non', 63611, 30928.62643502677, 'United Kingdom', 1, 'United Kingdom', 23736);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (77,'Rosa Kristensen', 30, 'quis ipsum nulla ac nibh habitant eget sed tortor nec ultricies molestie arcu tincidunt curabitur consectetur velit ut aliquet eget vitae ac augue eu imperdiet pellentesque mattis id neque amet elementum nunc  vestibulum morbi mus etiam  vestibulum sit', 23784, 40986.44038926678, 'Denmark', 1, 'Denmark', 61810);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (78,'Alexandra Henry', 58, 'magna adipiscing sit non a porttitor lectus a ut fusce vestibulum viverra egestas ullamcorper non amet sagittis vulputate quis vulputate risus  lectus mus  eu sapien amet diam feugiat vitae vulputate tellus tristique urna netus erat lacus interdum id', 7216, 39321.14555595369, 'France', 1, 'France', 14590);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (79,'Maxine Vargas', 67, 'dis risus pellentesque sit neque  pretium amet  mauris habitasse commodo rhoncus euismod tortor senectus  pharetra at  mollis convallis nec tempor  sit aenean lorem nunc ut   etiam pharetra maecenas nibh volutpat pellentesque velit  et netus nisl', 52825, 49328.69492370372, 'United States', 1, 'United States', 16132);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (80,'Danny Ferguson', 72, 'turpis laoreet  elit donec ultrices tortor aliquet   aenean gravida semper habitasse rhoncus elit consequat volutpat magna massa nibh in elementum amet mattis tempor tempus condimentum hac fusce vitae velit tristique ut purus tempus id tempor sed tellus', 22847, 31044.377413671067, 'United Kingdom', 0, 'United Kingdom', 24007);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (81,'Jeremy Stephens', 42, 'elit pellentesque  tristique in mi velit diam  sodales imperdiet eu ornare purus est eu augue senectus sed  eget mauris ipsum sit  leo condimentum fermentum ac  eu magna erat risus sed  ullamcorper ipsum donec luctus  massa id semper et porttitor', 7102, 56713.94829410834, 'United States', 0, 'United States', 26192);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (82,'Seth Mason', 41, 'incididunt risus gravida turpis senectus amet massa sem massa sit   dolore in faucibus leo eget tempor sed id enim at massa augue nibh pharetra sollicitudin mattis nec tempor sit  viverra cursus dictum neque sagittis vel etiam rutrum sapien labore  vel', 29809, 64674.10165654897, 'United States', 0, 'United States', 52690);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (83,'Marlene Chambers', 61, 'condimentum ut amet at porta urna tempor tempus vestibulum  quis diam sit sem  mauris auctor condimentum ornare rutrum mauris mi quam consectetur vitae sagittis  tempor neque  at duis imperdiet tellus semper feugiat tincidunt  aliquet vel diam pretium', 58285, 26981.556345317953, 'United States', 1, 'United States', 9704);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (84,'Eline Rey', 69, 'convallis massa amet  morbi  sed cursus ultrices  urna aliquam  eu  sed id lectus semper  sit risus nec nisl gravida netus platea nunc et duis elit eleifend duis auctor scelerisque  a dapibus gravida non amet, etiam et nulla euismod dolor elementum', 68779, 15616.345014788194, 'France', 1, 'France', 11728);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (85,'Mason Lynch', 25, 'tempor  vestibulum id tempor vitae do elit diam non amet et tristique tempus sapien sit sit risus   vitae semper platea mattis arcu quisque nulla nisl faucibus nibh sit ultrices varius porta ultricies vitae nibh tincidunt tortor sagittis mauris rhoncus', 29285, 42787.615757774634, 'United Kingdom', 0, 'United Kingdom', 16417);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (86,'Josefine Larsen', 32, 'augue  commodo senectus consequat ullamcorper nisl  lobortis velit leo pharetra  egestas ullamcorper condimentum sagittis diam odio  placerat orci suspendisse adipiscing nec nisl nisi nec augue urna gravida varius tortor quisque hac non hac vel malesuada', 25745, 20405.09755892594, 'Denmark', 1, 'Denmark', 65498);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (87,'Léonie Deschamps', 42, 'nulla mattis habitasse molestie egestas lacus sed enim erat non integer tortor diam nibh lacus varius nisl donec potenti elit viverra integer convallis arcu faucibus a molestie fermentum eu porttitor purus nec duis nec amet neque nec aliquam  mauris', 65437, 59166.10735358983, 'France', 1, 'France', 64839);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (88,'Minnie Steeves ', 35, 'porttitor quis  id id pharetra bibendum nibh at aliquam aliquam donec non sit nunc augue consequat lectus dui lectus diam nulla  ipsum in interdum dui enim at nam eu tempor netus mattis at adipiscing amet hac orci eu neque  mauris vel id mattis platea', 47196, 23743.94049827944, 'United States', 1, 'United States', 59292);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (89,'Julia Stewart', 37, 'mattis nec integer nunc non vel vulputate tristique  pharetra amet molestie pulvinar urna  nec vel elit ultrices nunc faucibus feugiat risus  justo feugiat adipiscing vulputate quisque amet urna enim  libero lectus enim elit scelerisque tortor lacus', 52076, 68910.04442346447, 'United Kingdom', 1, 'United Kingdom', 17058);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (90,'Nanna Kristensen', 74, 'blandit sit ridiculus ullamcorper ultrices nibh ut scelerisque suspendisse et proin et in at nisi elementum neque  est adipiscing consectetur ut malesuada purus volutpat eu elit consectetur dolor donec dolore et urna fermentum vulputate facilisi', 40027, 30207.523498823226, 'Denmark', 1, 'Denmark', 35125);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (91,'Robert George', 26, 'enim dignissim montes amet sed suscipit nisl odio tempor tempor amet proin feugiat sit faucibus  vel erat donec lectus dictum pulvinar  non morbi adipiscing aliquam ornare magna morbi est amet massa mattis quam ut lectus feugiat at dui porta sollicitudin', 39014, 68172.10481260676, 'United States', 0, 'United States', 19029);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (92,'Léo Perez', 46, 'mi at sed  non sit sit aliquam  amet tellus quam pharetra incididunt vulputate nunc aliquam habitant   praesent diam urna tristique quam sit ut nulla nunc parturient sit  blandit vitae cursus euismod tellus euismod malesuada venenatis donec sagittis', 64928, 68063.46018196172, 'France', 0, 'France', 53957);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (93,'Ralph Bennett', 30, 'sit justo vulputate est non proin in  amet  lobortis neque aliquam proin vulputate  gravida amet  neque dictum est nisl et porttitor eget sit nec  convallis in quam eleifend dictum quam vel cursus tristique suspendisse id pellentesque elit in ultrices', 11899, 38473.91645309284, 'United Kingdom', 0, 'United Kingdom', 1967);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (94,'Teresa Torres', 42, 'non tellus nec risus aliquam ultricies a et orci  mauris  neque nec massa cursus varius vulputate  nunc  purus nunc adipiscing nibh habitant eget vel augue orci id nascetur in sit viverra hendrerit urna diam platea lectus iaculis integer  amet mi odio', 64431, 49787.563496315015, 'United Kingdom', 1, 'United Kingdom', 9402);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (95,'Jonathan Christiansen', 60, 'nibh  turpis  mauris diam tellus  vestibulum lectus non eget elit id diam iaculis  nisl ut at aliquam   neque quam adipiscing nunc nec orci amet nec in eget a gravida lectus aliquet nunc massa aliqua mattis id varius massa egestas tempor senectus diam', 10397, 43435.81751868051, 'Denmark', 0, 'Denmark', 47667);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (96,'Allie Myers', 52, 'nec  scelerisque et  dolor malesuada neque etiam feugiat imperdiet bibendum ullamcorper potenti viverra diam  ut facilisis  libero velit sit amet sed lectus parturient  malesuada interdum donec nisl magnis non mattis duis aliquam dapibus nunc integer', 26566, 59996.60974625199, 'United Kingdom', 1, 'United Kingdom', 59866);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (97,'Reginald Gilbert', 67, 'lorem tempor cursus   risus condimentum cursus pharetra non ultrices nisl ridiculus quisque ornare vitae id nullam ornare consectetur duis massa sit imperdiet quis ut a in purus ultrices pulvinar incididunt ac odio at non pulvinar quis mi eu adipiscing', 17594, 22782.183823759362, 'United States', 0, 'United States', 21393);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (98,'Floyd Roberts', 34, 'et  sit vitae lectus dui dictum condimentum augue imperdiet egestas in morbi vulputate semper    fusce nisl malesuada nulla curabitur augue ullamcorper  donec  nulla adipiscing egestas vitae nibh  sit sagittis lectus amet morbi blandit risus montes donec', 10636, 43355.716839344626, 'United States', 0, 'United States', 58105);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (99,'Axelle Boyer', 64, 'enim sit quam quisque  mi vestibulum interdum elementum ipsum vestibulum massa  enim vulputate   sed massa velit id nibh nulla mattis mollis ut pretium  malesuada id aliquam at est arcu sapien sit sit commodo eu eros sollicitudin netus urna nec', 17754, 41930.76376428444, 'France', 1, 'France', 46646);
INSERT INTO j_id j_nome j_idade j_interesses j_tempo_gasto j_montante_gasto j_nacionalidade j_genero j_pais_residencia j_carteira VALUES (100,'Charlie Roussel', 73, 'nunc   tempor id ornare integer urna imperdiet pharetra augue condimentum  nullam  netus  aliquam et ut iaculis adipiscing mauris amet  pretium lacinia at lectus  ultrices risus morbi quis ultrices vel lectus fames lorem magnis sed nulla dictum  nec eget', 63437, 40486.75574586978, 'France', 0, 'France', 8886);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (1,'sed nisl pharetra tempor  tincidunt arcu', 36301.07, 9,'incididunt dignissim ac neque et nulla diam  purus  at nibh nibh tempus  mi mattis vitae senectus egestas nunc mus  sit cursus gravida elit malesuada ultricies congue senectus mauris  aliquet  condimentum purus diam  sed tellus odio viverra sed sed', 2, 6314.09, 'vitae dictum dolor  viverra quam  ipsum risus interdum faucibus diam  nulla viverra convallis ac', 506, 1094);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (2,'nunc at in consectetur aliquet tortor', 65818.69, 94,'quis in in nunc mattis fusce arcu nisl est semper quam congue labore amet  quis viverra mus morbi dui ultricies faucibus mauris ut condimentum et aliquam lectus  elementum proin suscipit et nulla augue et in  vitae non sit non erat pulvinar vitae id sem', 2, 10162.33, 'lectus augue mauris tortor  porttitor nunc malesuada et volutpat orci augue  consectetur  cras', 531, 117);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (3,'tempor magna quis purus dolor porttitor at', 4735.83, 5,'cursus lectus non tristique malesuada in a  lacus vulputate in lacinia purus aliquam mauris vitae commodo quisque non montes amet nulla dui  faucibus suscipit scelerisque sed iaculis diam lectus dapibus viverra non tempor  est nunc etiam semper sagittis', 2, 725.56, 'tempor quam  pharetra at   tempus purus ipsum sed nascetur nunc parturient tempus vel faucibus', 384, 303);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (4,'nulla tortor tempus ipsum   et elit', 68068.62, 69,'blandit facilisis adipiscing mattis velit integer   vitae  vel tempor viverra  lorem suspendisse gravida viverra at tortor condimentum netus pretium amet orci  tristique aliquet vitae feugiat orci nec aenean arcu  sem id porttitor lectus feugiat', 0, 9473.82, 'ullamcorper velit tristique nunc molestie vel vulputate adipiscing lacus massa leo ac adipiscing', 472, 1045);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (5,'ipsum nullam tellus pretium sit aliquam', 45250.41, 32,'eget cras faucibus  rhoncus adipiscing lorem malesuada faucibus  sit sed lacus tempus nisi  non in venenatis nunc diam congue habitasse habitant morbi lacinia enim facilisis netus adipiscing sed duis mollis  duis cursus eros  ac tempus risus aliquet', 1, 10323.50, 'massa neque accumsan etiam amet mi sagittis augue  lorem arcu enim diam ut  a diam ipsum augue', 80, 1104);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (6,'semper bibendum cursus lobortis feugiat', 54768.92, 48,'id urna consequat nibh pellentesque habitant suspendisse in  consectetur tincidunt  urna tellus magna  lorem faucibus diam erat amet senectus   nullam  nulla tincidunt  nec diam ipsum nisl pharetra orci tempor  risus senectus porttitor  at feugiat ornare', 1, 4181.87, 'donec senectus mauris nunc viverra a volutpat  tellus dolor nulla integer aliquam purus consequat', 715, 570);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (7,'hac at enim hendrerit tortor orci mauris', 29828.87, 35,'velit nec elit consectetur sed  quis ut quis tortor tortor  pellentesque nec ornare mi accumsan tristique faucibus tincidunt non sit mi quisque  nec arcu  varius mus mattis odio et ultrices  sit cras lectus lectus malesuada amet vestibulum mauris feugiat', 2, 4710.07, 'ultricies gravida sit diam ullamcorper  turpis  risus morbi id  et dolor arcu  lectus suspendisse', 721, 599);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (8,'urna   magna nibh sed facilisi viverra nisi', 58229.26, 56,'quis mauris imperdiet nisl tincidunt donec neque sed duis gravida purus rhoncus sit vulputate eu quis hac amet in quam  fusce nec   commodo tortor tellus mauris aliquet turpis diam lacus sem a  in enim eget faucibus et   odio dui mauris  amet suscipit', 2, 12370.37, 'mollis orci habitant sit habitasse at nec sit diam consectetur cras ultrices at iaculis  id', 655, 636);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (9,'pulvinar  pellentesque  senectus imperdiet', 7362.61, 59,'cursus et fermentum magna iaculis tristique elementum elit sed  quisque purus elit nulla luctus proin consectetur in nec ornare est risus massa neque senectus suscipit dignissim in orci cursus erat tellus ipsum labore mauris viverra ut vitae nam', 2, 1434.70, 'orci purus diam quisque dis ullamcorper tristique  lectus ut augue ultrices risus velit  pulvinar', 119, 738);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (10,'adipiscing volutpat dignissim ultrices', 51700.09, 82,'eget pellentesque non vitae  vehicula vitae vitae  tempor at elementum suspendisse molestie amet   velit nascetur vestibulum venenatis sed amet scelerisque ut vitae ac ut ac blandit morbi egestas eget tellus tincidunt  tortor non scelerisque at et dictum', 1, 10609.46, 'nibh arcu congue lacus mi velit interdum pharetra pretium placerat   cras a gravida cursus arcu', 706, 395);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (11,'purus sed mi mattis duis magna sed tempor', 21521.49, 28,'non nullam tortor pretium sapien tempus a et duis non  nisl nec   incididunt tempor cursus viverra sollicitudin enim  vitae faucibus habitant  id  etiam tortor pellentesque vitae odio molestie enim  integer quam  tristique et enim  aliquam consectetur', 2, 6388.39, 'in enim viverra augue senectus egestas lorem pharetra sollicitudin tellus ultrices eget mattis', 174, 592);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (12,'non ut  lectus nisi sit nisl urna hac nunc', 22095.78, 10,'pretium elit  varius quisque sagittis egestas blandit porta bibendum amet risus   aliquam nisi   elementum  scelerisque faucibus eget duis molestie eu proin iaculis cras molestie risus sollicitudin sit  malesuada tempus quis sem potenti amet sed', 2, 4262.88, 'duis hac velit fames amet quam pretium congue elit    nec parturient semper  erat duis aliquam', 366, 1056);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (13,'mauris consectetur  tempor sit gravida', 40279.02, 35,'nunc lorem fames fermentum pretium sit  diam   cursus adipiscing sed at elit viverra  euismod nec diam sit ornare pellentesque vitae  commodo orci eu quis quam nibh congue integer varius  nisi aliquet magnis congue viverra cras iaculis quis do nec  hac', 2, 4914.73, 'quis  velit in sit quis faucibus eu bibendum volutpat sit augue orci fermentum lorem vitae', 278, 683);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (14,'nisi enim sed pellentesque fusce nullam', 4504.68, 42,'a incididunt  sagittis feugiat eiusmod velit ac ipsum nisi mus mattis congue vel congue aenean  eget erat tincidunt viverra quis iaculis diam ipsum sed mattis nisl nulla venenatis proin praesent pharetra ridiculus sit aliquam eu duis amet fermentum et a', 1, 936.32, 'elementum lobortis pretium risus nisi suscipit arcu viverra diam velit  non lectus elementum nibh', 45, 554);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (15,'nulla integer viverra nisl nascetur', 8078.65, 35,'at proin risus id laoreet tempor bibendum  sed venenatis  sed eget vitae eget eu dolor quam commodo  auctor   aliquam  et a nisl morbi aliquet dapibus arcu nec suspendisse nulla in et quam risus viverra purus iaculis integer aliquam sit massa risus nulla', 0, 753.39, 'mauris adipiscing mauris nisl nisi nascetur sit aliquam laoreet morbi tempor vestibulum cursus a', 117, 1139);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (16,'ornare feugiat adipiscing lectus  lacus', 35612.81, 49,'nunc  egestas semper venenatis   ipsum nam mi erat malesuada odio  amet nec vel vel urna diam nisl ultrices nec feugiat nec tortor vel nulla eu adipiscing  vel  lorem in sit vitae ornare pellentesque consequat  etiam tempor orci elit lectus lacus erat', 0, 3855.55, 'nunc sit nisi tellus at curabitur sagittis vitae suspendisse vitae sit   lacus suspendisse vitae', 461, 1075);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (17,'senectus adipiscing non aliquet semper', 50203.95, 77,'adipiscing elit in nec orci nec nulla  consectetur in cursus nisi facilisi  quam iaculis tempor suscipit duis tristique velit diam adipiscing quis purus sapien nisl augue gravida nulla suscipit quis egestas  arcu  neque gravida nunc  vel velit ornare', 0, 5874.94, 'dolor eget   ultricies nam habitant at sem porttitor sit consequat nunc vitae ipsum tortor tempor', 684, 1094);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (18,'suspendisse nascetur tellus proin amet', 24248.30, 97,'montes augue iaculis nec mauris   hac  senectus eget cras  adipiscing vulputate eget nulla massa  nulla sed  eu ut mattis nunc neque elementum at vehicula facilisis  adipiscing pulvinar rhoncus nisl donec sed augue tincidunt mattis enim risus aliquam', 0, 2827.42, 'a consectetur a elit vitae diam risus massa parturient aenean nam mattis velit pellentesque erat', 467, 1075);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (19,'aliquam ipsum ac arcu auctor  semper id', 67243.22, 85,'gravida vulputate lectus lectus ut eu nunc  leo sed amet gravida netus et nec nulla ut amet  leo enim nisl  nisi at quam consectetur ut diam velit  eget mauris lacus aliquam vitae tempor pellentesque dolore nulla nulla mattis nunc elit aliquet arcu', 1, 8012.87, 'tempor mauris donec et interdum amet arcu viverra tincidunt lacus aliquet arcu etiam ultrices', 226, 721);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (20,'mattis eros  quis elit consequat lacus', 28142.11, 89,'blandit nam potenti diam risus condimentum mauris adipiscing sed imperdiet accumsan consectetur lacus  nulla tempus at  euismod volutpat rhoncus facilisi  sodales potenti  sed ridiculus justo  et eu diam rutrum pellentesque augue mi  leo pharetra aliquam', 2, 5084.94, 'faucibus mi lorem tortor donec malesuada sed mauris neque tristique velit vel  pretium vulputate', 280, 945);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (21,'non interdum faucibus  semper turpis', 56026.59, 93,'vulputate risus diam eu sapien sed massa dui dapibus viverra  nunc   magna venenatis  in  consectetur sed ipsum ipsum id aliqua velit ornare amet ut amet vivamus et a et elit diam  sed tortor  condimentum  sed enim id in in tortor  erat tempor proin et', 2, 4321.40, 'odio in mattis non sed tempus consectetur non suscipit ut eget eu facilisis risus elit elit lectus', 389, 438);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (22,'tortor consectetur  tincidunt in sed massa', 13267.90, 83,'potenti suspendisse mus dolor lorem pharetra nisl mauris condimentum dui in erat non id consectetur morbi tristique  nisi gravida et eget vel mauris magna semper leo vulputate nec odio mattis  nam montes nisl amet, eu euismod eros tellus  risus sit  et', 1, 873.04, 'amet aliquam sed  ut ut aenean faucibus mattis  quis ut sagittis augue eu hendrerit quam lacus', 503, 606);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (23,'hendrerit habitasse nunc quam integer', 42048.75, 70,'neque integer eget pretium molestie sit arcu varius cursus volutpat id  nibh quis  suspendisse tortor et ac donec amet ut eget a scelerisque lorem sit elementum mattis  dictum magna nulla non tortor vulputate ullamcorper cursus urna vel blandit orci', 2, 11411.51, 'suscipit tincidunt orci  porttitor eu morbi mauris non nunc tempus tortor cursus venenatis aliquam', 311, 1066);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (24,'sed ut nulla tempus viverra mauris nulla', 58205.45, 45,'egestas congue nunc nulla rutrum quis sed tincidunt nisl pellentesque duis in  id tellus non  elit tellus eu quis consequat  rhoncus sed leo sed proin scelerisque lacus at cursus ultrices nec viverra sed egestas ipsum  mattis bibendum proin vel non', 0, 4533.29, 'molestie sed   nisl lectus consequat cras tortor aliquet non potenti dictum est congue tristique', 575, 255);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (25,'sed aliquam  urna ut tristique consectetur', 20913.23, 63,'dis  aliqua integer  fusce semper urna euismod viverra amet  suspendisse interdum amet at amet  diam integer risus neque senectus  aliquam  felis id non donec sit  eget amet eu nunc volutpat morbi ipsum egestas aenean faucibus bibendum mi cras quis  vel', 1, 3670.73, 'in morbi  senectus at ut nulla  suscipit nulla mattis nunc libero tempus ipsum arcu odio ut nisl', 298, 485);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (26,'ut consectetur volutpat  diam lectus sit in', 44148.77, 36,'molestie nunc elit senectus porttitor mauris aenean  urna diam vitae nulla eget aliquam mi consectetur elementum morbi malesuada duis purus sit et viverra dictum pellentesque mauris egestas quis nam dui tempus et tellus vulputate a semper bibendum', 0, 12532.31, 'ac  diam faucibus non  faucibus  aliquet amet fermentum viverra at consectetur  lectus quam massa', 609, 103);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (27,'fames  eu  turpis vel habitant condimentum', 4260.57, 69,'blandit in proin consequat ornare  justo  suspendisse a hendrerit  quis pretium sagittis elit nisi et   amet pellentesque rhoncus tempus at aliquam nulla ultrices amet amet justo nam  adipiscing  porttitor ullamcorper pellentesque nulla risus aliquam', 1, 878.49, 'ipsum venenatis at purus  nisi diam  scelerisque sit tristique  orci lacinia adipiscing pretium', 447, 998);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (28,'amet dictum fermentum est elit elit urna', 53526.50, 20,'felis varius nisl id  ipsum in libero lectus commodo nascetur et vel  tristique elementum suspendisse mi nec amet quis  amet consectetur dignissim ultricies tristique lectus tortor  maecenas  eu varius tortor ultrices duis  tempus sed  aliquet porta diam', 0, 13116.30, 'et diam   pretium  nullam  et ut  consectetur volutpat cras   sit auctor pretium est tincidunt', 313, 531);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (29,'in  justo dictum  feugiat vitae parturient', 22291.54, 31,'vitae quis sit non elit habitant tellus lectus nisl amet  dis urna libero nunc  pellentesque a nam suscipit enim a magnis sit  enim molestie  porta nibh suspendisse nulla in pretium pulvinar tellus cras molestie ridiculus laoreet nunc nam ut viverra', 0, 4597.86, 'risus nascetur ut viverra pretium purus nascetur  id rhoncus mi fermentum velit   augue augue nisl', 173, 635);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (30,'blandit  nec massa fames egestas etiam', 7970.83, 72,'pellentesque lectus etiam neque mauris elementum faucibus aliquam mollis bibendum malesuada nunc ut eget a orci ultricies nisl vitae id  lectus proin amet dignissim  ac porta hendrerit facilisis vel diam consequat massa proin habitasse in sodales', 1, 2361.22, 'vitae at euismod eget risus commodo  eget non auctor justo  netus mi purus id  ipsum lacus odio', 477, 507);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (31,'nunc ut  vel lacus vitae mattis dictum diam', 14403.12, 20,'mattis  ac at integer tempus mus sem purus ultricies nunc netus egestas sit augue nulla aliquam  sed cras nullam pulvinar etiam mattis fames sed sed senectus ultrices ipsum ut justo  nec faucibus  a faucibus amet et arcu  rutrum nunc cursus tempor amet', 0, 3904.34, 'lorem ornare ipsum duis nulla viverra integer duis massa morbi id ac molestie at congue duis at', 465, 575);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (32,'suspendisse rhoncus  interdum amet non', 30995.09, 8,'vitae nunc condimentum tortor arcu  purus ipsum nascetur tempor ut donec ultricies non pharetra condimentum viverra ornare mattis est velit  imperdiet vitae nam egestas gravida facilisis purus nec eget odio feugiat tristique tempor viverra  pretium enim', 2, 9034.62, 'viverra ullamcorper orci eget vehicula egestas et  condimentum vulputate tincidunt vel tempus', 541, 759);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (33,'aliquet lectus eu fusce quisque amet nec', 23352.38, 95,'eu eu nisl aliquet facilisis risus ultrices dapibus vulputate lectus amet magna    vel  suspendisse quam non massa sit purus  enim  in duis non lectus ornare eu aenean mauris vitae  amet  tempus egestas nunc vestibulum in netus fermentum risus', 2, 4040.86, 'enim felis id faucibus vel sit  mauris nibh  sed vulputate neque sed facilisis adipiscing erat sed', 673, 507);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (34,'proin elementum eget venenatis varius', 53607.32, 26,'commodo massa adipiscing tempor elementum dictumst sed platea diam at a aliquam lectus id enim mus sagittis ut amet purus vitae augue euismod ipsum amet  orci sit tempor massa in nec molestie lectus porttitor  tempor velit euismod  orci  pulvinar nisl', 1, 15083.97, 'pellentesque et pellentesque lorem risus  quisque tellus porta at  egestas  sed  elit massa', 423, 836);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (35,'est nibh orci ut vulputate ut in tempus', 51049.78, 15,'diam non elementum faucibus purus lectus morbi tincidunt vel  id et enim consequat ornare semper urna eget  ut elit  ut vitae faucibus tellus et quis mauris nisl consectetur feugiat lectus tortor vel quisque ac ullamcorper sit ridiculus fusce aliquam', 2, 7914.65, 'nunc amet arcu sed leo consectetur viverra porttitor massa sed  est ac ultricies condimentum a', 632, 950);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (36,'nisl id sit aliquet pretium sed  porttitor', 48150.12, 73,'nulla eget  commodo  sit facilisi ac consectetur elit libero justo ac malesuada mauris velit lectus vulputate lacinia auctor elit  euismod  quis sagittis  consequat donec in id tempus tellus ipsum hac sagittis nibh suspendisse volutpat habitant quam quis', 1, 2829.67, 'varius erat parturient phasellus magna in sit diam pellentesque tortor nam  arcu adipiscing', 375, 335);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (37,'sed risus diam neque ut sagittis integer', 25547.88, 2,'nulla parturient pharetra mollis at mattis  non vehicula fermentum libero iaculis eget non augue tortor ac commodo nibh massa non quam viverra consectetur habitant in sem eget tellus sagittis gravida faucibus pretium et sit enim et et augue lectus', 0, 2898.97, 'nisl dictum vehicula  id et ac eget non hac feugiat accumsan vestibulum nulla   morbi nibh', 33, 1002);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (38,'netus tristique diam viverra sed at dolor', 60514.02, 12,'risus sit adipiscing id ornare sem pellentesque diam ut aliquam amet justo fermentum nibh libero a leo tortor quam ut ultrices erat suspendisse ullamcorper  et habitasse auctor nibh risus nec et  cras augue condimentum gravida ipsum congue  egestas', 2, 7876.68, 'amet vel non urna consectetur velit pellentesque nisi tellus elit nunc  diam ac morbi cursus dui', 471, 1055);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (39,'pharetra purus pretium scelerisque pulvinar', 55729.27, 38,'gravida id lectus quisque  morbi semper facilisis tristique tellus tortor  condimentum nunc eget aliquet quis aliquam nec molestie suscipit mauris viverra amet tincidunt eget vitae amet pharetra auctor vivamus integer dolor nibh at scelerisque rhoncus', 2, 16372.07, 'cursus tellus ipsum nibh est in eiusmod eget congue convallis  egestas nulla congue netus commodo', 206, 1067);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (40,'mauris sit  enim et tellus   at quam', 57533.00, 79,'rutrum donec sit amet   amet ultrices aenean tempus tincidunt eget vestibulum suspendisse vulputate faucibus cras erat nullam fames cursus venenatis  habitant amet massa in pretium enim nunc at libero  mattis nascetur nisl nisi cursus dolor a aliquam', 0, 6958.00, 'lobortis facilisis eu vitae nibh accumsan nunc nibh vitae amet pharetra ut  hac sit sed tincidunt', 83, 855);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (41,'at  dolor at elementum sit sit nisl', 228.76, 58,'venenatis at vitae sem at in etiam elementum fames sit tellus velit ac est duis magna cursus nam aliquam  quis vulputate tristique vivamus  urna fermentum ipsum tristique tortor cras sed massa adipiscing vitae  sollicitudin   tempor duis cursus nibh', 2, 37.97, 'cursus  nisl sapien elementum tellus duis eget tempor sollicitudin mi volutpat elit phasellus  nec', 170, 937);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (42,'et ac adipiscing  aenean  porttitor sed eu', 39502.88, 65,'eu at neque  sed diam ultrices habitasse et viverra amet facilisis justo morbi eleifend et  duis libero amet adipiscing adipiscing odio tristique semper nec at  nibh nec integer nec lacus varius feugiat ut risus hendrerit tristique nunc mollis amet  id', 0, 8089.52, 'nisl nam quis maecenas integer pulvinar risus at nibh semper nunc urna accumsan sit porttitor ut', 546, 794);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (43,'pellentesque egestas ultricies odio', 32997.85, 76,'tincidunt magna consectetur dolor dictum vitae nisl proin rhoncus non sit donec dapibus nascetur sed gravida tristique  arcu non  tortor sit dui sed  lectus varius vehicula  sed  velit velit consectetur amet mattis scelerisque  vestibulum ipsum purus', 0, 5880.69, 'nam mi volutpat sit leo velit blandit pellentesque non labore aliquam sapien facilisis amet sit mi', 308, 550);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (44,'morbi et proin ipsum velit nam et vivamus', 65458.01, 98,'urna massa nulla eu aliquam at  mauris nam sed mi erat viverra at et  pretium erat pellentesque netus  quam nunc leo in  gravida donec condimentum mi cras mauris vulputate pellentesque lacus elementum netus feugiat  nulla  eu nibh sit mauris facilisi', 1, 6408.73, 'suspendisse elit adipiscing pretium  tempor in arcu  vitae risus  risus tellus elit a sed at nulla', 402, 736);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (45,'pulvinar amet eget ut velit non amet', 52989.01, 90,'egestas mus at sed vel orci augue consectetur quam  purus  vitae mauris egestas  suspendisse morbi iaculis pellentesque ac elementum nulla nunc malesuada suspendisse diam id bibendum eget vitae fusce volutpat faucibus nunc eget purus sed duis  sed morbi', 2, 7225.70, 'enim accumsan  amet dolor suspendisse erat consequat purus in sagittis condimentum ridiculus massa', 604, 777);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (46,'quis amet velit ultricies lacus tristique', 46.42, 74,'eget integer habitant sed erat sed amet risus  velit tortor  venenatis adipiscing labore a in feugiat diam et varius faucibus  arcu  nisi  urna adipiscing rhoncus commodo odio nisl vivamus amet ut quis ridiculus ut non aliquet eget sagittis  convallis', 0, 11.87, 'congue iaculis sit incididunt habitasse  vitae eget consequat sollicitudin diam a  tristique mus', 55, 64);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (47,'viverra urna molestie cras   consequat amet', 47552.55, 65,'quis proin velit  donec urna interdum risus aliquet habitant enim mus tortor eget ut  condimentum cursus vestibulum sagittis mattis suspendisse consequat sed amet blandit tempus dictum sit odio a tempus molestie pellentesque  adipiscing sed risus', 1, 9413.59, 'nec ac pulvinar egestas orci velit nunc ornare ultricies scelerisque eget faucibus justo sed enim', 693, 929);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (48,'justo et mauris netus adipiscing libero a', 1191.57, 65,'sapien quis sed nulla fusce sit mauris aliquet ac arcu  interdum tortor incididunt pellentesque et vestibulum  bibendum donec massa vitae nisi consequat   maecenas pellentesque feugiat sed eu adipiscing hac faucibus lectus duis  odio dictum    nulla', 2, 305.01, 'netus egestas volutpat rutrum elit lectus id ipsum integer eget fusce ultrices habitasse odio', 412, 611);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (49,'faucibus blandit quisque rhoncus  platea', 37303.66, 88,'nunc neque  consequat montes suspendisse mattis eget duis varius luctus parturient et nulla risus adipiscing cursus enim hac ullamcorper varius semper mauris proin facilisis dolor amet ridiculus auctor nibh massa lectus leo sem   in elementum sed', 2, 4814.69, 'volutpat et phasellus a dictum imperdiet risus enim leo a mauris arcu venenatis nulla amet', 16, 973);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (50,'a  ullamcorper do  enim ipsum ipsum', 64534.83, 46,'risus sollicitudin tortor lorem massa urna dictum risus suspendisse enim donec congue dui consequat ac ultricies vitae volutpat eu etiam nascetur iaculis pretium ut in a mattis  massa augue gravida adipiscing ornare odio  aliquam tristique aliquet sit', 1, 10454.90, 'massa pretium sed in mi aliquam mauris sem   dictum morbi nibh ullamcorper non nibh leo orci', 429, 1039);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (51,'faucibus cras nisi consequat varius', 15839.85, 99,'risus volutpat id urna at a ac suspendisse nulla massa  donec amet suscipit egestas ut   purus elit mauris massa venenatis nascetur faucibus quam etiam duis ipsum arcu elit vestibulum vel condimentum  ultricies at lectus risus  gravida eget id habitant', 2, 2030.49, 'bibendum   amet dolor gravida pellentesque aliquam sit vulputate volutpat dapibus venenatis', 687, 86);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (52,'purus at consequat blandit augue risus', 7053.48, 75,'habitasse  diam justo   tempor scelerisque quis   et massa id ipsum  pulvinar id pharetra  pellentesque parturient pellentesque id sed dictum accumsan cras sit mauris adipiscing donec justo orci  dui  nisi hendrerit ultrices massa a  molestie  ut ut in', 2, 1489.21, 'id eget viverra  sit est velit nec arcu ullamcorper nibh eget vulputate  integer quis varius', 213, 21);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (53,'vel sit duis a aliquet habitasse id', 43783.53, 32,'sagittis ultricies mattis nulla  amet dolor vitae ac    cursus vivamus semper  bibendum interdum viverra  faucibus suspendisse  enim justo amet nunc ornare diam  nibh pretium dolor senectus lectus vulputate malesuada netus   malesuada mus hac elit', 0, 6270.64, 'aliquam at sed eget pellentesque turpis diam purus tristique  risus ut eget  pulvinar sed', 681, 724);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (54,'aliquam dapibus amet ac fusce ut  viverra', 54662.74, 87,'sem tincidunt mauris  condimentum  erat in aliquet eget sagittis  amet id augue adipiscing ut id tincidunt  pharetra cras tellus sem faucibus risus quis mi dictum  interdum aenean  faucibus montes morbi tortor tempor id neque eu adipiscing  hac   quam', 1, 14612.73, 'non  lectus  eget nibh  lectus  id potenti  a hac vel tristique     dolor diam massa habitasse et', 59, 191);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (55,'nec  turpis a dolore et ipsum donec    ut', 21745.10, 29,'urna arcu  quis porttitor ipsum quam  risus  nunc ullamcorper sit risus semper  sed diam  iaculis ac senectus risus volutpat mauris ut mattis neque suscipit bibendum aliquam ipsum viverra mi ultricies orci velit faucibus  egestas pulvinar tempor lacus', 0, 1125.42, 'et amet  volutpat a velit auctor vitae sit arcu in enim pulvinar non nullam et eget adipiscing', 135, 1048);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (56,'at iaculis condimentum porttitor proin', 34731.21, 72,'id sed amet suspendisse vitae a  euismod ac  pharetra porta at vestibulum vitae scelerisque elit,  velit molestie ornare mattis velit in imperdiet enim netus urna fermentum proin non faucibus ut   in purus vitae quisque  odio sapien  turpis at in erat', 1, 10277.64, 'consectetur aliquam nunc dignissim amet condimentum nec vel dolor  adipiscing id purus urna hac', 16, 350);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (57,'neque elit, etiam netus tristique sed', 13245.81, 32,'euismod  morbi  a luctus dolor senectus nibh sit donec vel odio commodo risus nulla sed malesuada velit tempus sit sed gravida arcu ipsum erat  aliquet sit   viverra mauris nisl  tempor suspendisse varius nec aenean cursus semper augue nascetur libero', 1, 2922.35, 'in   ullamcorper mauris sapien volutpat  id  amet mauris augue aliquam ultrices consequat vitae ut', 183, 534);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (58,'eget  volutpat lectus condimentum mattis', 43156.47, 35,'mollis eget in laoreet  ac aliquam sit enim quis dolor  euismod ac mi amet aliquam in  consequat justo nisl ornare arcu arcu quis aliquam tellus amet leo nulla bibendum  velit nunc quisque  ultricies at mauris at etiam tellus velit turpis eu quis id', 0, 6987.65, 'eget  amet laoreet mattis orci nisi do lectus  augue vitae quis egestas quam sed mollis venenatis', 141, 118);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (59,'mauris massa fusce senectus  vulputate', 54624.43, 37,'lacus consectetur lacinia  consequat scelerisque dui lacus ac  mauris suspendisse tincidunt proin urna sed  et non orci id morbi lacinia pharetra a arcu quam eiusmod malesuada neque ut gravida auctor sagittis habitasse velit ac  cursus eget risus', 1, 8751.44, 'malesuada elit amet in consequat egestas dignissim neque varius  id rhoncus ac at eget augue', 75, 26);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (60,'vel non  et arcu lorem  senectus hac ornare', 66055.43, 8,'amet integer suspendisse iaculis lectus orci euismod lectus  turpis feugiat massa quam sapien amet, facilisi non neque purus amet   eu magna sed sapien volutpat  feugiat potenti auctor quam posuere   id vulputate ut nibh lobortis nascetur mus do egestas', 2, 3496.09, 'nulla vulputate et  suspendisse urna sit  diam do  mattis id quam a nisi volutpat vitae purus', 388, 33);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (61,'etiam nulla tempus enim  viverra', 22551.87, 38,'varius nascetur mauris in at augue enim blandit faucibus non aenean a a  auctor ornare consequat  volutpat tellus  et congue congue fermentum nisl   orci dui nibh  varius amet gravida morbi diam faucibus lacus pretium ipsum mattis ullamcorper nibh', 0, 5892.98, 'sit velit  nisl parturient varius  massa lectus viverra aliqua tortor massa at amet at justo purus', 100, 593);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (62,'semper  tellus mattis velit fusce nisl at', 21934.02, 2,'facilisis ullamcorper purus imperdiet purus  purus malesuada ut vulputate orci aliquam  malesuada tellus condimentum suscipit  mauris et massa nulla cras  est velit mi dictum aenean et amet sagittis aliquam massa amet fusce sed varius sapien enim', 2, 1898.64, 'dolor  vitae in quam bibendum vulputate nullam malesuada vitae curabitur  consectetur feugiat', 268, 466);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (63,'curabitur viverra etiam et amet ut neque', 55901.98, 74,'at at mauris ultrices egestas elit adipiscing  nulla sit ultrices purus amet integer blandit egestas elit vitae massa vel fusce ultricies in  laoreet leo urna gravida sodales mattis mauris ipsum ac nisi dictum nascetur urna at consectetur nibh vitae', 2, 9777.17, 'at tincidunt tortor ridiculus aenean  donec in nisl  magna risus mi curabitur condimentum nibh non', 187, 164);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (64,'elementum sit amet odio amet adipiscing', 62299.21, 61,'at sit tortor id feugiat  nam turpis amet nec at tortor amet congue massa    risus in morbi suspendisse vitae sed  arcu nec consectetur enim elit nunc vulputate pretium amet vel nec arcu ut eget risus eu in sit diam  diam gravida consectetur in  lacus', 1, 17648.87, 'aliquet montes ipsum mi non pretium  semper aenean varius mauris augue orci  urna  nulla lectus', 356, 1084);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (65,'lacus tristique turpis a tincidunt et', 8404.67, 53,'eget eget adipiscing  amet  enim  nisl imperdiet amet amet risus iaculis lorem varius  viverra vulputate lorem integer at viverra lectus facilisis sit at dapibus potenti massa dictum morbi eu iaculis et mollis sed duis non tristique et amet tincidunt', 2, 2363.50, 'potenti eget sit viverra leo  justo integer faucibus pretium ac ridiculus pulvinar massa senectus', 4, 806);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (66,'risus magna nisl  et elit volutpat ut', 12063.64, 97,'ornare posuere dapibus feugiat maecenas ornare pellentesque ut cursus  sed mauris a amet urna mauris lectus tincidunt  et   cursus donec sem pulvinar proin et sit  dui  vel  pellentesque consectetur cursus sit at diam purus  sed vel vitae amet labore in', 0, 2957.67, 'velit sed et nibh sollicitudin sit nibh  nisl consectetur  at  consectetur velit  fermentum cursus', 36, 1127);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (67,'ac nisi pulvinar adipiscing dignissim amet', 61646.76, 74,'do non pharetra congue hendrerit vitae lorem amet tellus nunc mauris integer dictum diam tristique  in incididunt morbi ut blandit gravida sit venenatis  arcu bibendum diam adipiscing et vulputate purus pellentesque amet, in  hac sem  egestas quisque', 0, 7308.43, 'consectetur viverra et tortor  tortor nam turpis luctus proin sit lobortis duis urna commodo nulla', 288, 454);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (68,'in viverra pellentesque egestas', 986.48, 66,'consectetur ipsum venenatis nunc convallis risus ut lectus non lorem nunc nisl  accumsan varius in  dolor turpis suspendisse vitae  enim a ut aliquet nunc   nec sed quam condimentum sapien condimentum  volutpat maecenas massa tempor nunc pretium ultrices', 0, 251.43, 'morbi leo  facilisi amet ridiculus non morbi amet et venenatis tortor  quis massa a vitae in vel', 497, 909);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (69,'adipiscing purus faucibus do non velit', 66965.55, 55,'nisl nam bibendum nec volutpat convallis vitae    fermentum in nibh nullam augue laoreet vel morbi at mattis  ac imperdiet mauris et nascetur  vel habitasse at odio tortor leo in lacus massa eu aliquam pharetra quam gravida sed sit vestibulum  quam ut', 1, 6958.60, 'odio eget augue consequat arcu in scelerisque risus  neque tortor mi rutrum ultrices morbi ipsum', 135, 378);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (70,'proin consectetur vitae donec lorem  quam', 58218.73, 89,'vehicula auctor placerat vulputate  risus neque  ut dapibus tellus dignissim aliquam  adipiscing malesuada pellentesque risus massa risus viverra lacus mauris ac  vulputate morbi integer purus elementum   tristique neque mus congue quam duis morbi lacus', 1, 4293.79, 'magna nec gravida sit molestie dapibus consectetur urna consectetur lorem neque felis diam augue', 681, 164);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (71,'id  dictum  nulla tristique sit ut id purus', 38440.55, 14,'amet eu iaculis netus facilisi diam urna vel porttitor mi diam morbi ut in neque dolor incididunt sed ac  quisque et commodo condimentum  hendrerit praesent in vulputate enim nunc mauris lectus ultrices augue faucibus facilisi   diam eget adipiscing', 1, 10962.63, 'massa diam aliquet non molestie diam proin dolor adipiscing diam elit  amet tellus accumsan  ac', 473, 1030);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (72,'sagittis amet  sit  morbi varius donec', 20108.46, 18,'dapibus integer  imperdiet   arcu  sollicitudin tincidunt leo est viverra rhoncus est netus pharetra nisl adipiscing vestibulum dictum nunc gravida neque velit mattis pellentesque donec dolor volutpat dictum interdum mattis sit  curabitur sapien', 1, 5545.51, 'eget  purus ullamcorper lorem ipsum suscipit dui iaculis  proin cursus enim risus sapien velit', 437, 134);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (73,'adipiscing vel cursus auctor scelerisque', 63326.35, 60,'vehicula sit faucibus  sagittis risus urna ut ac elementum molestie augue et tellus integer tempor odio quisque enim magnis  vestibulum   aliquam accumsan sit quisque adipiscing blandit tempor adipiscing dolor nisl suscipit   eget   ut nisl augue donec', 0, 13444.42, 'tempus  aliqua   libero vulputate ut   at montes sed lorem nunc vulputate ullamcorper luctus amet,', 501, 613);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (74,'laoreet pretium quam ut iaculis tellus', 17488.56, 4,'ridiculus vitae sit ornare tincidunt iaculis elit molestie augue amet luctus tellus amet nibh condimentum ut sit ut sit  suscipit habitant nunc nisi tellus neque dignissim quam vulputate pharetra hac ultrices  eu sit in diam in morbi urna eget tempus  a', 1, 2856.34, 'malesuada consectetur dignissim  venenatis sed lectus ultrices pellentesque maecenas  viverra', 372, 444);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (75,'nisl nisi euismod mauris hac viverra est', 43371.71, 64,'lacus  tellus morbi amet cursus eget lectus in dignissim netus tempus  duis  eget vestibulum et sit erat mauris dictum nullam    sed mattis sed neque consectetur porta sagittis fusce ultrices mi laoreet ullamcorper faucibus tellus erat  non eget in', 1, 6581.35, 'iaculis vitae faucibus placerat tincidunt nullam nibh sit  tortor pulvinar nibh tincidunt eget', 480, 873);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (76,'aliquam mauris viverra leo pretium velit', 8878.85, 35,'diam tellus tellus libero arcu non congue sagittis id sit nisl dictum nunc urna vitae facilisi pretium nam at egestas   non viverra rhoncus non leo  aliquam   lacus  laoreet aliquam tempus consectetur mauris  amet at laoreet lobortis purus erat nisl', 1, 1055.01, 'aliquet sed aliquam donec sagittis et aenean  adipiscing velit urna ipsum  nascetur nulla ut', 249, 458);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (77,'libero enim id sapien elit porttitor nulla', 8283.52, 83,'amet nullam suscipit vitae integer   nisl  at non facilisi  ut velit  a facilisis  nunc donec proin consequat mauris egestas et  sed vehicula viverra labore odio eu augue amet  nam vitae sapien ridiculus  ut quis placerat urna diam purus feugiat', 0, 1893.96, 'risus imperdiet interdum et semper nascetur lacinia purus diam massa proin donec est ultricies ac', 326, 648);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (78,'semper aenean arcu pulvinar  malesuada', 25305.06, 33,'elementum sed  convallis habitasse pharetra tempor sit  eget nulla  consectetur  pretium risus egestas amet amet, vel volutpat risus sit  diam purus amet nisl at pellentesque   vitae  purus gravida neque condimentum a iaculis  odio cursus odio sed a', 0, 2626.16, 'urna nisl quis dictum ultricies nulla urna amet tincidunt pellentesque cursus interdum praesent', 403, 69);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (79,'eget amet sapien pellentesque imperdiet', 31660.75, 1,'lectus dictum odio risus  amet viverra est proin sit donec consectetur sed sit sapien eget amet pellentesque duis erat sit viverra egestas velit mi fusce in consequat varius amet quis ac  at convallis  fusce at  euismod risus rhoncus habitasse sed', 2, 7630.93, 'sed   sollicitudin lectus tortor enim mi diam et tellus lacus egestas ut tortor sed vulputate vel', 390, 291);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (80,'malesuada montes etiam a aliquet tortor sed', 13874.55, 46,'nisl a commodo mi sed urna dolor ultrices dictumst arcu in amet  fermentum non dolor gravida ipsum   cursus sit platea etiam ac  pretium massa ipsum interdum tellus neque vulputate molestie egestas adipiscing nibh pellentesque vitae nam id potenti', 0, 1091.46, 'vitae velit tellus interdum in viverra morbi velit id condimentum neque sed in arcu et quisque', 114, 331);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (81,'sem  nisi  id aenean ultricies neque purus', 58315.29, 22,'pellentesque aenean sed orci tellus et condimentum  elit nulla porta turpis ullamcorper sed mattis magna a scelerisque quis sem   dictumst cursus mauris lacus sagittis ut in vivamus eget pellentesque mauris in ultrices faucibus vitae convallis adipiscing', 0, 11158.46, 'feugiat vitae sit netus nascetur cras amet pharetra eu laoreet neque et nullam hendrerit risus', 668, 528);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (82,'erat nulla  eu adipiscing et ut dapibus', 53373.92, 70,'volutpat donec lacus urna amet ornare adipiscing nec tortor nisl  nisi interdum amet orci nibh ridiculus pharetra diam congue risus dictum mattis pretium habitasse  a vitae auctor neque aliquet  vel est eget gravida et tellus dolor consectetur bibendum', 1, 3344.06, 'venenatis ipsum aliquam  aliquam in quis quisque consectetur  auctor blandit pellentesque neque', 577, 823);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (83,'at mus eget diam vitae viverra sapien nunc', 64874.16, 82,'interdum lacus molestie congue consectetur id condimentum consectetur vitae phasellus orci non cursus consectetur morbi elit aliquet varius  id elit, elementum eget proin blandit tempus senectus sapien iaculis netus consequat at facilisi  nec vestibulum', 1, 13715.87, 'vel tellus  aliquet id sapien eu nisl cursus  eget aenean tincidunt sagittis pellentesque  lectus', 327, 587);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (84,'urna ultrices aenean et elementum cras quam', 19370.83, 20,'eu duis nulla cras consectetur malesuada   sit massa  interdum  est interdum  sit molestie sit enim mattis risus massa nisl lobortis ac eu at consequat at massa neque ac ullamcorper et amet tellus in arcu vulputate massa  vitae a orci suspendisse risus', 1, 3440.89, 'pellentesque odio lectus id ultricies netus parturient malesuada risus pulvinar dictum et diam', 602, 613);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (85,'tempor donec semper tempor iaculis', 35989.09, 16,'sed mattis accumsan turpis  libero eu  ac orci duis amet sit hendrerit  lectus amet arcu in in fames gravida  id proin congue quam lectus  ut ut tincidunt at neque sagittis gravida malesuada senectus vitae  malesuada pulvinar consectetur tristique diam', 1, 3702.70, 'amet quis mi dolor eu adipiscing pretium incididunt venenatis mauris vitae tortor lacinia nisl', 461, 857);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (86,'tempor consectetur lacinia enim enim dis', 10734.93, 11,'quis ultricies adipiscing senectus congue vitae volutpat  in dapibus  condimentum tellus eget  non interdum vulputate in nulla feugiat ac curabitur blandit nulla consectetur non at platea netus nunc urna velit vitae  commodo arcu turpis amet amet semper', 0, 1842.64, 'vulputate amet nunc sed urna  mi malesuada eget ac risus felis  suscipit ut cras  duis cursus', 91, 459);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (87,'vestibulum adipiscing et vel sed  a', 50038.23, 87,'faucibus ornare lectus fermentum  lectus  massa   aliquet urna cursus molestie ut arcu morbi  tristique felis  nullam nibh integer gravida  sit amet pretium imperdiet fermentum ac consectetur tristique  id condimentum id praesent augue platea aliquam', 1, 8455.05, 'sit diam pretium risus leo diam fermentum viverra do netus orci dolor risus interdum  malesuada', 282, 397);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (88,'amet fusce cursus urna odio velit  ipsum', 61133.93, 26,'faucibus enim   mauris pretium consequat non duis consequat nulla porttitor odio interdum ut ut tortor hendrerit  sagittis elit commodo enim mi feugiat vestibulum netus mi nisl varius amet  at leo malesuada fermentum dolor convallis sit eu ullamcorper', 1, 8787.17, 'pretium massa potenti gravida amet  at nunc ullamcorper donec eu mauris cras quis aliquet placerat', 420, 487);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (89,'viverra commodo vitae quam amet vestibulum', 20604.11, 80,'consectetur consectetur tempor cursus  suscipit sem sit nulla dui  nulla arcu varius duis massa  ut  dolor suspendisse nec ornare cursus non  sit egestas at diam lacus sit vitae suspendisse  fusce blandit tincidunt maecenas in sem etiam morbi nec ut', 0, 2818.75, 'morbi egestas mollis aliquam quis etiam aliquam  turpis  mi ullamcorper pellentesque vel', 454, 245);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (90,'euismod ultricies feugiat  tempus lectus', 33420.92, 90,'et  at purus nisl morbi vitae vel erat dui massa  a non suspendisse quis  suscipit  condimentum faucibus vulputate nunc  dictum   placerat tortor sapien vitae est elit in enim  odio est sagittis tempor lobortis  a mauris nibh lobortis at adipiscing', 0, 6128.12, 'eiusmod ut augue amet  nec mollis mattis euismod   maecenas  pellentesque odio  varius nisi mattis', 695, 801);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (91,'amet, eu  nullam sit sed turpis sem  tempor', 36328.91, 11,'hendrerit  cursus consectetur justo tellus faucibus amet fames ut  tempus aliquet porttitor nec  consectetur aliquam massa porta et vulputate ut  morbi hendrerit consectetur netus augue adipiscing   ut  neque  orci in nam augue sit montes lectus faucibus', 0, 6419.86, 'tincidunt massa sed diam in dolor iaculis  massa duis sed mauris orci est  sed in tincidunt', 389, 1115);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (92,'aenean ultricies vitae pellentesque varius', 3996.72, 10,'purus massa varius nibh nibh ipsum a nibh  aenean amet tellus risus habitasse ipsum ut tempor faucibus erat aliquam mauris tellus lectus  augue netus interdum volutpat eu orci tellus vulputate massa  potenti interdum proin commodo  nulla viverra', 2, 1147.63, 'ornare mi odio amet aenean convallis blandit turpis egestas ac nisl amet semper aliqua volutpat', 639, 372);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (93,'neque  non senectus sapien  diam  ut risus', 34919.70, 27,'commodo euismod suspendisse quam nunc   mauris urna  eu blandit nibh nisl pretium sed  nunc pellentesque urna aenean erat aliquet fames commodo laoreet risus  eu   dapibus diam  nibh gravida porttitor aenean mattis eget porttitor viverra pretium urna', 0, 2828.16, 'neque sit mauris orci mauris amet  et  rutrum fermentum  porttitor suspendisse ac urna vestibulum', 449, 717);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (94,'interdum  tempor et hac sed et vestibulum', 24740.10, 29,'tellus viverra purus augue scelerisque diam    dictum euismod iaculis et orci aliqua eget quam integer nulla elementum  enim sed elementum fermentum tempor  amet nisi tempor et consectetur risus  mollis consectetur quisque   cursus amet sed tortor', 2, 6726.63, 'sit mattis molestie in faucibus proin non mauris congue urna vestibulum sit mauris  a consectetur', 544, 439);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (95,'sagittis amet ut  nam feugiat amet  lacinia', 26130.94, 4,'eget viverra augue risus quis sit gravida nunc lobortis fusce rhoncus  venenatis turpis amet amet magna  etiam et imperdiet velit dolor suscipit  viverra risus sit at  aliquam  adipiscing eu  amet duis vel  mus egestas ullamcorper ac ut potenti morbi', 0, 6106.19, 'vitae nascetur amet facilisi non sit in eget non  arcu  nulla suscipit  amet ut  sed aliquam', 220, 485);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (96,'semper urna purus gravida    dignissim', 31848.15, 6,'habitasse ut  tellus morbi adipiscing integer  velit ornare  tristique  rhoncus  a est viverra mi sit lectus  porta odio amet risus orci laoreet tempus viverra risus tellus est id pharetra tortor erat sed fermentum  neque ultrices neque  ut nunc risus', 1, 2093.61, 'lorem nullam  leo feugiat commodo habitasse mattis tempor urna sed fusce nam odio velit ultricies', 123, 942);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (97,'eu ut nullam eu  at dolor imperdiet', 32613.97, 81,'integer at nisl condimentum mus vel  bibendum mus amet  netus purus ornare at est vel luctus viverra consectetur aenean  faucibus quis ut viverra urna leo iaculis consectetur semper faucibus nunc vestibulum augue nec neque nulla tellus est aliquam', 0, 5193.46, 'vel mi tincidunt nunc hac vitae enim scelerisque in vestibulum massa venenatis porta ipsum in', 10, 184);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (98,'vel nulla et etiam tempor tellus nunc', 39340.63, 94,'tellus ut  amet proin tristique ipsum lectus pretium  quam pulvinar dictum  vel feugiat massa leo  sit duis  viverra donec porta neque parturient ullamcorper elementum nam sit erat  nascetur egestas dapibus gravida nisl tristique quis sed suspendisse', 2, 7426.72, 'a elit varius aliquam in morbi lacinia nunc cursus sagittis sed tincidunt suspendisse urna vitae', 580, 837);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (99,'lorem nunc lacus laoreet in pellentesque', 63368.39, 94,'congue varius adipiscing vulputate nunc etiam a amet cursus   quis sit augue dui vehicula tincidunt eu amet  suspendisse  diam amet mattis ultrices ipsum odio et  odio ut ipsum ac rhoncus id nibh ornare viverra morbi netus sagittis   porttitor mi fusce', 1, 13270.97, 'pretium purus mi sit eget elementum arcu vitae  turpis scelerisque  amet ut labore varius  aliquet', 699, 783);
INSERT INTO produtos (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)VALUES (100,'ultrices proin vitae duis non placerat', 26007.66, 26,'quam interdum suspendisse tellus suscipit viverra in lacus ultrices quis augue nunc tincidunt viverra  fusce et tristique lectus aenean in at urna  amet nulla sed  bibendum  gravida suscipit tempus   donec nibh consectetur eget aliquet  massa velit morbi', 0, 5986.73, 'id vitae  consectetur odio tincidunt tortor    dictumst  rhoncus at netus ut  ipsum mi quisque', 715, 716);
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (1,'mattis molestie malesuada  elit elit eget tellus iaculis morbi gravida orci amet quam suscipit felis luctus tempor pretium odio lectus ullamcorper dignissim massa mauris eiusmod imperdiet sed', '2006-11-17', '2006-11-31');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (2,'integer mauris non augue sit pellentesque viverra dolor id dignissim velit', '2015-1-10', '2015-1-21');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (3,'vitae elit viverra eu non diam enim blandit mattis in sed gravida  risus enim urna ornare mi in malesuada ut sed tempor risus quam vehicula a tempus nascetur semper malesuada in aliquam nam', '2004-9-29', '2004-10-30');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (4,'faucibus laoreet velit aliquam risus vestibulum sed quam pretium sit scelerisque nec faucibus nibh pharetra interdum vulputate  purus varius in eget sit urna in diam sapien duis', '2010-1-11', '2010-1-21');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (5,'viverra magna venenatis  sit   volutpat arcu fusce non', '2000-11-9', '2000-11-23');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (6,'hac pellentesque tortor at morbi quam et  nam urna venenatis', '2000-10-1', '2000-10-5');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (7,'neque  odio lectus   enim lorem vulputate mi tincidunt nunc integer diam massa  enim semper congue risus suscipit  elit vitae amet', '2016-2-8', '2016-2-18');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (8,'mi tincidunt id sagittis adipiscing elit amet adipiscing sed odio euismod lectus vel malesuada  vitae ultrices egestas', '2019-7-16', '2019-7-27');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (9,'mi  nec et sit nulla pretium sed hendrerit amet at iaculis lorem ipsum ipsum rhoncus egestas at a tempus id ullamcorper purus ornare odio  ullamcorper', '2001-8-16', '2001-8-23');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (10,'faucibus amet elit praesent libero  orci diam quisque vitae  phasellus gravida consectetur', '2001-6-2', '2001-6-11');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (11,'neque adipiscing tellus amet platea aliquam nisi ut amet condimentum rutrum arcu consectetur est  proin mauris netus tellus  enim  sit molestie massa lectus  ac placerat sed odio augue commodo', '2021-6-21', '2021-7-1');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (12,'vel quam risus sit amet consectetur viverra eu aliqua mauris et justo et  nisl urna erat egestas  magna mauris hac id et sapien netus pretium nam et purus nec', '2005-2-22', '2005-2-26');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (13,'risus ipsum gravida nam est   vulputate eu habitant semper  etiam semper tempor lectus vel nunc morbi  bibendum quis et enim', '2004-7-22', '2004-8-4');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (14,'at  viverra amet duis vel vel mattis vestibulum  non', '2017-5-25', '2017-5-29');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (15,'duis et donec id mattis tincidunt  sit nunc donec tortor  volutpat sed vulputate odio interdum ornare a  massa vitae faucibus aliquam', '2020-12-7', '2020-12-15');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (16,'parturient ut et nulla tellus non mauris id nibh nunc integer id dolor  libero velit  lectus nibh   tristique non aliquam', '2016-7-16', '2016-7-27');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (17,'id justo  purus at eget risus aliquet a et mauris sit nisi mollis mauris velit tellus nunc dolor  tortor duis ipsum ac  augue', '2021-8-20', '2021-10-3');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (18,'aliquam  amet  mattis enim elit nisl pharetra tempus in id erat ultrices et  sit suspendisse  elit neque  cursus augue  adipiscing   in', '2006-6-22', '2006-6-25');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (19,'rutrum nec est eget mi imperdiet pulvinar eros ultrices arcu donec nullam sagittis felis  nulla  nunc tristique', '2004-5-11', '2004-5-14');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (20,'nunc et cursus aliquet porttitor urna venenatis', '2003-1-7', '2003-1-16');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (21,'fames  neque vulputate sit suspendisse porttitor fermentum tempor duis pharetra', '2016-11-29', '2016-12-8');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (22,'sit vel amet eget tempor diam interdum neque pharetra elit nunc convallis dolor ut id eu  potenti', '2014-6-18', '2014-6-25');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (23,'mauris ut enim vivamus vitae morbi nisi morbi orci malesuada pharetra quam interdum in pretium enim sagittis ipsum vestibulum pellentesque egestas tristique sed  sit vestibulum enim amet dignissim', '2020-12-27', '2021-1-8');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (24,'lobortis nunc mollis molestie donec eu consequat fermentum  ut nibh quis  viverra at a quis id porttitor nibh maecenas ullamcorper nam in at aliquam feugiat neque egestas non', '2012-3-15', '2012-4-16');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (25,'sagittis leo pharetra elit  leo adipiscing sit nisi ipsum et pulvinar volutpat', '2004-12-16', '2004-12-26');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (26,'nibh laoreet neque vel ultricies feugiat  iaculis id  aliquet sit ut massa non  ipsum tortor tellus sed nisl risus vivamus', '2003-1-2', '2003-1-5');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (27,'suspendisse condimentum cursus id morbi velit euismod netus  non quis at', '2019-12-19', '2019-12-27');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (28,'elementum gravida libero ac ut suscipit ac cursus  non nunc ut id gravida fusce consectetur purus nullam cursus sagittis enim pellentesque eget potenti et magna condimentum  leo nunc aliquam dictum', '2011-11-11', '2011-11-22');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (29,'tempus ut  ipsum amet labore duis  interdum proin enim scelerisque sed quis purus   ut', '2017-1-21', '2017-1-22');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (30,'suspendisse ultricies aliquet fermentum luctus eu malesuada at integer  urna lacus euismod at et dictum', '2016-5-28', '2016-6-5');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (31,'et venenatis elit at bibendum pulvinar sed tempus mauris vel diam tempor scelerisque etiam at amet consequat  sed consectetur pretium felis', '2017-5-25', '2017-5-28');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (32,'non ipsum massa augue scelerisque enim mollis  in ut nec lacus in nunc amet consectetur nisi enim nunc amet dignissim odio fames accumsan id purus', '2007-5-27', '2007-6-10');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (33,'lorem  congue vel sed massa aliquam   amet duis enim cursus mattis ut  sed ullamcorper ac ipsum pulvinar  eu ipsum eget magna molestie aliquam dictum vitae quis malesuada nibh sit', '2014-8-23', '2014-9-7');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (34,'mi aliquet molestie sapien congue amet lectus   viverra integer ultrices neque lobortis  viverra dictum', '2007-8-16', '2007-8-21');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (35,'tincidunt in nibh rutrum massa amet neque commodo netus bibendum tempor', '2016-3-12', '2016-3-25');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (36,'aenean habitant arcu  massa ultricies tellus eget ullamcorper fusce tellus malesuada eu tortor eu', '2007-3-21', '2007-4-23');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (37,'risus blandit mauris consectetur risus mauris sollicitudin sed montes eget purus faucibus urna duis nulla  nullam', '2002-8-4', '2002-8-14');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (38,'arcu risus tellus consectetur iaculis velit risus nulla ut purus donec etiam facilisi', '2018-8-8', '2018-8-13');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (39,'justo nunc tortor consequat  a nulla elit massa arcu adipiscing adipiscing sed et eleifend  auctor facilisi mauris  volutpat aenean duis aliquam amet venenatis quis lacinia  mattis nibh', '2000-7-5', '2000-7-14');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (40,'orci quam mauris habitasse luctus  viverra in   iaculis eu laoreet  urna nunc feugiat neque eu  malesuada erat massa amet,', '2009-9-5', '2009-10-7');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (41,'adipiscing aliquam nunc amet et sed iaculis morbi nec  proin pellentesque at lectus  at lobortis nisl senectus amet laoreet lectus senectus ut diam bibendum porttitor sed gravida in et sit in a', '2016-2-10', '2016-3-11');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (42,'tristique  hendrerit massa interdum velit nibh lobortis eget ac egestas tortor sit  dui odio amet diam nunc nunc  rutrum amet  suscipit rhoncus ut aliquam magna integer', '2021-4-15', '2021-4-26');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (43,'mattis molestie vitae et mauris imperdiet  id laoreet  neque erat aliquam sed etiam at nec nunc amet suspendisse condimentum velit morbi leo', '2000-6-27', '2000-7-8');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (44,'purus elit malesuada ipsum ultrices potenti lorem ultricies aliquet  in gravida consectetur  sit mattis mauris  suspendisse faucibus', '2002-4-13', '2002-4-27');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (45,'molestie   nibh eu sem velit  sed sit  aliquam pretium praesent mauris ultrices velit elit, sed faucibus quisque pellentesque nunc sem hendrerit ipsum', '2008-4-25', '2008-5-30');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (46,'habitant nunc duis etiam viverra pretium sagittis  tortor venenatis dis in fusce auctor  diam montes vulputate hendrerit tempus cursus sed nunc semper proin erat netus diam', '2013-5-18', '2013-5-19');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (47,'nulla ridiculus urna ut faucibus enim mattis ultricies aliquam justo fusce neque  purus ipsum augue', '2019-3-14', '2019-3-19');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (48,'purus orci libero aenean  aliquam tortor tempor lacus imperdiet  nisl ac proin dui tristique tristique ipsum velit egestas odio  sed consequat magnis at netus non tortor elit in vel proin mi', '2012-9-18', '2012-9-20');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (49,'enim tortor  iaculis quis ut  tristique pellentesque nunc sit bibendum quam   dapibus massa donec non viverra amet nunc elit eget fusce libero porttitor eu aliquam ut  tempus quam', '2019-7-13', '2019-7-24');
INSERT INTO epoca_promocao (ep_id, ep_nome, ep_data_inicio, ep_data_fim) VALUES (50,'nisi  arcu adipiscing malesuada tincidunt sem orci aliquet convallis mus gravida a a arcu interdum augue sed in interdum vitae mattis orci  eget enim vulputate porta sagittis', '2000-1-21', '2000-1-28');
INSERT INTO historico_sessoes, (sj_id, sj_data_inicio, sj_data_fim, produtos_pr_id, jogador_j_id) VALUES (1, 2018-12-23 17:32:00+00, 2018-12-23 20:27:00+00, 84, 78);
INSERT INTO historico_sessoes, (sj_id, sj_data_inicio, sj_data_fim, produtos_pr_id, jogador_j_id) VALUES (2, 2016-2-3 5:56:00+00, 2016-2-3 12:14:00+00, 69, 24);
INSERT INTO historico_sessoes, (sj_id, sj_data_inicio, sj_data_fim, produtos_pr_id, jogador_j_id) VALUES (3, 2015-9-29 13:47:00+00, 2015-9-29 17:56:00+00, 51, 77);
INSERT INTO historico_sessoes, (sj_id, sj_data_inicio, sj_data_fim, produtos_pr_id, jogador_j_id) VALUES (4, 2006-8-19 21:9:00+00, 2006-8-19 22:43:00+00, 88, 50);
INSERT INTO historico_sessoes, (sj_id, sj_data_inicio, sj_data_fim, produtos_pr_id, jogador_j_id) VALUES (5, 2017-5-25 19:1:00+00, 2017-5-25 22:34:00+00, 96, 85);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (1, 2016-11-27 0:59:00+00, 66719.58);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (2, 2005-12-26 16:32:00+00, 49830.89);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (3, 2006-11-10 14:43:00+00, 81698.21);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (4, 2010-1-5 8:59:00+00, 36440.49);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (5, 2003-6-2 15:32:00+00, 83838.47);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (6, 2004-10-2 23:24:00+00, 43253.36);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (7, 2017-6-16 10:9:00+00, 82817.14);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (8, 2008-2-15 17:36:00+00, 78241.90);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (9, 2019-1-23 23:29:00+00, 73505.82);
INSERT INTO despesas (d_id, d_data, d_valor) VALUES (10, 2004-9-3 18:49:00+00, 68133.55);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (1, '2013-12-5 14:1:00+00', 21691.33, 95, 44, 40);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (2, '2011-8-20 2:27:00+00', 10391.64, 46, 66, 35);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (3, '2008-6-13 11:42:00+00', 28056.88, 84, 67, 6);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (4, '2007-12-3 7:31:00+00', 35786.47, 83, 19, 73);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (5, '2011-7-21 21:18:00+00', 8700.16, 20, 95, 55);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (6, '2011-5-30 21:53:00+00', 10659.36, 46, 32, 47);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (7, '2000-4-8 11:18:00+00', 58421.72, 59, 8, 61);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (8, '2016-3-11 5:28:00+00', 35175.39, 28, 42, 5);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (9, '2017-7-10 8:43:00+00', 59627.87, 38, 53, 81);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (10, '2000-11-29 9:37:00+00', 44997.56, 65, 36, 48);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (11, '2007-10-22 11:34:00+00', 49473.74, 28, 50, 4);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (12, '2007-7-22 7:53:00+00', 29211.37, 37, 88, 69);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (13, '2004-11-15 20:15:00+00', 65697.88, 58, 27, 51);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (14, '2018-5-19 9:42:00+00', 61695.73, 37, 10, 4);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (15, '2021-10-28 0:13:00+00', 9516.26, 58, 7, 8);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (16, '2018-1-25 19:38:00+00', 40621.37, 89, 21, 68);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (17, '2017-7-25 16:37:00+00', 31103.12, 95, 86, 75);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (18, '2009-10-24 15:11:00+00', 42338.49, 34, 100, 11);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (19, '2001-4-12 14:48:00+00', 1830.53, 65, 3, 38);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (20, '2019-2-1 11:12:00+00', 11891.17, 63, 76, 67);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (21, '2000-2-22 11:43:00+00', 42119.47, 15, 57, 47);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (22, '2007-10-18 21:50:00+00', 68095.77, 30, 75, 14);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (23, '2020-6-6 22:50:00+00', 48279.07, 64, 53, 7);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (24, '2016-7-18 10:6:00+00', 53787.27, 42, 55, 49);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (25, '2005-1-3 16:47:00+00', 33543.28, 81, 20, 77);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (26, '2004-1-6 21:47:00+00', 7180.39, 88, 1, 100);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (27, '2011-8-7 9:45:00+00', 30167.71, 44, 11, 33);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (28, '2021-7-26 8:47:00+00', 9636.76, 23, 13, 33);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (29, '2004-12-7 13:6:00+00', 5182.53, 63, 35, 58);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (30, '2003-2-9 12:26:00+00', 19222.32, 97, 97, 59);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (31, '2002-10-3 14:59:00+00', 45676.19, 56, 46, 63);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (32, '2001-12-11 3:16:00+00', 61868.77, 22, 57, 73);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (33, '2014-9-27 1:0:00+00', 39053.07, 76, 55, 74);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (34, '2021-10-8 0:43:00+00', 30277.47, 68, 42, 100);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (35, '2000-8-12 13:21:00+00', 46951.60, 94, 30, 100);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (36, '2014-7-4 20:43:00+00', 48719.56, 8, 77, 55);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (37, '2019-8-28 17:25:00+00', 50877.24, 77, 77, 31);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (38, '2005-2-27 22:40:00+00', 5769.83, 57, 33, 55);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (39, '2002-1-8 7:8:00+00', 53891.40, 12, 63, 76);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (40, '2021-6-14 19:33:00+00', 61025.06, 59, 98, 45);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (41, '2006-5-26 5:41:00+00', 45145.95, 17, 20, 54);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (42, '2015-4-19 18:45:00+00', 38469.93, 54, 10, 56);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (43, '2000-8-29 0:56:00+00', 22621.07, 73, 82, 74);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (44, '2015-7-8 20:18:00+00', 17508.66, 42, 44, 70);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (45, '2016-5-16 16:51:00+00', 43969.69, 21, 30, 14);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (46, '2011-12-11 5:10:00+00', 56674.60, 20, 25, 35);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (47, '2014-1-12 21:24:00+00', 459.82, 14, 98, 53);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (48, '2015-8-24 2:26:00+00', 53153.72, 100, 37, 54);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (49, '2016-1-7 3:56:00+00', 53639.10, 26, 6, 56);
INSERT INTO vendas (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) VALUES (50, '2020-3-8 2:15:00+00', 53990.44, 1, 37, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 20);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 61);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 39);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 28);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 6);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 87);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 31);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 72);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 33);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 70);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 60);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 49);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 89);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 72);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 20);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 30);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 70);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 3);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 6);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 91);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 48);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 70);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 60);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 1);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 61);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 94);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 30);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 44);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 56);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 74);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 7);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 28);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 22);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 25);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 82);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 85);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 81);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 32);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 48);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 67);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 47);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 39);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 70);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 78);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 67);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 42);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 57);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 64);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 81);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 94);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 53);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 7);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 94);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 28);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 26);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 62);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 91);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 88);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 20);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 62);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 31);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 77);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 73);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 21);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 11);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 94);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 62);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 34);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 12);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 34);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 93);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 38);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 22);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 81);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 88);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 21);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 5);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 24);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 37);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 45);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 74);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 8);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 73);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 48);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 85);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 24);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 87);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 59);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 89);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 61);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 81);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 31);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 42);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 53);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 31);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 17);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 21);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 56);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 89);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 39);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 34);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 70);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 7);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 8);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 38);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 38);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 64);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 12);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 64);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 32);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 78);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 32);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 26);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 60);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 1);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 25);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 7);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 22);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 22);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 45);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 67);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 30);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 94);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 21);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 11);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 26);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 78);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 48);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 1);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 7);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 25);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 34);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 47);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 82);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 72);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 73);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 6);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 38);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 20);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 83);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 12);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 85);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 57);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 56);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 71);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 12);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 23);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 49);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 89);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 55);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 26);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 97);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 68);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 24);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 31);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 14);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 33);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 77);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 93);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 67);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 56);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 1);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 32);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 10);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 39);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 39);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 32);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 49);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 4);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 50);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 53);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 50);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 73);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 35);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 72);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 90);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 74);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 30);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 50);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 72);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 79);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 56);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 78);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 61);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 100);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 80);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 74);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 44);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 76);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 92);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 2);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 96);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 37);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 21);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 46);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 95);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 25);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 51);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 62);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 57);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 43);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 91);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 85);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 16);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 13);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 98);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 44);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 53);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 37);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 3);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 82);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 96);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 45);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 83);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 69);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 78);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 15);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 28);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 75);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 27);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 12);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 58);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 52);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 63);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 84);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 87);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 67);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 29);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 41);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 96);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 9);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 19);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 86);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (10, 54);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (9, 44);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 36);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 40);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 38);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (5, 20);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 48);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 8);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (8, 91);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (1, 25);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (7, 66);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (4, 11);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (6, 99);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (2, 18);
INSERT INTO despesas_rubrica (despesas_d_id, rubrica_r_id)
            VALUES (3, 94);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (5, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 10);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 2);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 8);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (1, 6);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 7);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (4, 5);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 4);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 1);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (2, 3);
INSERT INTO fornecedor_despesas (fornecedor_f_id, despesas_d_id)
            VALUES (3, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 100);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 28);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 100);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 70);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 52);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 93);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 43);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 10);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 23);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 27);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 27);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 1);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 22);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 55);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 67);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 50);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 28);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 78);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 93);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 71);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 1);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 100);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 86);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 62);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 55);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 20);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 93);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 16);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 80);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 74);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 74);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 87);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 10);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 36);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 45);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 62);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 14);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 82);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 52);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 16);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 100);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 79);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 10);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 67);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 10);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 71);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 70);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 76);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 4);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 27);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 93);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 56);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 68);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 20);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 13);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 16);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 47);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 13);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 45);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 52);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 50);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 87);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 64);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 27);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 36);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 65);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 55);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 47);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 67);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 21);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 4);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 28);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 99);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 80);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 98);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 45);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 47);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 80);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 31);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 74);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 7);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 76);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 87);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 100);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 99);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 42);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 99);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 42);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 17);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 92);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 79);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 17);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 91);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 71);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 86);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 7);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 92);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 23);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 82);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 87);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 74);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 68);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 82);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 23);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 68);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 17);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 96);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 20);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 41);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 1);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 13);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 13);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 55);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 52);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 67);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 99);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 46);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 56);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 47);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 53);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 70);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 21);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 97);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 70);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 20);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 79);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 80);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 36);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 31);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 14);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 7);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 98);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 93);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 35);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 98);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 62);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 7);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 86);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 53);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 31);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 73);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 56);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 7);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 68);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 43);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 53);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 86);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 67);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 36);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 49);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 31);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 23);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 20);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 59);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 6);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 36);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 41);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 40);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 92);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 81);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 55);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 72);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 18);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 11);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 19);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 25);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 78);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 3);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 92);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 71);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 54);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 29);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 16);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 58);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 32);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 97);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 69);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 53);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 95);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 2);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 33);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 43);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 14);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 39);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 65);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 58);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 65);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 5);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 16);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 34);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 96);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 1);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (10, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 75);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 9);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 61);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 85);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 53);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 94);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (5, 14);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 90);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 82);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 77);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 65);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 49);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 26);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 66);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 68);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (2, 64);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 8);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 37);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (9, 14);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 88);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 78);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 84);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 24);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 41);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 48);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (3, 44);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 63);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 38);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 51);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 83);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (6, 15);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (8, 12);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (1, 57);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (4, 27);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 1);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 50);
INSERT INTO despesas_produtos (despesas_d_id, produtos_pr_id)
            VALUES (7, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (49, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (45, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (49, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (39, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (39, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (45, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (39, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (39, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (49, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (45, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (7, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (45, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (14, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (49, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 20);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 11);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (36, 10);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 40);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (18, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (39, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 1);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (17, 16);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (44, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (23, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 28);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (25, 8);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 45);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (50, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 34);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 49);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (20, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 39);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (24, 21);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (48, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (46, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (34, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 5);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 23);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 42);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (40, 27);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 37);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 36);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (49, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (11, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 46);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (32, 22);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (19, 50);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 29);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (12, 31);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (21, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 38);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (45, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (10, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 7);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (38, 32);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (31, 12);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (26, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (1, 24);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (43, 44);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 14);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (33, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 43);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (22, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 26);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 4);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (37, 19);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (8, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 13);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (6, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (27, 2);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (13, 17);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (28, 47);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 33);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (41, 6);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (5, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (9, 25);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (4, 18);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (47, 9);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (30, 3);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (16, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (3, 48);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (15, 35);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (35, 30);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (42, 41);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (29, 15);
INSERT INTO vendas_epoca_promocao (vendas_ve_id, epoca_promocao_ep_id)
            VALUES (2, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (36, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (80, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (95, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 54);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (10, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 12);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (55, 86);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 51);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (29, 46);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (59, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (33, 19);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (86, 6);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (11, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 27);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (61, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 69);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (95, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (63, 54);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 98);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (9, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (80, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (33, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 94);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (15, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (10, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (71, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (33, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (54, 87);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 77);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 93);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 40);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (56, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (82, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (14, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (32, 16);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (74, 61);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (16, 82);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (96, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (82, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 16);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (81, 46);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (55, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 39);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (58, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (26, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (76, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 83);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 79);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 87);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 19);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (61, 94);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (99, 45);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (92, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 33);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (15, 57);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 50);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (99, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 21);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (89, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (4, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 37);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (92, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 93);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (68, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 70);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 16);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 81);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (54, 9);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 42);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (76, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 47);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (35, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (9, 39);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (33, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (18, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (35, 58);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (14, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 1);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (95, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (47, 17);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 76);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 3);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 57);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 11);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (30, 84);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 50);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 41);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 70);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (4, 47);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 97);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (73, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 45);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (4, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (91, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 86);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (100, 19);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (79, 31);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (71, 73);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (47, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (96, 18);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 98);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 12);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (90, 29);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (56, 9);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (85, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 50);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (68, 48);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 43);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (65, 1);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (67, 22);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (76, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (66, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (90, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 11);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 69);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (84, 21);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (88, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 9);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (15, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (80, 82);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 54);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 17);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (25, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 76);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 98);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 23);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (26, 28);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 21);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 84);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (59, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (73, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (74, 13);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (57, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 97);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (40, 45);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (12, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 22);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 47);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 59);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (85, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 2);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (91, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (90, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (55, 18);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 99);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 70);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 45);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (10, 39);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (91, 20);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 56);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (98, 41);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (14, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (98, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 57);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 20);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (47, 4);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (11, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 58);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (11, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 70);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 12);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (66, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (68, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 3);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (100, 79);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 14);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 2);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (52, 94);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (67, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 77);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (14, 44);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 4);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (33, 81);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 47);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 48);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (4, 58);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 53);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (100, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (11, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (90, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 53);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 51);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (91, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (30, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (12, 4);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (94, 96);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 20);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 58);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (98, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (86, 27);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 92);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 43);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (58, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 11);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 63);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (9, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 82);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (26, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 54);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 6);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (65, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (65, 77);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (100, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 75);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (71, 50);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (67, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 78);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (4, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 14);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 37);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 93);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 87);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (29, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 3);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (74, 25);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (99, 47);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (11, 44);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 60);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (39, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 12);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (24, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 86);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 11);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 24);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 78);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 43);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 98);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 61);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 84);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (73, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 29);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (91, 93);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (68, 29);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 93);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (86, 73);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (37, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 79);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (72, 99);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 27);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (92, 73);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (82, 92);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 42);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 92);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (75, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 46);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (32, 18);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (32, 23);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (76, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (56, 39);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (29, 16);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 28);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (26, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 61);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 44);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (87, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (34, 98);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 1);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 92);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 17);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 83);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (88, 56);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 29);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (16, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (30, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 20);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (77, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (58, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (18, 23);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (89, 79);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (40, 27);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 90);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (18, 95);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (89, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 21);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (9, 86);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 62);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (44, 8);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (35, 40);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (51, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 40);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 100);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (96, 31);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (72, 56);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (18, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (68, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (60, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (79, 32);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 40);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (92, 34);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (28, 87);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (35, 69);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (6, 70);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 84);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 97);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 88);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 59);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (82, 53);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (100, 18);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (58, 99);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (75, 4);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (96, 64);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 74);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 29);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 56);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (70, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (76, 36);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (20, 66);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (5, 58);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (83, 21);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (8, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (6, 9);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (58, 14);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (59, 87);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (6, 13);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 41);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (32, 27);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 91);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 59);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 18);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (81, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (99, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (2, 45);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (57, 14);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 78);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (3, 89);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 30);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (6, 26);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (40, 12);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (19, 65);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 61);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (52, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (98, 43);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (15, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 52);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 55);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (13, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (31, 14);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (85, 13);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (73, 59);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (62, 67);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 61);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (99, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (15, 40);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (71, 13);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (63, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (44, 81);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (69, 2);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (17, 38);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 46);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (95, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (80, 13);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (45, 92);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (50, 71);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 73);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (63, 96);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (80, 41);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (49, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (43, 53);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 5);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (41, 85);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (38, 43);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (88, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 20);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (78, 22);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (65, 19);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (1, 48);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (7, 3);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (42, 51);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (36, 81);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (21, 68);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 56);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (92, 84);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 49);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (98, 72);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 35);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (97, 19);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (88, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (46, 51);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (53, 15);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (22, 50);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (30, 80);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (23, 7);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (48, 10);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (93, 11);
INSERT INTO jogador_produtos (jogador_j_id, produtos_pr_id)
            VALUES (27, 74);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (63, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (84, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (61, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (83, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (87, 40);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (21, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (3, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (98, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (69, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 10);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (80, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (81, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (14, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (47, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (93, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (86, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (27, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (24, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (18, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (16, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (13, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (13, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (21, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (58, 48);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (17, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (75, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (93, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (55, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (40, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (20, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (59, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (49, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (14, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (78, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (10, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (80, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (73, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (93, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (21, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (59, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (50, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (60, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (61, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 10);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (47, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (87, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (38, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 7);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (76, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (41, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (60, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (91, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (29, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (40, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (47, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (43, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (64, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 10);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (59, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (18, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (85, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (10, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (20, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (52, 22);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (90, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 7);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (27, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (81, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (65, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (58, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (84, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (30, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (30, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (29, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (58, 27);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (69, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (38, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (65, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (24, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (17, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (13, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (83, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (24, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (83, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (38, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (87, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 27);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (40, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (73, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (23, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (52, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (96, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (41, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (13, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (41, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (30, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (98, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (1, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (14, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 10);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (61, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (6, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (87, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (30, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (17, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (68, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (63, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (89, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (93, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (38, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (90, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (65, 7);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (33, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (46, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (55, 22);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (72, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (68, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (51, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (15, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (52, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (6, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (27, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (43, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (61, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (6, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (34, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (2, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (61, 40);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (44, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (77, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (78, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (46, 44);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (86, 48);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (80, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (83, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (63, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (52, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (68, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (10, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (49, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 44);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (48, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (96, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (21, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (43, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (87, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (59, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (68, 30);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (3, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (84, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (47, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (55, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (48, 22);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (23, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (15, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (59, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (10, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (45, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (69, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 44);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (89, 39);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (49, 7);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (44, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (18, 18);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (78, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (2, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (27, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (29, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (3, 10);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (66, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (43, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (51, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (97, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (50, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (55, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (63, 7);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (98, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (14, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (90, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (63, 31);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (60, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (86, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (99, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (34, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (65, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (40, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (29, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (6, 27);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (16, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (4, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (80, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (85, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (16, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (51, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (41, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (33, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (44, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (47, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (16, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (93, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (89, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (95, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (68, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (89, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 29);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (22, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (56, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (48, 36);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (98, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (58, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (15, 48);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (69, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 22);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (41, 44);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (51, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (71, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (67, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 14);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (12, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (22, 1);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (92, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (22, 15);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (8, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (6, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (60, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (3, 27);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (51, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (28, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (82, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (46, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (100, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (83, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (73, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (52, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (46, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (23, 44);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (48, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (25, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (54, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (17, 34);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (3, 21);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (55, 11);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (98, 22);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (57, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 43);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (42, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 13);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (79, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (15, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (23, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (76, 23);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (84, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (36, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (22, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (53, 27);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (31, 45);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (75, 28);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 24);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (35, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (24, 6);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (37, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (64, 46);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (21, 41);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (32, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (78, 26);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (19, 12);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (76, 2);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (48, 35);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (39, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (38, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (50, 9);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (88, 33);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (22, 37);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (33, 32);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (76, 49);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (11, 38);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (99, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (2, 42);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (7, 50);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (16, 8);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (26, 20);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (50, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (74, 4);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (15, 3);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (62, 47);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (5, 19);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (70, 16);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (72, 5);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (9, 17);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (76, 25);
INSERT INTO produtos_epoca_promocao (produtos_pr_id, epoca_promocao_ep_id)
            VALUES (80, 26);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (184, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (267, 55);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (319, 12);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (334, 59);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (385, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (197, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (291, 40);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (34, 52);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (410, 58);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (233, 28);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (343, 27);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (63, 63);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (175, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (241, 77);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (403, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (314, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (269, 21);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (395, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (364, 28);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (34, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (131, 39);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (414, 39);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (247, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (193, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (201, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (31, 30);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (118, 59);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (154, 63);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (421, 58);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (385, 76);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (1, 7);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (391, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (216, 88);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (16, 62);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (218, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (124, 89);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (212, 68);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (193, 97);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (249, 12);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (259, 46);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (184, 77);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (232, 44);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (340, 59);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (44, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (393, 7);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (176, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (262, 58);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (152, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (363, 31);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (61, 21);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (143, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (109, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (414, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (153, 46);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (27, 31);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (141, 35);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (7, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (376, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (56, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (178, 91);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (269, 67);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (240, 25);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (204, 35);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (261, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (211, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (47, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (289, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (114, 91);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (353, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (201, 79);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (57, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (166, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (11, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (410, 72);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (283, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (325, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (308, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (235, 54);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (184, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (404, 86);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (78, 30);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (40, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (117, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (349, 97);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (209, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (426, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (321, 47);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (203, 40);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (57, 62);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (101, 7);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (218, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (170, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (4, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (224, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (308, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (252, 19);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (157, 55);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (77, 78);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (255, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (381, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (21, 82);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (294, 61);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (373, 88);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (223, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (408, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (262, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (28, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (30, 88);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (5, 19);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (4, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (60, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (303, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (149, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (390, 8);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (234, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (71, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (141, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (58, 72);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (38, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (292, 39);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (34, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (332, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (220, 93);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (348, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (404, 46);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (174, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (354, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (319, 86);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (123, 27);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (78, 89);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (174, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (119, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (94, 50);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (186, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (34, 68);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (248, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (249, 67);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (129, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (68, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (218, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (136, 62);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (423, 83);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (97, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (100, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (3, 72);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 40);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (225, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (375, 3);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (377, 61);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (119, 83);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (242, 55);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (361, 96);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (82, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (284, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (383, 31);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (312, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (284, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (84, 75);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (270, 47);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (82, 82);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (297, 96);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (219, 63);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (181, 21);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (103, 24);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (348, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (396, 66);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (375, 77);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (309, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (380, 68);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (252, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (384, 66);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (139, 57);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (88, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (42, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (66, 55);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (294, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (262, 67);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (133, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (326, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (232, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (138, 75);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (198, 97);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (379, 90);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (221, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (373, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (142, 8);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (241, 24);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (335, 52);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (6, 61);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (117, 24);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 94);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (242, 43);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (210, 5);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (39, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (66, 27);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (38, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (341, 80);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (77, 54);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (159, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (301, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (318, 93);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (125, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (238, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (95, 83);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (298, 78);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (46, 43);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (49, 5);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (37, 65);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (15, 42);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (252, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (192, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (422, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (23, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (384, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (26, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (31, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (228, 89);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (281, 82);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (52, 35);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (194, 91);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (320, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (26, 66);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (291, 17);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (356, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (24, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (382, 72);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (3, 65);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (86, 5);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (243, 1);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (374, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (270, 35);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (20, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (50, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (306, 77);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (260, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (273, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (110, 34);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (265, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (273, 50);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (11, 69);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (417, 95);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (97, 83);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (217, 42);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (386, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (286, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (7, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (23, 10);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (180, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (93, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (367, 79);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (281, 24);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (166, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (404, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (358, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (37, 42);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (370, 97);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (36, 30);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (283, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (157, 95);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (8, 75);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (369, 36);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (97, 54);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (110, 10);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (309, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (227, 84);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (71, 61);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (286, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (46, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (251, 91);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (416, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (140, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (284, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (127, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (51, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (307, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (127, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (62, 84);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (218, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (236, 63);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (65, 50);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (323, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (185, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (114, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (278, 57);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (230, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (163, 62);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (104, 91);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (302, 21);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (224, 10);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (204, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (242, 93);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (48, 28);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (252, 90);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (137, 90);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (28, 57);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (353, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (350, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (168, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (348, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (251, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (388, 93);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (129, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (280, 90);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (318, 59);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (14, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (261, 44);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (362, 3);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (65, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (17, 61);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (133, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (300, 89);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (348, 29);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (270, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (137, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (85, 24);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (332, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (245, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (165, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (356, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (155, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (78, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (349, 75);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (330, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (147, 8);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (295, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (58, 96);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (80, 28);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (53, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (398, 10);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (89, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (260, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (400, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (218, 26);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (289, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (144, 40);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (203, 11);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (341, 1);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (292, 1);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (143, 13);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (353, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (239, 4);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (339, 55);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (24, 79);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (31, 46);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (14, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (122, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (367, 68);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (164, 78);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (311, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (411, 69);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (35, 62);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (381, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (234, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (119, 27);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (14, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (378, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (203, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (105, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (91, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (423, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (292, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (322, 47);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (285, 65);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (113, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (177, 25);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (29, 89);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (199, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (412, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (54, 96);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (301, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (307, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (278, 96);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (262, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (61, 12);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (121, 85);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (120, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (244, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (3, 84);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (23, 17);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (361, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (24, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (232, 5);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (380, 19);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (344, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (327, 88);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (190, 27);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (71, 81);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (152, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (50, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (226, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (299, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (289, 23);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (238, 68);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (35, 44);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (88, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (327, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (346, 66);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (223, 16);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (329, 88);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (128, 60);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (129, 84);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (347, 75);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (111, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (113, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (360, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (47, 31);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (357, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (403, 47);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (223, 18);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (164, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (203, 29);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (338, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (4, 69);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (124, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (57, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (208, 74);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (392, 82);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (219, 82);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (169, 31);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (353, 26);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (211, 37);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (111, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (281, 56);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (256, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (265, 73);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (424, 25);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (293, 64);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (254, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (140, 7);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (229, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (412, 86);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (263, 51);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (406, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (284, 43);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (392, 6);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (128, 94);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (120, 94);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (369, 9);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (113, 86);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (188, 29);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (26, 94);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (328, 45);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (147, 92);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (120, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (102, 71);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (181, 76);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (260, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (369, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (395, 5);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (232, 26);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (259, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (69, 58);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (256, 87);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (388, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (341, 49);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (97, 29);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (258, 50);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (251, 93);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (329, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (315, 100);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (219, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (301, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (213, 53);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (113, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (368, 22);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (125, 20);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (296, 48);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (160, 90);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (71, 94);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (352, 54);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (91, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (399, 40);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (426, 8);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (305, 57);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (380, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (336, 77);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (84, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (263, 1);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (132, 70);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (124, 66);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (231, 14);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (47, 32);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (334, 73);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (17, 97);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (23, 41);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (39, 38);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (183, 33);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (397, 73);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (252, 98);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (25, 78);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (61, 50);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (102, 35);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (253, 65);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (92, 15);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (35, 99);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (149, 2);
INSERT INTO categorias_produtos (categorias_c_id, produtos_pr_id)
            VALUES (137, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 83);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 73);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 13);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 97);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 52);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 8);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 6);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 70);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 70);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 13);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 17);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 17);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 84);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 28);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 93);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 2);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 66);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 13);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 52);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 80);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 88);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 97);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 16);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 24);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 7);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 66);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 54);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 9);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 64);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 27);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 22);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 28);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 9);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 31);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 84);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 40);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 100);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 50);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 67);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 57);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 56);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 80);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 13);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 87);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 94);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 67);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 74);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 41);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 98);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 2);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 71);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 83);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 2);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 40);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 88);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 6);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 92);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 78);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 53);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 6);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 2);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 19);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 42);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 21);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 12);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 57);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 67);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 80);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 95);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 10);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 66);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 57);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 81);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 80);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 76);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 83);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 53);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 19);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 8);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 76);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 28);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 8);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 24);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 8);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 83);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 41);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 32);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 78);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 74);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 97);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 12);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 65);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 68);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 25);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 50);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 46);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 12);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 25);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 95);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 61);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 2);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 32);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 14);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 68);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 46);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 10);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 94);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 25);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 19);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 12);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 54);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 65);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 24);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 64);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 98);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 4);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 40);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 48);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 60);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 45);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 87);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 78);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 71);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 3);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 76);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 97);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 50);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 7);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 3);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 100);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 17);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 28);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 84);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 92);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 60);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 16);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 39);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 50);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 73);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 88);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 66);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 17);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 60);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 70);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 31);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 12);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 75);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 52);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 21);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 95);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 85);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 73);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 78);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 70);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 81);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 27);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 41);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 81);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 43);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 52);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 7);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 70);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 16);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 45);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 19);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 3);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 19);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 25);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 45);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 51);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 53);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 34);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 36);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 16);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 99);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 6);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 17);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 16);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 87);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 91);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 98);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 72);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 33);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 41);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 27);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 11);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 90);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 56);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 68);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 94);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 21);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 61);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 1);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 40);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 7);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 42);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 55);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 62);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 28);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 29);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 25);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 24);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 13);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 64);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 78);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 55);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 47);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 49);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 92);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 3);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 58);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 79);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 59);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 15);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 21);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 44);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 48);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 60);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 37);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 94);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 60);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 87);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 6);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 68);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 23);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 69);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 65);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 41);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 96);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 77);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 32);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 38);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 100);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 82);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 84);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 35);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 45);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 26);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 86);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 93);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 63);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 68);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 3);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 5);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 18);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 89);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (2, 92);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 30);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 83);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (3, 92);
INSERT INTO sistema_operativo_produtos (sistema_operativo_s_id, produtos_pr_id)
            VALUES (1, 19);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 168);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 109);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (31, 82);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 4);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 335);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 325);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 49);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 209);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 336);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 362);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (99, 216);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 139);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 164);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (50, 230);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 304);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 410);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (16, 218);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (25, 108);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 75);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (70, 19);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (47, 259);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 183);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 45);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 21);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 281);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (6, 175);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (37, 83);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 181);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 287);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (29, 249);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 333);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (87, 344);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 125);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 6);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (81, 42);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (99, 107);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (17, 422);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 10);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (49, 84);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 362);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 225);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 401);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (98, 382);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (8, 302);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 364);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 227);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (71, 120);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 268);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 266);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 382);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (23, 149);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (98, 202);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 230);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (47, 304);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (34, 277);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 46);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 305);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 372);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 136);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 248);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 408);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (17, 29);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 156);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 254);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 11);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (33, 374);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (48, 167);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (78, 289);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (31, 420);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (20, 113);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (29, 401);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (16, 152);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (100, 263);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 401);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 280);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 419);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (74, 159);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 395);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (64, 154);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (2, 352);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (78, 145);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (62, 148);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (25, 328);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 416);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 25);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (64, 146);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (99, 273);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 1);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 314);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 67);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (66, 74);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 270);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 93);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 153);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 214);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 140);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 3);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 420);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (77, 312);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (83, 422);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 270);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (48, 320);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (70, 236);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (57, 184);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (44, 1);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 346);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (49, 200);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 53);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 120);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 239);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (72, 233);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 57);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 317);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 134);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 337);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (24, 424);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (34, 15);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (27, 408);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 222);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (68, 82);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (86, 34);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (17, 43);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 127);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 67);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (81, 109);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 180);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 209);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 305);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 230);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (68, 388);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 287);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 177);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 111);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (81, 54);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 91);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 280);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 54);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 132);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (55, 123);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 192);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 174);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 143);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 70);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (70, 14);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 425);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 385);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 344);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 401);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 287);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (27, 337);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 227);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (55, 131);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (85, 364);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 125);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 184);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 24);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (31, 109);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (59, 185);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 12);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (77, 345);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (55, 282);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 194);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 319);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 282);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (44, 45);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (4, 141);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 142);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (6, 382);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 20);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (71, 34);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (58, 396);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (86, 406);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (25, 324);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 141);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 228);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (29, 263);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 30);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (68, 102);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 140);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 167);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 289);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 48);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 210);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (53, 383);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (38, 254);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 406);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (21, 93);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (21, 29);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (43, 414);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (29, 344);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 97);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 62);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 210);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 413);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 251);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (38, 237);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 234);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (85, 137);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 406);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 305);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 87);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (33, 384);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 366);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (5, 178);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 404);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (8, 230);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 347);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (48, 331);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 368);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (23, 212);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 24);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (8, 317);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 296);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (86, 10);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (7, 389);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 95);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 410);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (6, 83);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 288);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (50, 232);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (78, 7);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 290);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 334);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 126);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 42);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (14, 182);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 135);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 263);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 24);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (31, 287);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 120);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 147);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (11, 65);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (7, 40);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 410);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (34, 144);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (8, 367);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 388);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (12, 71);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (58, 32);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 333);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (71, 65);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 249);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (99, 107);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 385);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 130);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (27, 363);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (23, 379);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 188);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 363);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (53, 180);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 277);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 197);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (5, 342);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (44, 401);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (40, 292);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 351);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (98, 204);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (7, 225);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 414);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (37, 200);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 376);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (41, 101);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 52);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (66, 106);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 3);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (41, 130);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 105);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 55);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (58, 418);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (100, 34);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (16, 358);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (17, 366);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (2, 321);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 74);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 38);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 227);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 161);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 335);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 224);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 339);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 340);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (66, 413);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (34, 68);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 33);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 165);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 32);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 35);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 201);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 403);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (74, 291);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (33, 288);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 295);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 228);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 60);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 49);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (97, 49);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 168);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 197);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (16, 217);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 340);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (11, 322);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (74, 360);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 265);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 80);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (37, 261);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 264);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (72, 304);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 57);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (97, 334);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 26);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (88, 394);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (5, 93);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 156);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (100, 28);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 26);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (20, 275);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (4, 154);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (86, 207);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (53, 413);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 295);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (14, 110);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 138);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (98, 240);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 340);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 241);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (87, 109);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 260);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (49, 357);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 174);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 325);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (64, 64);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (97, 133);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 397);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 239);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 108);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 354);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (39, 259);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 129);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (91, 80);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (56, 151);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (50, 145);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 320);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (96, 273);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (14, 68);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 147);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (81, 297);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 192);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 87);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 272);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (37, 298);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (30, 45);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 299);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 403);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 345);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (49, 318);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (23, 240);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 332);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (55, 315);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (68, 334);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 267);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 327);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (100, 238);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 341);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 191);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (18, 204);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 156);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (47, 386);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 285);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (64, 112);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (16, 73);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 72);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 121);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 135);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 75);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 104);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (41, 227);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 2);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 309);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 94);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 14);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (76, 425);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 283);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (43, 156);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (40, 291);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (43, 400);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (21, 422);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 305);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 214);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 304);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (33, 426);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (6, 217);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (56, 347);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (73, 304);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 277);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 384);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 408);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (8, 173);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (20, 146);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (11, 356);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (14, 393);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (50, 12);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (53, 394);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 32);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 353);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (41, 317);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (40, 303);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (24, 388);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (56, 315);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (27, 325);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 265);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 230);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (87, 243);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (51, 22);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (26, 31);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 113);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 83);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 7);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (90, 172);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (71, 195);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (25, 158);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (19, 391);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 405);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (64, 293);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (75, 26);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (9, 79);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 149);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (50, 183);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (92, 51);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (42, 20);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (55, 41);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (23, 254);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 180);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 303);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (47, 199);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 102);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 189);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 115);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (10, 61);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (20, 70);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (74, 184);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (21, 74);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (1, 170);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (36, 327);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (80, 193);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (84, 329);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (43, 199);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (61, 387);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (59, 213);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 409);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (99, 167);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (3, 393);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (59, 193);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (87, 229);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (66, 231);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (56, 228);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (13, 129);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (48, 217);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 104);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (46, 411);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 105);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (74, 352);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (95, 168);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (87, 7);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (83, 108);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 377);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (22, 50);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (81, 286);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (54, 384);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (52, 370);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (5, 73);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (47, 270);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (15, 246);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (45, 233);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (2, 385);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (79, 289);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 249);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 190);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (12, 87);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (69, 294);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 276);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 180);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (89, 194);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (43, 10);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (82, 411);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (67, 426);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 383);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (63, 348);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (73, 396);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (88, 363);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (4, 234);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (93, 125);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (32, 348);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (17, 380);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (35, 276);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (60, 269);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (5, 314);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (65, 298);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (94, 69);
INSERT INTO produtos_genero (produtos_pr_id, genero_g_id)
            VALUES (28, 325);
