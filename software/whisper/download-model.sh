#!/bin/bash
# Baixa modelo whisper.cpp GGML do Hugging Face.
# Uso: ./download-model.sh [modelo]
# Modelos: tiny base small medium large-v3-turbo large-v3
set -euo pipefail

MODEL="${1:-small}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MODELS_DIR="${SCRIPT_DIR}/data/models"
mkdir -p "${MODELS_DIR}"

BASE_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main"
FILENAME="ggml-${MODEL}.bin"
OUTPUT="${MODELS_DIR}/${FILENAME}"
OUTPUT_VAD="${MODELS_DIR}/ggml-silero-v6.2.0.bin"

if [ -f "${OUTPUT}" ]; then
    echo "Modelo já existe: ${OUTPUT} ($(du -h "${OUTPUT}" | cut -f1))"
else
  echo "Baixando ${FILENAME}..."
  curl -L --progress-bar -o "${OUTPUT}" "${BASE_URL}/${FILENAME}"
  echo "Salvo em ${OUTPUT} ($(du -h "${OUTPUT}" | cut -f1))"
fi

if [ -f "${OUTPUT_VAD}" ]; then
    echo "Modelo VAD já existe: ${OUTPUT_VAD} ($(du -h "${OUTPUT_VAD}" | cut -f1))"
else
  echo "Baixando modelo VAD..."
  curl -L --progress-bar -o "$OUTPUT_VAD" "https://huggingface.co/ggml-org/whisper-vad/resolve/main/ggml-silero-v6.2.0.bin"
  echo "Salvo em ${OUTPUT_VAD} ($(du -h "${OUTPUT_VAD}" | cut -f1))"
fi
