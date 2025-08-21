#!/usr/bin/with-contenv bashio

# Set environment variables from config options
export PAPERLESS_BASE_URL=$(bashio::config 'PAPERLESS_BASE_URL')
export PAPERLESS_API_TOKEN=$(bashio::config 'PAPERLESS_API_TOKEN')
export LLM_PROVIDER=$(bashio::config 'LLM_PROVIDER')
export LLM_MODEL=$(bashio::config 'LLM_MODEL')
export OPENAI_API_KEY=$(bashio::config 'OPENAI_API_KEY')
export OLLAMA_HOST=$(bashio::config 'OLLAMA_HOST')
export PAPERLESS_INSECURE_SKIP_VERIFY=$(bashio::config 'PAPERLESS_INSECURE_SKIP_VERIFY')
export CORRESPONDENT_BLACK_LIST=$(bashio::config 'CORRESPONDENT_BLACK_LIST')
export AZURE_DOCAI_ENDPOINT=$(bashio::config 'AZURE_DOCAI_ENDPOINT')
export AZURE_DOCAI_KEY=$(bashio::config 'AZURE_DOCAI_KEY')
export AZURE_DOCAI_MODEL_ID=$(bashio::config 'AZURE_DOCAI_MODEL_ID')
export AZURE_DOCAI_TIMEOUT_SECONDS=$(bashio::config 'AZURE_DOCAI_TIMEOUT_SECONDS')
export AZURE_DOCAI_OUTPUT_CONTENT_FORMAT=$(bashio::config 'AZURE_DOCAI_OUTPUT_CONTENT_FORMAT')
export MANUAL_TAG=$(bashio::config 'MANUAL_TAG')
export AUTO_TAG=$(bashio::config 'AUTO_TAG')
export MANUAL_OCR_TAG=$(bashio::config 'MANUAL_OCR_TAG')
export AUTO_OCR_TAG=$(bashio::config 'AUTO_OCR_TAG')
export VISION_LLM_PROVIDER=$(bashio::config 'VISION_LLM_PROVIDER')
export VISION_LLM_MODEL=$(bashio::config 'VISION_LLM_MODEL')
export LOG_LEVEL=$(bashio::config 'LOG_LEVEL')
export LISTEN_INTERFACE=$(bashio::config 'LISTEN_INTERFACE')
export AUTO_GENERATE_TITLE=$(bashio::config 'AUTO_GENERATE_TITLE')
export AUTO_GENERATE_TAGS=$(bashio::config 'AUTO_GENERATE_TAGS')
export AUTO_GENERATE_CORRESPONDENTS=$(bashio::config 'AUTO_GENERATE_CORRESPONDENTS')
export AUTO_GENERATE_CREATED_DATE=$(bashio::config 'AUTO_GENERATE_CREATED_DATE')
export OCR_LIMIT_PAGES=$(bashio::config 'OCR_LIMIT_PAGES')
export TOKEN_LIMIT=$(bashio::config 'TOKEN_LIMIT')
export OCR_PROVIDER=$(bashio::config 'OCR_PROVIDER')
export GOOGLE_PROJECT_ID=$(bashio::config 'GOOGLE_PROJECT_ID')
export GOOGLE_LOCATION=$(bashio::config 'GOOGLE_LOCATION')
export GOOGLE_PROCESSOR_ID=$(bashio::config 'GOOGLE_PROCESSOR_ID')
export LLM_LANGUAGE=$(bashio::config 'LLM_LANGUAGE')
export PAPERLESS_PUBLIC_URL=$(bashio::config 'PAPERLESS_PUBLIC_URL')

PROMPTS_DIR="/config/prompts"
mkdir -p "$PROMPTS_DIR"

# Create default prompts if they don't exist
cat > "$PROMPTS_DIR/title_prompt.tmpl" <<'EOF'
I will provide you with the content of a document that has been partially read by OCR (so it may contain errors).
Your task is to find a suitable document title that I can use as the title in the paperless-ngx program.
Respond only with the title, without any additional information. The content is likely in {{.Language}}.

Content:
{{.Content}}
EOF

cat > "$PROMPTS_DIR/tag_prompt.tmpl" <<'EOF'
I will provide you with the content and the title of a document. Your task is to select appropriate tags for the document from the list of available tags I will provide. Only select tags from the provided list. Respond only with the selected tags as a comma-separated list, without any additional information. The content is likely in {{.Language}}.

Available Tags:
{{.AvailableTags | join ", "}}

Title:
{{.Title}}

Content:
{{.Content}}

Please concisely select the {{.Language}} tags from the list above that best describe the document.
Be very selective and only choose the most relevant tags since too many tags will make the document less discoverable.
EOF

cat > "$PROMPTS_DIR/correspondent_prompt.tmpl" <<'EOF'
I will provide you with the content of a document. Your task is to suggest a correspondent that is most relevant to the document.

Correspondents are the senders of documents that reach you. In the other direction, correspondents are the recipients of documents that you send.
In Paperless-ngx we can imagine correspondents as virtual drawers in which all documents of a person or company are stored. With just one click, we can find all the documents assigned to a specific correspondent.
Try to suggest a correspondent, either from the example list or come up with a new correspondent.

Respond only with a correspondent, without any additional information!

Be sure to choose a correspondent that is most relevant to the document.
Try to avoid any legal or financial suffixes like "GmbH" or "AG" in the correspondent name. For example use "Microsoft" instead of "Microsoft Ireland Operations Limited" or "Amazon" instead of "Amazon EU S.a.r.l.".

If you can't find a suitable correspondent, you can respond with "Unknown".

Example Correspondents:
{{.AvailableCorrespondents | join ", "}}

List of Correspondents with Blacklisted Names. Please avoid these correspondents or variations of their names:
{{.BlackList | join ", "}}

Title of the document:
{{.Title}}

The content is likely in {{.Language}}.

Document Content:
{{.Content}}
EOF

cat > "$PROMPTS_DIR/created_date_prompt.tmpl" <<'EOF'
I will provide you with the content of a document. Your task is to find the date when the document was created.
Respond only with the date in YYYY-MM-DD format, without any additional information. If no day was found, use the first day of the month. If no month was found, use January. If no date was found at all, answer with today's date.
The content is likely in {{.Language}}. Today's date is {{.Today}}.

Content:
{{.Content}}
EOF

cat > "$PROMPTS_DIR/ocr_prompt.tmpl" <<'EOF'
Just transcribe the text in this image and preserve the formatting and layout (high quality OCR). Do that for ALL the text in the image. Be thorough and pay attention. This is very important. The image is from a text document so be sure to continue until the bottom of the page. Thanks a lot! You tend to forget about some text in the image so please focus! Use markdown format but without a code block.
EOF

# Run the application
/app/paperless-gpt
