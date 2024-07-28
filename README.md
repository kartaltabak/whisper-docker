# whisper-docker

This is a docker image for whisper. 

## Usage

### Convert to mp3

Initially, you may want to extract the audio from a video file. 
That is easy, and we have installed ffmpeg utility, as well as a helper script
to make it even easier. 

Assume you have a file called Rapunzel.mp4 in the current directory.

```bash
docker run -it -v ${PWD}:/work -w /work kartaltabak/whisper convert_to_mp3 'Rapunzel.mp4'
```

This will create a file named `Rapunzel.mp3` in the same directory.

### Create srt file

Assume you have a file called Rapunzel.mp3 in the current directory.

The following command will create a file named `Rapunzel.srt` in the same directory.

```bash
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/whisper create_srt 'Rapunzel.mp3'
```

