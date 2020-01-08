FROM golang:1.13.5-alpine as build

RUN apk --no-cache add git curl
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

RUN addgroup -g 10001 app && adduser -D -g '' -G app -s /bin/false -h /go/src/github.com/Telefonica/kube-graffiti -u 10001 app
WORKDIR /go/src/github.com/Telefonica/kube-graffiti

COPY . /go/src/github.com/Telefonica/kube-graffiti
RUN dep ensure -v
ENV CGO_ENABLED 0
RUN go test ./...
RUN go build -o kube-graffiti -ldflags '-s -w -extldflags "-static"' main.go

FROM alpine:3.11
LABEL maintainer="javier.provechofernandez@telefonica.com"

RUN addgroup -g 10001 app && adduser -D -g '' -G app -s /bin/false -h /app -u 10001 app
USER 10001
COPY --chown=app:app --from=build /go/src/github.com/Telefonica/kube-graffiti/kube-graffiti /app/kube-graffiti

ENTRYPOINT ["/app/kube-graffiti"]