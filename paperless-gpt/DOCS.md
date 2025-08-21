# Paperless-GPT Home Assistant Add-on Documentation

This document provides instructions on how to install and configure the Paperless-GPT Home Assistant add-on.

## Installation

1. Add the add-on repository to your Home Assistant instance:
   ```
   https://github.com/zeltilla/paperless-gpt-ha-addon
   ```
2. Install the "Paperless-GPT" add-on.
3. Configure the add-on with your Paperless-ngx URL and API token.
4. Start the add-on.

## Configuration

The add-on can be configured through the Home Assistant UI. Here are some of the key options:

- **`PAPERLESS_BASE_URL`**: The URL of your Paperless-ngx instance. This is required.
- **`PAPERLESS_API_TOKEN`**: The API token for your Paperless-ngx instance. This is required.
- **`LLM_PROVIDER`**: The large language model provider to use. The add-on supports `openai`, `ollama`, `googleai`, and `mistral`.
- **`OLLAMA_HOST`**: If you are using `ollama`, this should be the URL of your Ollama instance.
- **`OPENAI_API_KEY`**: If you are using `openai`, this should be your OpenAI API key.

For a full list of configuration options, please see the add-on's configuration page.
