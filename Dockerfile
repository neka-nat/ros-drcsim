FROM ros:indigo

RUN apt-get update
RUN apt-get install -y wget
RUN sh -c 'echo "deb http://packages.osrfoundation.org/drc/ubuntu trusty main" > /etc/apt/sources.list.d/drc-latest.list'
RUN wget http://packages.osrfoundation.org/drc.key -O - | apt-key add -
RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx libgl1-mesa-dri
RUN apt-get install -y mesa-utils
RUN apt-get install -y ros-indigo-stereo-image-proc drcsim

# for gui setup
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
 
USER developer
ENV HOME /home/developer
WORKDIR /home/developer
RUN echo "export QT_X11_NO_MITSHM=1" >> ~/.bashrc
RUN echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/indigo/share/drcsim_model_resources/setup.sh" >> ~/.bashrc
CMD ["/bin/bash"]
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri:/dev/dri ros_drcsim:1.0
# roslaunch drcsim_gazebo atlas.launch