FROM openjdk:8-jdk-alpine
RUN apk add --update-cache \
    curl \
    maven \
    git \
    docker \
    bind-tools
ENTRYPOINT ["sleep", "600"]
