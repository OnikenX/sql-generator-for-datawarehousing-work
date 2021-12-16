use std::{
    fs::File,
    io::{BufWriter, Write},
};

use rand::Rng;

use crate::{
    general_utils::{RandomGenerator, TreatString},
    genericos::output_file,
    TABLES,
};

// struct Produto {
//     pr_id: usize,
//     pr_nome: String, //45
//     pr_preco: f32,
//     pr_avaliacao: u8,
//     pr_requisitos: String, //256
//     pr_tipo: u8,
//     pr_iva: f32,
//     pr_descricao: String, //100
//     desenvolvedor_ds_id: usize,
//     editora_e_id: usize,
// }

pub fn produtos(
    n_produtos: usize,
    rnd: &mut RandomGenerator,
    n_desenvolvedores: usize,
    n_editoras: usize,
) {
    let mut file = BufWriter::new(File::create(output_file(TABLES[8])).unwrap());
    for id in 1..=n_produtos {
        let preco = rnd.rnd.gen_range(0.0..=420.0); //preco
        let iva = preco * rnd.rnd.gen_range(0.05..=0.30);
        file.write(
            format!(
                "INSERT INTO {} (pr_id, pr_nome, pr_preco, pr_avaliacao, pr_requisitos, pr_tipo,\
                pr_iva, pr_descricao, desenvolvedor_ds_id, editora_e_id)\
                VALUES ({},\'{}\', {:.2}, {},\'{}\', {}, {:.2}, \'{}\', {}, {});\n",
                TABLES[8],
                id,
                rnd.get_random_words(45), //nome
                preco,
                rnd.rnd.gen_range(0..=100), //avaliacao
                rnd.get_random_words(256),  // requisitos
                rnd.rnd.gen_range(0..=2),   //tipo
                iva,
                rnd.get_random_words(100), //descricao
                rnd.rnd.gen_range(1..=n_desenvolvedores),
                rnd.rnd.gen_range(1..=n_editoras),
            )
            .as_bytes(),
        )
        .unwrap();
    }
}

pub fn epoca_promocaos(n_promocoes: usize, random: &mut RandomGenerator) {
    let mut file = BufWriter::new(File::create(output_file(TABLES[9])).unwrap());
    for id in 1..=n_promocoes {
        let mut name = random.get_random_words(random.rnd.clone().gen_range(50..200));
        let dates = random.get_random_dates();
        file.write(
            format!(
                "INSERT INTO {} (ep_id, ep_nome, ep_data_inicio, ep_data_fim) \
                VALUES ({},\'{}\', \'{}\', \'{}\');\n",
                TABLES[9],
                id,
                name.escape_especial(),
                dates.0,
                dates.1,
            )
            .as_bytes(),
        )
        .unwrap();
    }
}

pub fn historico_sessoes(
    n_historico_sessoes: usize,
    n_produtos: usize,
    n_jogadores: usize,
    random: &mut RandomGenerator,
) {
    let mut file = BufWriter::new(File::create(output_file(TABLES[10])).unwrap());
    for id in 1..=n_historico_sessoes {
        let timestamps = random.get_random_timestamps();
        file.write(
            format!(
                "INSERT INTO {} (sj_id, sj_data_inicio, \
                sj_data_fim, produtos_pr_id, jogador_j_id) \
                VALUES ({}, \'{}\', \'{}\', {}, {});\n",
                TABLES[10],
                id,
                timestamps.0,
                timestamps.1,
                random.rnd.gen_range(1..=n_produtos),
                random.rnd.gen_range(1..=n_jogadores),
            )
            .as_bytes(),
        )
        .unwrap();
    }
}

pub fn despesas(n_despesas: usize, random: &mut RandomGenerator) {
    let mut file = BufWriter::new(File::create(output_file(TABLES[11])).unwrap());
    for id in 1..=n_despesas {
        let timestamp = random.get_random_timestamps().0;
        file.write(
            format!(
                "INSERT INTO {} (d_id, d_data, d_valor) \
                VALUES ({}, \'{}\', {:.2});\n",
                TABLES[11],
                id,
                timestamp,
                random.rnd.gen_range(0.0..99999.99)
            )
            .as_bytes(),
        )
        .unwrap();
    }
}

pub fn vendas(
    n_vendas: usize,
    n_produtos: usize,
    n_jogadores: usize,
    random: &mut RandomGenerator,
) {
    let mut file = BufWriter::new(File::create(output_file(TABLES[12])).unwrap());

    for id in 1..=n_vendas {
        let data_hora = random.get_random_timestamps().0;
        let preco = random.rnd.gen_range(0.0..=69420.00);
        file.write(
            format!(
                "INSERT INTO {} (ve_id, ve_data_hora, ve_preco, ve_desconto, produtos_pr_id, jogador_j_id) \
                VALUES ({}, \'{}\', {:.2}, {}, {}, {});\n",
                TABLES[12],
                id,
                data_hora,
                preco,
                random.rnd.gen_range(0..=100),//desconto
                random.rnd.gen_range(1..=n_produtos),//produto_id
                random.rnd.gen_range(1..=n_jogadores),//jogador_id
            )
            .as_bytes(),
        )
        .unwrap();
    }
}
