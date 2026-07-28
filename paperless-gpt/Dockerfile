# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG PAPERLESS_GPT_VERSION="v0.27.0"
ARG BUILD_ARCH=amd64
ARG BUILD_FROM="ghcr.io/home-assistant/${BUILD_ARCH}-base-alpine:3.21"

# Stage 1: Get the upstream built application
FROM icereed/paperless-gpt:${PAPERLESS_GPT_VERSION} AS builder

# Stage 2: Final Home Assistant base image
FROM $BUILD_FROM

LABEL \
  org.opencontainers.image.title="Home Assistant Add-on: Paperless-GPT" \
  org.opencontainers.image.description="AI-powered companion for Paperless-NGX to automatically categorize and extract metadata from your documents." \
  org.opencontainers.image.source="https://github.com/connormxy/homeassistant-paperless-gpt" \
  org.opencontainers.image.licenses="MIT License"

# Install runtime dependencies required by paperless-gpt
RUN apk add --no-cache ca-certificates

WORKDIR /app

# Copy the binary and frontend from the builder stage
COPY --from=builder /app /app

# Set the environment
ENV GIN_MODE=release

# We'll map the upstream data path to the shared config/data directory later in the run script.
ENV DATA_DIR=/config/data

# Copy the rootfs (s6-overlay services, bashio scripts)
COPY rootfs /

# Ensure s6 run script is executable (Windows file creation workaround)
RUN chmod a+x /etc/s6-overlay/s6-rc.d/paperless-gpt/run

# Expose the web UI port
EXPOSE 8080
