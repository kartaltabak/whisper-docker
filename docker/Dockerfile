FROM nvidia/cuda:12.9.0-cudnn-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3-pip \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir torch==2.1.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
RUN python3 -m pip install --no-cache-dir numpy==1.25.2
RUN python3 -m pip install --no-cache-dir git+https://github.com/openai/whisper.git
RUN python3 -c "import whisper; whisper.load_model('turbo')"
RUN python3 -m pip install --no-cache-dir \
    whisper-timestamped \
    transformers \
    sentencepiece \
    sacremoses

# Copy the application code
COPY transcribe.py .
COPY convert_to_mp3.sh .
COPY create_srt.sh .
COPY translate_using_opus.py .
COPY translate_to_turkish.sh .
COPY create_turkish_subtitle.sh .

# Create a directory for input/output files
RUN mkdir -p /app/input /app/output

# Set the entrypoint
ENTRYPOINT ["python3", "transcribe.py"]