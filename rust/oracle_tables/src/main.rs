extern crate log;
extern crate oracle;

use log::{info, trace, warn};
use oracle::Connection;
use std::env;
use std::fs::File;
use std::io::Write;
use std::io::{BufRead, BufReader};
//use std::io::Error;
//use std::env::VarError;
//use std::option;
//use std::io::BufWriter;
//use std::fs::OpenOptions;

fn get_env_var(key: &str) -> String {
    match env::var(key) {
        Ok(x) => return x,
        Err(_) => panic!("Failure to set the value for key {}", key),
    };
}

fn open_file(filename: &str) -> File {
    match File::open(filename) {
        Ok(f) => return f,
        Err(_) => panic!("file {} is not found.", filename),
    }
}

fn main() {
    const UPGRADES: &'static [&'static str] = &["list"];
    let username = "";
    let passwd_key = "ORACLE_PASS";
    let sites_filename = "site.txt";
    let port = "1522";
    let owner = "";
    let table_list_sql = format!(
        "SELECT table_name FROM dba_tables WHERE owner = '{}' ORDER BY table_name",
        owner
    );
    let file = open_file(sites_filename);
    for line in BufReader::new(file).lines() {
        let str_line = match line {
            Ok(ln) => ln,
            Err(e) => panic!("{:?}", e),
        };

        info!("{}", str_line);
        let site = &str_line;
        let passwd = get_env_var(passwd_key);
        let mut servername = format!("rclp{}", site);
        if UPGRADES.contains(&str_line.as_str()) {
            servername = format!("racp{}", site);
        }
        let service_name = format!("DDDP{}", site);
        let connection_string = format!("(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={})(PORT={}))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME={})))", servername, port, service_name);

        let conn = match Connection::connect(username, passwd, connection_string) {
            Ok(cn) => cn,
            Err(e) => panic!("{:?}", e),
        };
        let table_list_rows = match conn.query(&table_list_sql, &[]) {
            Ok(rs) => rs,
            Err(e) => panic!("{:?}", e),
        };

        let mut table_list: Vec<String> = Vec::new();
        for row_result in table_list_rows {
            for (idx, val) in row_result.unwrap().sql_values().iter().enumerate() {
                if idx != 0 {
                    print!(" {:14}|", "");
                }
                table_list.push(val.to_string());
                println!("{}", val);
            }
        }

        for table_name in &table_list {
            let package_sql = format!("SELECT column_name, data_type, data_length FROM all_tab_cols WHERE owner = '{}' and table_name = '{}' AND column_id IS NOT NULL", owner, table_name);
            let ofname = format!("t{}-{}_COLUMNS.sql", site, table_name);
            let mut file = std::fs::File::create(ofname).expect("creating a file failed");
            let table_col_rows = conn.query(&package_sql, &[]).unwrap();

            for row_result in table_col_rows {
                for (idx, val) in row_result.unwrap().sql_values().iter().enumerate() {
                    if idx != 0 {
                        print!(" {:14}|", "");
                    }
                    print!("{}", val);
                    info!("val: {}", val.to_string());
                    file.write_all(val.to_string().as_bytes())
                        .expect("write failed");
                    file.write_all("|".as_bytes()).expect("write failure");
                }
                file.write_all("\n".as_bytes()).expect("write failure");
            }
        }

        match conn.close() {
            Err(e) => {
                warn!("something went wrong.");
                panic!("{:?}", e)
            }
            _ => (),
        }
    }
}
