use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;

fn parse_line(line: &str) {
    let split = line.split("|");
    for s in split {
        println!("{}", s)
    }
    println!("{}", line);
}

//playground
//https://play.rust-lang.org/?gist=63908c351a8c1038b07a9edc3a30ff16&version=stable
fn readloop( ifp: File ) -> Result<(), std::io::Error> {
    let reader = BufReader::new(&ifp);
    let lines : Vec<_> = reader.lines().collect();
        for line in lines {
        //println!("{}", line?);
        parse_line(&line?.to_string());
    }
    Ok(())
}

fn read_by_line( fname: &str ) -> Result<(), std::io::Error> {
    let file = File::open(fname).expect("file not found");
    readloop(file)
}

fn main() -> Result<(), std::io::Error> {
    read_by_line("input")
}
