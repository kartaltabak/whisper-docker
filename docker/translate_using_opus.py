import argparse
import logging
import re
from transformers import MarianMTModel, MarianTokenizer

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load the pre-trained model and tokenizer for English to Turkish translation
model_name = "Helsinki-NLP/opus-mt-tc-big-en-tr"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)


# Function to perform translation
def translate(text, model, tokenizer):
    logging.info(f"Translating : {text[:50]}...")
    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True)
    translated = model.generate(**inputs)
    translated_text = tokenizer.decode(translated[0], skip_special_tokens=True)
    logging.info(f"Translated: {translated_text[:50]}...")
    return translated_text


# Function to read SRT file
def read_srt_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    subtitles = re.split(r'\n\n', content)
    return subtitles


# Function to write SRT file
def write_srt_file(file_path, subtitles):
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write('\n\n'.join(subtitles))


# Function to translate subtitles
def translate_subtitles(subtitles, model, tokenizer):
    translated_subtitles = []
    for subtitle in subtitles:
        lines = subtitle.split('\n')
        if len(lines) > 2:
            text = ' '.join(lines[2:])
            translated_text = translate(text, model, tokenizer)
            translated_subtitles.append('\n'.join(lines[:2] + [translated_text]))
        else:
            translated_subtitles.append(subtitle)
    return translated_subtitles


def main(input_file_path, output_file_path):
    # Read subtitles from the input file
    subtitles = read_srt_file(input_file_path)

    # Translate subtitles
    translated_subtitles = translate_subtitles(subtitles, model, tokenizer)

    # Write translated subtitles to the output file
    write_srt_file(output_file_path, translated_subtitles)

    logging.info(f"Translated subtitles saved to {output_file_path}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Translate SRT subtitle files from English to Turkish.')
    parser.add_argument('input_file', type=str, help='Path to the input SRT file')
    parser.add_argument('output_file', type=str, help='Path to the output SRT file')

    args = parser.parse_args()
    main(args.input_file, args.output_file)
