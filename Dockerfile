FROM golang:1.23-alpine as builder

WORKDIR /usr/src/app

RUN go mod init example/hello

COPY . .

RUN  CGO_ENABLED=0 GOOS=linux go build -o hello

FROM scratch

COPY --from=builder /usr/src/app/hello /

ENTRYPOINT [ "/hello" ]

