#! /usr/bin/env python3

import os
import whisper
import argparse
from pathlib import Path
import torch

def transcribe_audio(input_file, model_name="turbo"):
    """
    Transcribe an audio file using Whisper.
    
    Args:
        input_file (str): Path to the input audio file
        model_name (str): Whisper model to use (tiny, base, small, medium, large, turbo)
    """
    # Set device to CUDA
    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"Using device: {device}")
    
    # Load the Whisper model
    print(f"Loading {model_name} model...")
    model = whisper.load_model(model_name).to(device)
    
    # Transcribe the audio
    print(f"Transcribing {input_file}...")
    result = model.transcribe(input_file)
    
    # Get the output filename
    input_path = Path(input_file)
    output_file = Path("/app/output") / f"{input_path.stem}.txt"
    
    # Save the transcription
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(result["text"])
    
    print(f"Transcription saved to {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Transcribe audio files using Whisper")
    parser.add_argument("--input", "-i", required=True, help="Input audio file path")
    parser.add_argument("--model", "-m", default="turbo", 
                      choices=["tiny", "base", "small", "medium", "large", "turbo"],
                      help="Whisper model to use")
    
    args = parser.parse_args()
    
    # Check if input file exists
    if not os.path.exists(args.input):
        print(f"Error: Input file {args.input} does not exist")
        return
    
    transcribe_audio(args.input, args.model)

if __name__ == "__main__":
    main() 