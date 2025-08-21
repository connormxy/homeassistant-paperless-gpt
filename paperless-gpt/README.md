# Paperless-GPT Home Assistant Add-on

This add-on runs paperless-gpt, a private document assistant that uses generative AI to answer questions about your documents.

It is designed to be used with the [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) add-on and an LLM add-on like [Ollama](https://github.com/hassio-addons/addon-ollama).

## Configuration

The add-on can be configured through the Home Assistant UI. The following options are available:

- `LOG_LEVEL`: The log level for the application.
- `PAPERLESS_BASE_URL`: The URL of your paperless-ngx instance.
- `PAPERLESS_API_TOKEN`: The API token for your paperless-ngx instance.
- ...and many more. See the `config.yaml` for a full list of options.
