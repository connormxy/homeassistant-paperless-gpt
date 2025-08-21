ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set working directory
WORKDIR /app

# Copy the application source
COPY app/ .

# Install dependencies
RUN apk add --no-cache go musl-dev gcc

# Build the application
RUN CGO_ENABLED=1 GOMAXPROCS=$(nproc) go build -tags musl -o paperless-gpt .

# Copy run.sh
COPY paperless-gpt/run.sh /
RUN chmod a+x /run.sh

# Start the application
CMD [ "/run.sh" ]
