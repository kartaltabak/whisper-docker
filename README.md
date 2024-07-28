# whisper-docker

This is a docker image for whisper. 

## Usage

### Convert to mp3

Initially, you may want to extract the audio from a video file. 
That is easy, and we have installed ffmpeg utility, as well as a helper script
to make it even easier. 

Assume you have a file called Rapunzel.mp4 in the current directory.

```bash
docker run -it -v ${PWD}:/work -w /work kartaltabak/whisper convert_to_mp3 'Rapunzel.mp4' --output_file 'Rapunzel.mp3'
```

This will create a file named `Rapunzel.mp3` in the same directory. `
--output_file` is optional. If you don't provide it, the output file will have the same name 
as the input file, but with the extension changed to `.mp3`.

### Create srt file

Assume you have a file called Rapunzel.mp3 in the current directory.

The following command will create a file named `Rapunzel.srt` in the same directory.

```bash
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/whisper create_srt 'Rapunzel.mp3' --output_file 'Rapunzel.srt'
```

`--output_file` is optional. If you don't provide it, the output file will have the same name
as the input file, but with the extension changed to `.srt`.

### Create translation

```bash
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/whisper translate_to_turkish 'Rapunzel.srt' --output_file 'Rapunzel.tr.srt'
```

`--output_file` is optional. If you don't provide it, the output file will have the same name
Currently, the script is using the English to Turkish model. In the future, we may support more languages.

### Create Turkish srt directly from mp4

```bash
docker run -it --rm -v ${PWD}:/work -w /work -v ${PWD}/.cache:/root/.cache/ kartaltabak/whisper create_turkish_srt 'Rapunzel.mp4' --output_file 'Rapunzel.tr.srt'
```

`--output_file` is optional. If you don't provide it, the output file will have the same name
