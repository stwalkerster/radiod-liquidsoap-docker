FROM savonet/liquidsoap:v2.2.5

USER 0
RUN echo "deb https://ppa.launchpadcontent.net/tomtomtom/yt-dlp/ubuntu jammy main" > /etc/apt/sources.list.d/ytdlp.list
ADD "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xcec312cc5ed8215a6e0efc49b90e9186f0e836fb" /etc/apt/trusted.gpg.d/ytdlp.asc
RUN chmod a+r /etc/apt/trusted.gpg.d/ytdlp.asc \
    && apt-get update \
    && apt-get install -qy yt-dlp ffmpeg telnet cron netcat-openbsd --no-install-recommends

RUN mkdir /usr/share/liquidsoap/.cache && chown liquidsoap /usr/share/liquidsoap/.cache
RUN echo "0 0 * * *  root  apt-get update > /dev/null && apt-get install -qy --no-install-recommends yt-dlp  >/dev/null" > /etc/crontab

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/entrypoint.sh" ]

USER 10000
