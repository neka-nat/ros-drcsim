ros-drcsim 
===========

Docker image to provide DRCSim environment.

Quick start
------------

Build image.

```
docker build -t ros_drcsim:1.0 .
```

Create container

```
nvidia-docker run -ti --privileged --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri:/dev/dri ros_drcsim:1.0
```

When the container's shell starts up, execute the following command.

```
roslaunch drcsim_gazebo atlas.launch
```

The following window will be launched.

![drcsim_gz](drcsim_gz.png)
