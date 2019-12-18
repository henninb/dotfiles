#![allow(clippy::needless_pass_by_value)]
#[macro_use]
extern crate json;
extern crate log;
extern crate env_logger;
extern crate dotenv;
extern crate log4rs;
//extern crate actix_rt;

use actix_web::{Responder, error, get, middleware, web, App, Error, HttpRequest, HttpResponse, HttpServer};
use bytes::BytesMut;
use futures::{Future, Stream};
use json::JsonValue;
use serde_derive::Deserialize;
use serde_derive::Serialize;
//use log::{info, warn, error};
use log::info;
use std::env;
use dotenv::dotenv;
use std::sync::Mutex;

#[derive(Debug, Serialize, Deserialize)]
struct MyObj {
    name: String,
    number: i32,
}

#[allow(non_snake_case)]
#[derive(Serialize, Deserialize)]
struct Transaction {
  guid: String,
  accountType: String,
  accountNameOwner: String,
  description: String,
  category: String,
  notes: String,
  cleared: i8,
  amount: String,
  transactionDate: u32,
  reoccurring: bool
}

//const MAX_SIZE: usize = 262_144; // max payload size is 256k

// #[get("/{name}/index.html")]
// async fn index(info: web::Path<(u32, String)>) -> impl Responder {
//     println!("got here");
//     info!("got here");
//     format!("Name {}", info.0);
// }

/// simple handle
async fn index(state: web::Data<Mutex<usize>>, req: HttpRequest) -> HttpResponse {
    println!("{:?}", req);
    *(state.lock().unwrap()) += 1;

    HttpResponse::Ok().body(format!("Num of requests: {}", state.lock().unwrap()))
}

fn index_handler(item: web::Json<MyObj>) -> HttpResponse {
    println!("got here");
    info!("got here");
    info!("model: {:?}", &item);
    HttpResponse::Ok().json(item.0)
}

// fn get_env_var(key: &str) -> String {
//    match env::var(key) {
//     Ok(x)  => return x,
//     Err(_) => panic!("Failure to set the value for key {}", key)
//    };
// }

fn item_handler(item: web::Json<MyObj>, req: HttpRequest) -> HttpResponse {
    println!("got here");
    info!("request: {:?}", req);
    info!("model: {:?}", item);

    HttpResponse::Ok().json(item.0) // <- send json response
}

// This handler manually load request payload and parse json object
// fn index_manual( payload: web::Payload,) -> impl Future<Item = HttpResponse, Error = Error> {
//     payload
//         // `Future::from_err` acts like `?` in that it coerces the error type from
//         // the future into the final error type
//         .from_err()
//         // `fold` will asynchronously read each chunk of the request body and
//         // call supplied closure, then it resolves to result of closure
//         .fold(BytesMut::new(), move |mut body, chunk| {
//             // limit max size of in-memory payload
//             if (body.len() + chunk.len()) > MAX_SIZE {
//                 Err(error::ErrorBadRequest("overflow of max body length"))
//             } else {
//                 body.extend_from_slice(&chunk);
//                 Ok(body)
//             }
//         })
//         // `Future::and_then` can be used to merge an asynchronous workflow with a
//         // synchronous workflow
//         .and_then(|body| {
//             // body is loaded, now we can deserialize serde-json
//             let obj = serde_json::from_slice::<MyObj>(&body)?;
//             Ok(HttpResponse::Ok().json(obj))
//         })
// }

// This handler manually load request payload and parse json-rust
// fn index_mjsonrust(pl: web::Payload) -> impl Future<Item = HttpResponse, Error = Error> {
//     pl.concat2().from_err().and_then(|body| {
//         // body is loaded, now we can deserialize json-rust
//         let result = json::parse(std::str::from_utf8(&body).unwrap()); // return Result
//         let injson: JsonValue = match result {
//             Ok(v) => v,
//             Err(e) => json::object! {"err" => e.to_string() },
//         };
//         Ok(HttpResponse::Ok()
//             .content_type("application/json")
//             .body(injson.dump()))
//     })
// }

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "actix_web=info");
    env_logger::init();

    let counter = web::Data::new(Mutex::new(0usize));

    //move is necessary to give closure below ownership of counter
    HttpServer::new(move || {
        App::new()
            .register_data(counter.clone()) // <- create app with shared state
            // enable logger
            .wrap(middleware::Logger::default())
            // register simple handler, handle all methods
            .service(web::resource("/").to(index))
    })
    .bind("127.0.0.1:8080")?
    .start()
    .await
}

//#[actix_rt::main]
//async fn main() -> std::io::Result<()> {
////fn main() -> std::io::Result<()> {
//    //std::env::set_var("RUST_LOG", "actix_web=info");
//    dotenv().ok();
//    env_logger::init();
//    match env::var("MY_VALUE") {
//        Ok(lang) => println!("My value={}", lang),
//        Err(e) => println!("Couldn't read MY_VALUE ({})", e),
//    };

//    info!("localhost:8081");
//    // let my_value = get_env_var("MY_VALUE");
//    // println!("{}", my_value);

//    // for (key, value) in env::vars() {
//    //     println!("{}: {}", key, value);
//    // }

//    dotenv::dotenv().expect("Failed to read .env file");

//    info!("localhost:8081");
//    HttpServer::new(|| {
//        App::new()
////            .wrap(middleware::Logger::default())
//            .data(web::JsonConfig::default().limit(4096)) // <- limit size of the payload (global configuration)
//            .service(web::resource("/me").route(web::post().to(index_handler)))
//            //.service( web::resource("/action").data(web::JsonConfig::default().limit(1024)).route(web::post().to_async(item_handler)))
//            .service(web::resource("/").route(web::post().to(index)))
//    })
//    .bind("127.0.0.1:8081")?
//    //.run()
//    .await
//}
