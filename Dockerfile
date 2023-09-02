FROM alpine:edge

WORKDIR /app

RUN apk update \
    && apk add git erlang \
    rust make cargo

# Download the Gleam source code git repository
RUN git clone https://github.com/gleam-lang/gleam

# Build the Gleam compiler. This will take some time!
RUN make -C /app/gleam install

RUN ln -s /app/gleam/target/release/gleam /bin/gleam

WORKDIR /workspace

COPY bin .

ENTRYPOINT ["gleam"]

CMD ["run", "main.gleam"]