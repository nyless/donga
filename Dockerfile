FROM       golang:latest AS builder
ARG        CFLAGS="-s -w"
WORKDIR    /src
COPY      ./main.go /src
RUN        go build -ldflags "$CFLAGS" /src/main.go

FROM       centos:latest
ARG        VERSION=1.0
WORKDIR    /validity
LABEL      Version=$VERSION
COPY     --from=builder /src/main /main
EXPOSE     4000/tcp
ENTRYPOINT /validity/msgparser 
