#!/usr/bin/env bashio

# Get all options from the add-on configuration
CONFIG_OPTIONS=$(bashio::config)

# Export each option as an environment variable
for key in $(echo "${CONFIG_OPTIONS}" | jq -r 'keys | .[]'); do
    value=$(echo "${CONFIG_OPTIONS}" | jq -r ".${key}")
    export "${key^^}"="${value}"
    bashio::log.info "Setting ${key^^} to ${value}"
done

# Start the application
/app/paperless-gpt
