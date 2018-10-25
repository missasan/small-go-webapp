# for build
FROM golang:1.10-alpine AS build

RUN apk update && apk upgrade \
    && apk add curl git

RUN go get github.com/go-chi/chi

WORKDIR /go/src/github.com/missasan/small-go-webapp
COPY . .

RUN go build -o small-go-webapp

# for artifacts
FROM golang:1.10-alpine
COPY --from=build /go/src/github.com/missasan/small-go-webapp/small-go-webapp /bin/small-go-webapp

EXPOSE 8080
RUN chmod +x /bin/small-go-webapp
CMD /bin/small-go-webapp
