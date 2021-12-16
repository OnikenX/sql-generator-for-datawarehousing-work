use std::{
    fs::File,
    io::{BufWriter, Write},
    process::Command,
};

use general_utils::RandomGenerator;
use genericos::{
    output_file, table_junction, valores_unicos, valores_unicos_com_desc,
    valores_unicos_com_multi_desc,
};
use misc::{despesas, epoca_promocaos, historico_sessoes, produtos, vendas};
use pessoas::jogadores;

pub mod general_utils;
pub mod genericos;
mod misc;
mod pessoas;

const PREFIX: &str = "./scripts-db/";

const TABLES: [&str; 22] = [
    "genero",                     //0
    "editora",                    //1
    "sistema_operativo",          //2
    "categorias",                 //3
    "desenvolvedor",              //4
    "fornecedor",                 //5
    "rubrica",                    //6
    "jogador",                    //7
    "produtos",                   //8
    "epoca_promocao",             //9
    "historico_sessoes",          //10
    "despesas",                   //11
    "vendas",                     //12
    "despesas_rubrica",           //13
    "fornecedor_despesas",        //14
    "despesas_produtos",          //15
    "vendas_epoca_promocao",      //16
    "jogador_produtos",           //17
    "produtos_epoca_promocao",    //18
    "categorias_produtos",        //19
    "sistema_operativo_produtos", //20
    "produtos_genero",            //21
];
fn main() {
    let mut random = RandomGenerator::new();
    // let dates = random.get_random_timestamps();
    // println!("{} , {}", &dates.0, &dates.1);
    generate_sql_injects(&mut random);
}

fn generate_sql_injects(random: &mut RandomGenerator) {

    let _ = Command::new("mkdir").args(["-p", PREFIX]).output().unwrap();

    let n_generos = valores_unicos(TABLES[0], 35, "(g_id, g_nome)", "genres");
    let n_editoras = valores_unicos(TABLES[1], 50, "(e_id, e_nome)", "publishers_full");
    let n_so = valores_unicos(TABLES[2], 20, "(s_id, s_nome)", "sistemas_operativos");
    let n_categorias = valores_unicos(TABLES[3], 25, "(c_id, c_nome)", "genres");
    let n_rubricas = 100usize;
    let n_jogadores = 100usize;
    let n_produtos = 100usize;
    let n_promocoes = 50;
    let n_historico_sessoes = 5;
    let n_despesas = 10;
    let n_vendas = 50;
    let n_junctions = 500;
    let n_desenvolvedores = valores_unicos_com_desc(
        TABLES[4],
        "(ds_id, ds_nome, ds_descricao)",
        "developers",
        256,
        random,
    );
    let n_fornecedores = valores_unicos_com_desc(
        TABLES[5],
        "(f_id, f_nome, f_especialidade)",
        "fornecedores",
        25,
        random,
    );

    valores_unicos_com_multi_desc(
        TABLES[6],
        "(r_id, r_descricao, r_observacoes)",
        n_rubricas,
        &vec![25, 110],
        random,
    );
    jogadores(n_jogadores, random);
    produtos(n_produtos, random, n_desenvolvedores, n_editoras);
    epoca_promocaos(50, random);
    historico_sessoes(n_historico_sessoes, n_produtos, n_jogadores, random);
    despesas(n_despesas, random);
    vendas(n_vendas, n_produtos, n_jogadores, random);
    table_junction(
        n_junctions,
        TABLES[13],
        "(despesas_d_id, rubrica_r_id)",
        n_despesas,
        n_rubricas,
        0,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[14],
        "(fornecedor_f_id, despesas_d_id)",
        n_fornecedores,
        n_despesas,
        0,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[15],
        "(despesas_d_id, produtos_pr_id)",
        n_despesas,
        n_produtos,
        1,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[16],
        "(vendas_ve_id, epoca_promocao_ep_id)",
        n_vendas,
        n_promocoes,
        1,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[17],
        "(jogador_j_id, produtos_pr_id)",
        n_jogadores,
        n_produtos,
        0,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[18],
        "(produtos_pr_id, epoca_promocao_ep_id)",
        n_produtos,
        n_promocoes,
        1,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[19],
        "(categorias_c_id, produtos_pr_id)",
        n_categorias,
        n_produtos,
        0,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[20],
        "(sistema_operativo_s_id, produtos_pr_id)",
        n_so,
        n_produtos,
        0,
        random,
    );
    table_junction(
        n_junctions,
        TABLES[21],
        "(produtos_pr_id, genero_g_id)",
        n_produtos,
        n_generos,
        0,
        random,
    );

    let mut sql_files = vec![format!("{}/tables_generator.sql", PREFIX)];
    for table in TABLES {
        sql_files.push(output_file(table));
    }

    let all_code = Command::new("cat").args(sql_files).output().unwrap();
    let mut file = BufWriter::new(File::create(format!("{}/all.sql", PREFIX)).unwrap());
    file.write_all(&all_code.stdout).unwrap();
}
