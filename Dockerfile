FROM  golang:alpine as builder

RUN apk update
WORKDIR /app

RUN apk add git
RUN git clone https://github.com/paullooabreu/arquivos-publicos.git

FROM alpine

RUN mkdir -p $HOME/go/{bin,src}
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
ENV PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

WORKDIR /app

COPY --from=builder /app/arquivos-publicos /app
COPY --from=builder /usr/local/go/src /usr/local/go/src
COPY --from=builder /usr/local/go/pkg /usr/local/go/pkg
COPY --from=builder /usr/local/go/bin /usr/local/go/bin
ENTRYPOINT ["go", "run", "fullcycle.go"]
