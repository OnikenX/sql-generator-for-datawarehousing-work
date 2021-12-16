use std::{
    fs::{read_to_string, File},
    io::{BufWriter, Write},
    panic,
};

use rand::prelude::{IteratorRandom, SliceRandom};

use crate::{
    general_utils::{RandomGenerator, TreatString},
    PREFIX,
};

pub(crate) fn output_file(name: &str) -> String {
    format!("{}/sqlInject_{}.sql", PREFIX, name)
}

pub(crate) fn valores_unicos(
    nome: &str,
    limit_size: usize,
    campos: &str,
    input_file_name: &str,
) -> usize {
    //criação do sistemas_operatos
    let input_file = read_to_string(input_file_name).unwrap();
    let mut file = BufWriter::new(File::create(output_file(nome)).unwrap());

    let mut n_rows = 0usize;

    for campo in input_file.lines() {
        n_rows += 1;
        file.write(
            format!(
                "INSERT INTO {} {}
            VALUES ({},\'{}\');\n",
                nome,
                campos,
                n_rows,
                campo
                    .to_string()
                    .escape_especial()
                    .remove_parentecies()
                    .adjust_size(limit_size)
            )
            .as_bytes(),
        )
        .unwrap();
    }
    n_rows
}

pub(crate) fn valores_unicos_com_desc(
    nome: &str,
    campos: &str,
    input_file_name: &str,
    limit_desc: usize,
    rnd: &mut RandomGenerator,
) -> usize {
    //criação do sistemas_operatos
    let input_file = read_to_string(input_file_name).unwrap();
    let mut file = BufWriter::new(File::create(output_file(nome)).unwrap());
    let mut n_rows = 0usize;
    for campo in input_file.lines() {
        n_rows += 1;
        file.write(
            format!(
                "INSERT INTO {} {}
            VALUES ({},\'{}\', \'{}\');\n",
                nome,
                campos,
                n_rows,
                campo.to_string().escape_especial().remove_parentecies(),
                rnd.get_random_words(limit_desc),
            )
            .as_bytes(),
        )
        .unwrap();
    }
    n_rows
}

pub(crate) fn valores_unicos_com_multi_desc(
    nome: &str,
    campos: &str,
    lines_to_generate: usize,
    limits: &Vec<usize>,
    rnd: &mut RandomGenerator,
) {
    //criação do sistemas_operatos
    let mut file = BufWriter::new(File::create(output_file(nome)).unwrap());
    for n_rows in 1..=lines_to_generate {
        let mut line = format!("INSERT INTO {} {} VALUES ({}", nome, campos, n_rows);
        for limit in limits {
            line += &format!(",\'{}\'", rnd.get_random_words(*limit));
        }
        line += ");\n";
        file.write(line.as_bytes()).unwrap();
    }
}

/// creates `n_juntions` tables with the name `table_name`
/// with the random selection from the range 1..=`n_table1`
/// and 1..=`n_table2` with the names `other_tables`
pub fn table_junction(
    n_junctions: usize,
    table_name: &str,
    other_tables: &str,
    n_table1: usize,
    n_table2: usize,
    unicos: u8,
    rnd: &mut RandomGenerator,
) {
    let mut file = BufWriter::new(File::create(output_file(table_name)).unwrap());

    let mut combinations = vec![];
    match unicos {
        0 => {
            for t1 in 1..=n_table1 {
                for t2 in 1..=n_table2 {
                    combinations.push((t1, t2));
                }
            }
        }
        1 => {
            for t1 in 1..=n_table1 {
                combinations.push((t1, (1..=n_table2).choose(&mut rnd.rnd).unwrap()));
            }
        }
        2 => {
            for t2 in 1..=n_table2 {
                combinations.push(((1..=n_table1).choose(&mut rnd.rnd).unwrap(), t2));
            }
        }
        _ => panic!("Impossible lol"),
    }

    let iter = if n_junctions < combinations.len() {
        combinations.choose_multiple(&mut rnd.rnd, n_junctions)
    } else {
        combinations.choose_multiple(&mut rnd.rnd, combinations.len())
    };

    for comb in iter {
        file.write(
            format!(
                "INSERT INTO {} {}
            VALUES ({}, {});\n",
                table_name, other_tables, comb.0, comb.1,
            )
            .as_bytes(),
        )
        .unwrap();
    }
}
