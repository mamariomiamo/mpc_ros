FROM ros:melodic-ros-base

ARG DISTRO=melodic

# Ensure apt uses the default answers
ENV DEBIAN_FRONTEND noninteractive

# map local user and group IDs to 'developer' user in container
# these must be passed duing the build stage
# How to find User ID: id -u
# How to find Group ID : id -g
ARG USER_ID
ARG GROUP_ID

ARG USER=developer
ARG GROUP=domain_users

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    groupadd -g ${GROUP_ID} $GROUP && \
    useradd -m -s /bin/bash -l -u ${USER_ID} -g $GROUP $USER \
;fi

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y \
    python3-pip \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-$DISTRO-desktop-full \
    ros-$DISTRO-gazebo-ros-pkgs \
    && rm -rf /var/lib/apt/lists/*

# install some utilities that developers need
RUN apt-get update && apt-get install -y \
    bash-completion \
    less \
    wget \
    vim \
    nano \
    tmux \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /home/$USER
ENV SHELL /bin/bash

WORKDIR /home/$USER

# source the ROS distro
RUN echo "source /opt/ros/$DISTRO/setup.bash" >> /home/$USER/.bashrc

RUN echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

USER $USER

RUN mkdir -p navigation_ws/src

RUN pip3 install cpplint pre-commit transforms3d
