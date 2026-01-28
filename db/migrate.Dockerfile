# Dockerfile for migrate with sqlite3 support
FROM golang:1.24-alpine AS builder

RUN apk add --no-cache gcc musl-dev sqlite-dev git

WORKDIR /src

ENV CGO_ENABLED=1
RUN go install -tags 'sqlite3' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

FROM alpine:latest
RUN apk add --no-cache ca-certificates sqlite

WORKDIR /work
COPY --from=builder /go/bin/migrate /usr/local/bin/migrate

ENTRYPOINT ["migrate"]
