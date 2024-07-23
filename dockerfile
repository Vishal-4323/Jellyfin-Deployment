FROM jellyfin/jellyfin:latest

RUN mkdir /home/audio
RUN mkdir /home/video

COPY media/music/ /home/audio

COPY media/video/ /home/video