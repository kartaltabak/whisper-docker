import os
import whisper
import argparse
from pathlib import Path
import torch


def transcribe_audio(input_file, model_name="turbo"):
    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"Using device: {device}")

    # Load the Whisper model
    print(f"Loading {model_name} model...")
    model = whisper.load_model(model_name).to(device)

    # Transcribe the audio
    print(f"Transcribing {input_file}...")
    result = model.transcribe(input_file)

    print(result["text"])


def main():
    parser = argparse.ArgumentParser(description="Transcribe audio files using Whisper")
    parser.add_argument("--input", "-i", required=True, help="Input audio file path")

    args = parser.parse_args()

    if not os.path.exists(args.input):
        print(f"Error: Input file {args.input} does not exist")
        return

    transcribe_audio(args.input)


if __name__ == "__main__":
    main()
