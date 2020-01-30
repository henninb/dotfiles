use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;

fn parse_line(line: &str) {
    let split = line.split("|");
    for s in split {
        println!("{}", s)
    }
    println!("{}", line);
}

//https://play.rust-lang.org/?gist=63908c351a8c1038b07a9edc3a30ff16&version=stable
fn read_file(ifp: File) -> Result<(), Error> {
    let reader = BufReader::new(&ifp);
    let lines: Vec<_> = reader.lines().collect();
    for line in lines {
        //println!("{}", line?);
        parse_line(&line?.to_string());
    }
    Ok(())
}

fn read_by_line(filename: &str) -> Result<(), Error> {
    let file = File::open(filename).expect("file not found");
    read_file(file)
}

fn main() -> Result<(), Error> {
    read_by_line("input")
}
