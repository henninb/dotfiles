extern crate csv;
use std::fs;
use std::fs::File;
use std::error::Error;
use csv::ReaderBuilder;

type ParsedLine = ((String, String), usize);

fn file_read_csv(fname: String) -> Result<(), Box<dyn Error>> {
    let file = File::open(fname).expect("Couldn't open input");
    let mut records = ReaderBuilder::new()
        .has_headers(false)
        .delimiter(b'|')
        .from_reader(file);

    for result in records.records() {
        let record = result?;
        println!("{:?}", record);
        for name in record.iter() {
            println!("{:?}", name);
        }
    }
    Ok(())
}

fn parse_line(line: String) -> Option<ParsedLine> {
    let mut fields = line
        .split('|')
        .map(str::trim);
    if let (Some(fa), Some(fb), Some(fc)) = (fields.next(), fields.next(), fields.next()) {
        return fb.parse()
            .ok()
            .map(|v| ((fa.to_string(), fc.to_string()), v));
    } else {
        return None;
    }
}

fn file_read(input_filename: String) {

    let contents = fs::read_to_string(input_filename)
        .expect("Something went wrong reading the file");
    println!("{}", contents);
    let x = parse_line("one|2|three".to_string());
    println!("{:?}", x);
}

fn main() {
    file_read_csv("books.txt".to_string());
    file_read("books.txt".to_string());
}
