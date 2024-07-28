FROM python:3

RUN pip install --upgrade pip

# RUN pip install -U openai-whisper

RUN apt update && apt install -y ffmpeg

RUN pip install \
    torch==2.3.1+cpu \
    torchaudio==2.3.1+cpu \
    -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install \
    whisper-timestamped \
    transformers \
    sentencepiece \
    sacremoses

COPY convert_to_mp3.sh /usr/local/bin/convert_to_mp3
COPY create_srt.sh /usr/local/bin/create_srt
COPY translate_using_opus.py /usr/local/bin/translate_using_opus.py
COPY translate_to_turkish.sh /usr/local/bin/translate_to_turkish

