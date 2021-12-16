use std::fs::read_to_string;

use rand::{
    prelude::{SliceRandom, ThreadRng},
    Rng,
};

pub trait TreatString {
    fn escape_especial(&mut self) -> &mut Self;
    fn remove_parentecies(&mut self) -> &mut Self;
    fn adjust_size(&mut self, size_limit: usize) -> &mut Self;
}

impl TreatString for String {
    fn escape_especial(&mut self) -> &mut Self {
        let mut i = 0usize;
        while i < self.len() {
            let mut skip = false;
            if let Some(c) = self.char_indices().find(|c| c.0 == i) {
                if c.1 == '\'' {
                    self.remove(c.0);
                    skip = true;
                }
            } else {
                break;
            }
            if !skip {
                i += 1;
            }
        }
        self
    }

    fn remove_parentecies(&mut self) -> &mut Self {
        let mut i = 0usize;
        let mut to_cut = (false, 0usize);
        while i < self.len() {
            if let Some(c) = self.char_indices().find(|c| c.0 == i) {
                if c.1 == '(' {
                    to_cut = (true, c.0);
                    break;
                }
            }
            i += 1;
        }
        if to_cut.0 {
            *self = self[0..to_cut.1].to_string();
        }
        self
    }

    fn adjust_size(&mut self, size_limit: usize) -> &mut Self {
        if self.as_bytes().len() >= size_limit {
            *self = String::from_utf8_lossy(&self.as_bytes()[0..size_limit]).to_string();
        }
        self
    }
}

pub struct RandomGenerator {
    // words_source : String,
    words: Vec<String>,
    pub rnd: rand::prelude::ThreadRng,
}
impl RandomGenerator {
    pub fn new() -> RandomGenerator {
        let lorem = read_to_string("lorem")
            .unwrap()
            .to_lowercase()
            .trim()
            .to_string();
        let words = lorem
            .split(&[' ', '\n', '.', '\t'][..])
            .map(|str| str.trim().to_string())
            .collect::<Vec<_>>();

        RandomGenerator {
            words: words,
            rnd: rand::thread_rng(),
        }
    }

    pub fn get_random_words(&mut self, size_limit: usize) -> String {
        let mut rnd_wrds = String::new();
        let mut idxs = (1..self.words.len()).collect::<Vec<_>>();
        idxs.shuffle(&mut self.rnd);
        for idx in idxs {
            let tmp_str = String::from(" ") + &self.words[idx];
            if tmp_str.as_bytes().len() + rnd_wrds.as_bytes().len() >= size_limit {
                break;
            }
            rnd_wrds += &tmp_str;
        }
        rnd_wrds.trim().to_owned()
    }

    pub fn get_random_dates(&mut self) -> (String, String) {
        let mut year = self.rnd.gen_range(2000..=2021);
        let mut month = self.rnd.gen_range(1..=12);
        let get_day = |rnd: &mut ThreadRng, month| match month % 2 {
            0 => {
                if month == 2 {
                    if year % 4 == 0 {
                        rnd.gen_range(1..29)
                    } else {
                        rnd.gen_range(1..28)
                    }
                } else {
                    rnd.gen_range(1..30)
                }
            }
            1 => rnd.gen_range(1..31),
            _ => panic!("Impossibru"),
        };
        let mut day = get_day(&mut self.rnd, month);

        let string1 = format!("{:0>4}-{:0>2}-{:0>2}", year, month, day);

        if self.rnd.gen_bool(0.2) {
            Self::next_month(&mut month, &mut year);
        }
        let range_days = self.rnd.gen_range(1..15);
        Self::increment_days(&mut year, &mut month,&mut day, range_days);

        (string1, format!("{:0>4}-{:0>2}-{:0>2}", year, month, day))
    }

    pub fn get_random_timestamps(&mut self) -> (String, String) {
        let mut date = self.get_random_dates().0;
        let mut hours = self.rnd.gen_range(0..24);
        let mut minutes = self.rnd.gen_range(0..60);
        let timestamp1 = format!("{} {:0>2}:{:0>2}:00+00", date, hours, minutes);

        let minutes_passed = self.rnd.gen_range(0..60);
        let mut hours_passed = self.rnd.gen_range(0..10);
        if minutes + minutes_passed >= 60 {
            hours_passed += 1;
            minutes += minutes_passed - 60;
        }else{
            minutes += minutes_passed;
        }
        
        if hours + hours_passed >= 24 {
            let date_values : Vec<&str> = date.as_str().split("-").collect();
            let mut year = date_values[0].parse().unwrap();
            let mut month = date_values[1].parse().unwrap();
            let mut day = date_values[2].parse().unwrap();
            Self::increment_days(&mut year, &mut month,&mut day, 1);
            date = format!("{:0>4}-{:0>2}-{:0>2}", &year, &month, &day);
            hours += hours_passed - 24;
        } else {
            hours += hours_passed;
        };
        let timestamp2 = format!("{} {:0>2}:{:0>2}:00+00", &date, &hours, &minutes);
        (timestamp1, timestamp2)
    }

    fn next_month(month: &mut i32, year: &mut i32) {
        if (*month + 1) > 12 {
            *year += 1;
            *month = 1;
        } else {
            *month += 1;
        }
    }

    fn increment_days(year: &mut i32, month: &mut i32, day: &mut i32, range_days: i32) {
        if (*day + range_days) > 29 && *month == 2 && *year % 4 == 0 {
            Self::next_month(month, year);
            *day += range_days - 29;
        } else if (*day + range_days) > 28 && *month == 2 {
            Self::next_month(month, year);
            *day += range_days - 28;
        } else if (*day + range_days) > 31 && *month % 2 == 0 {
            Self::next_month(month, year);
            *day += range_days - 31;
        } else if (*day + range_days) > 30 && *month % 2 == 1{
            Self::next_month(month, year);
            *day += range_days - 30;
        } else {
            *day += range_days;
        }
    }
}
