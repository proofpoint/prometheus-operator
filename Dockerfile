FROM golang:1.13.4 as builder
ENV GO111MODULE=auto
WORKDIR /go/src/github.com/coreos/prometheus-operator

COPY . .
RUN make build
RUN ls -al


FROM quay.io/prometheus/busybox:latest

# On busybox 'nobody' has uid `65534'
USER 65534

COPY --from=builder /go/src/github.com/coreos/prometheus-operator/operator /bin/operator

ENTRYPOINT ["/bin/operator"]
