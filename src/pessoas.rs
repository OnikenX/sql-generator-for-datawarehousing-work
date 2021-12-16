use std::{
    fs::File,
    io::{BufWriter, Write},
};

use curl::easy::Easy;

use rand::Rng;
use serde::{Deserialize, Serialize};


use crate::{
    general_utils::{RandomGenerator, TreatString},
    genericos::output_file,
    TABLES,
};

#[derive(Debug, Serialize, Deserialize)]
struct Persons {
    results: Vec<Person>,
}
#[derive(Debug, Serialize, Deserialize)]

struct Person {
    gender: String,
    name: Name,
    location: Location,
    email: String,
    dob: DataOfBirth,
}

#[derive(Debug, Serialize, Deserialize)]
struct Location {
    // street: String,
    city: String,
    // state: String,
    // postcode: String,
    // coordinates: Coordinates,
    // timezone: Timezone,
    country: String,
}

#[derive(Debug, Serialize, Deserialize)]
struct DataOfBirth {
    date: String,
    age: u32,
}

// struct Timezone {
//     offset: String,
//     description: String,
// }
// struct Coordinates {
//     latitude: String,
//     longitude: String,
// }
#[derive(Debug, Serialize, Deserialize)]
struct Name {
    title: String,
    first: String,
    last: String,
}

struct JogadorDB {
    j_id: usize,
    j_nome: String, //65
    j_idade: u32,
    j_interesses: String, //256
    j_tempo_gasto: usize,
    j_montante_gasto: f64,
    j_nacionalidade: String, //25
    j_genero: u8,
    j_pais_residencia: String, //25
    j_carteira: u32,
}
pub fn jogadores(n_jogadores: usize, rnd: &mut RandomGenerator) {
    let name_size_limit = 64usize;
    let persons_results = download_persons(n_jogadores);
    let mut file = BufWriter::new(File::create(output_file(TABLES[7])).unwrap());
    let persons_json: Persons = serde_json::from_str(&persons_results).unwrap();
    let mut id = 0usize;
    for person_json in persons_json.results {
        id += 1;
        let nome = person_json.name;
        let mut nome_string = nome.first;
        let nome_size = nome_string.as_bytes().len();
        if nome.last.as_bytes().len() + nome_size + 1/*space*/ < name_size_limit {
            nome_string += " ";
            nome_string += &nome.last;
        }
        nome_string.adjust_size(name_size_limit).remove_parentecies().escape_especial();
        let mut country = person_json.location.country;
        country.adjust_size(25);
        let gender: u8 = match person_json.gender.as_str() {
            "male" => 0,
            "female" => 1,
            _ => 2,
        };
        let jog_db = JogadorDB {
            j_id: id,
            j_nome: nome_string,
            j_idade: person_json.dob.age,
            j_interesses: rnd.get_random_words(256),
            j_tempo_gasto: rnd.rnd.gen_range(0..69420),
            j_montante_gasto: rnd.rnd.gen_range(0.0..69420.0),
            j_nacionalidade: country.clone(),
            j_genero: gender,
            j_pais_residencia: country,
            j_carteira: rnd.rnd.gen_range(0..69420),
        };

        file.write(
            format!(
                "INSERT INTO {} (j_id, j_nome, j_idade, j_interesses, \
                j_tempo_gasto, j_montante_gasto, j_nacionalidade, \
                j_genero, j_pais_residencia, j_carteira) \
                VALUES ({},\'{}\', {}, \'{}\', {}, {}, \'{}\', {}, \'{}\', {});\n",
                TABLES[7],
                jog_db.j_id,
                jog_db.j_nome,
                jog_db.j_idade,
                jog_db.j_interesses,
                jog_db.j_tempo_gasto,
                jog_db.j_montante_gasto,
                jog_db.j_nacionalidade,
                jog_db.j_genero,
                jog_db.j_pais_residencia,
                jog_db.j_carteira
            )
            .as_bytes(),
        )
        .unwrap();
    }
}

pub fn download_persons(results: usize) -> String {
    let mut data = Vec::<u8>::new();
    let mut handle = Easy::new();
    let url = format!(
        "https://randomuser.me/api/?results={}&nat=us,dk,fr,gb",
        results
    );
    handle.url(&url).unwrap();
    {
        let mut transfer = handle.transfer();
        transfer
            .write_function(|new_data| {
                data.extend(new_data);
                Ok(new_data.len())
            })
            .expect("Can't define write function.");
        transfer.perform().expect("Can't make http request.");
    }
    let input = String::from_utf8(data).unwrap();
    if input.contains("\"Uh oh, something has gone wrong. Please tweet us @randomapi about the issue. Thank you.\"") {
        panic!("Something went wrong in reading the random person list.");
    }
    input
}
