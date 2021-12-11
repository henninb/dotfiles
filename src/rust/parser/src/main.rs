extern crate csv;
use std::fs;
use std::fs::File;
use std::error::Error;
use csv::ReaderBuilder;

#[allow(dead_code)]
struct Book {
    title: String,
    author: String,
    subject: String,
    book_id: u32,
}

#[allow(dead_code)]
type ParsedLine = ((String, String), usize);

fn file_read_csv(fname: String) -> Result<(), Box<dyn Error>> {
    let file = File::open(fname).expect("Couldn't open input");
    let mut records = ReaderBuilder::new()
        .has_headers(false)
        .delimiter(b'|')
        .from_reader(file);
    //let mut records = csv::Reader::from_reader(file); //.delimiter(b'|').has_headers(false);
    for result in records.records() {
        // The iterator yields Result<StringRecord, Error>, so we check the error here.
        let record = result?;
        println!("{:?}", record);
        for name in record.iter() {
            println!("{:?}", name);
        }
    }
    Ok(())
}

#[allow(dead_code)]
fn example(fname : String) -> Result<(), Box<dyn Error>> {
    let file = File::open(fname).expect("Couldn't open input");
    let mut rdr = ReaderBuilder::new()
        .has_headers(false)
        .delimiter(b'|')
        .from_reader(file);
        //.from_reader(data.as_bytes());

    if let Some(result) = rdr.records().next() {
        let record = result?;
        //assert_eq!(record, vec!["Boston", "United States", "4628910"]);
        println!("{:?}", record);
        Ok(())
    } else {
        Err(From::from("expected at least one record but got none"))
    }
}

fn file_read(input_filename: String) {

    let contents = fs::read_to_string(input_filename)
        .expect("Something went wrong reading the file");
    println!("{}", contents);
    let x = parse_line("one|two|three".to_string());
}
//https://stackoverflow.com/questions/43887908/how-to-read-and-process-a-pipe-delimited-file-in-rust
fn parse_line(line: String) -> Option<ParsedLine> {
    let mut fields = line
        .split('|')
        .map(str::trim);
    if let (Some(fa), Some(fb), Some(fc)) = (fields.next(), fields.next(), fields.next()) {
        fb.parse()
            .ok()
            .map(|v| ((fa.to_string(), fc.to_string()), v))
    } else {
        None
    }
}

fn main() {
 //   file_read("books.txt".to_string());
    file_read_csv("books.txt".to_string());
//    example("books.txt".to_string());
}
