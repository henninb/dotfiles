#FROM rust:1.31.0-nightly
FROM rust:latest

WORKDIR /usr/src/app
COPY . .

RUN cargo install --path .

CMD ["example_rest_json"]
