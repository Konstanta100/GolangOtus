FROM golang:1.16 AS builder
WORKDIR /go/src/GolangOtus
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix -mod=vendor -gcflags='all=-N -l' -o GolangOtus .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/GolangOtus .
CMD -- ./GolangOtus