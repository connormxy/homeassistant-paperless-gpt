# Home Assistant Add-on: Paperless-GPT (DEV)

AI-powered companion for Paperless-NGX to automatically categorize and extract metadata from your documents.

## About

This Home Assistant add-on wraps [icereed/paperless-gpt](https://github.com/icereed/paperless-gpt). It uses local or cloud LLMs to process documents stored in your Paperless-NGX instance and applies automatic tagging, correspondents, and document types.

## Configuration

This add-on connects to your Paperless-NGX instance and your chosen LLM provider.

1. **PAPERLESS_BASE_URL**: URL of your paperless-ngx instance (e.g. `http://paperless-ngx:8000`).
2. **PAPERLESS_API_TOKEN**: API token for paperless-ngx. Generate one in paperless-ngx admin.
3. **LLM_PROVIDER**: Your AI backend (`openai`, `ollama`, `googleai`, `mistral`, or `anthropic`).
4. **LLM_MODEL**: Your chosen AI model name (e.g. `gpt-4o`).
5. **API Keys**: Provide the appropriate API key for your chosen provider.

**Note**: To use Ollama, ensure your Ollama server is accessible from this add-on container.

For more advanced configuration details, consult the upstream documentation.

## Support

Got questions? Please check the [upstream paperless-gpt repository](https://github.com/icereed/paperless-gpt) for application-specific issues, or the add-on repository for integration issues.
