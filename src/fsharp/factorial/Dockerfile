FROM fsharp

WORKDIR /app

COPY factorial.fs /app

RUN fsharpc factorial.fs

ENTRYPOINT ["mono", "/app/factorial.exe"]
