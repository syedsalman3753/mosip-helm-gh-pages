FROM alpine:3.18.4

RUN apk --no-cache add git wget &&\
    wget https://github.com/helm/chart-testing/releases/download/v3.9.0/chart-testing_3.9.0_linux_amd64.tar.gz &&\
    tar xvzf chart-testing*.tar.gz &&\
    cp ct /bin/

COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
