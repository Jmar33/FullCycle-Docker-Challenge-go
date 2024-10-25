FROM golang:1.23-alpine as builder

WORKDIR /usr/src/app

RUN go mod init example/hello

COPY . .

RUN  CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -gcflags=all=-l; stat -c %s hello

FROM scratch

COPY --from=builder /usr/src/app/hello /

ENTRYPOINT [ "/hello" ]

