FROM fsharp

WORKDIR /app

COPY example.fs /app

RUN fsharpc example.fs

ENTRYPOINT ["mono", "/app/example.exe"]
