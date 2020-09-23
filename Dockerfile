FROM ubuntu:18.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme sudo \
    fonts-dejavu fonts-liberation fonts-indic hicolor-icon-theme \
    libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
    libasound2 libglib2.0 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
    libgl1-mesa-glx libgl1-mesa-dri libstdc++6 nvidia-346 \
    gstreamer-1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
    avogadro \
 && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && rm -rf /var/lib/apt/lists/* 

ENV USERNAME avogadro
RUN useradd -m $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd \
 && usermod --shell /bin/bash $USERNAME \
 && usermod -aG sudo $USERNAME \
 && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
 && usermod  --uid 1000 $USERNAME \
 && groupmod --gid 1000 $USERNAME

USER $USERNAME
ENTRYPOINT ["/usr/bin/avogadro"]
