# Example ROS workspace for [ros-grpc-bridge-generator](https://github.com/azazdeaz/ros-grpc-bridge-generator)

## Run 
> Tested on Ubuntu 20.04 with ROS Noetic. You can run with [Docker](#Docker) if you have a different setup. 

```bash
# clone this repo
git clone --recurse-submodules https://github.com/azazdeaz/ros-grpc-bridge-generator-example
cd ros-grpc-bridge-generator-example

# build the workspace
rosdep update
rosdep install --from-paths src --ignore-src -r -y
catkin_make

# launch the ROS nodes (in a new terminal)
. devel/setup.bash
roslaunch test turtles.launch

# generate the gRPC server package (in a new terminal)
. devel/setup.bash
roslaunch test generate_grpc_server.launch
catkin_make

# launch gRPC server (in a new terminal)
. devel/setup.bash
roslaunch turtles_grpc grpc_server.launch
```

## Run with Docker
```bash
# build the container with
docker build -t ros-grpc-turtle .
```

```bash
# run the simulator with docker:
xhost +

docker run -it \
    --network="host" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -p 50051 --name grpc_turtle \
    ros-grpc-turtle

# or run the simulator with rocker:

# install rocker (this makes it easier to run docker images with GUI)
pip3 install rocker off-your-rocker

# run the container (most of the options are stolen from the ignition-gym readme, hope they will work for you too :) )
# with Intel GPU
rocker --devices /dev/dri --x11 --oyr-run-arg "-p 50051 --name grpc_turtle" ros-grpc-turtle

# with Nvidia GPU
rocker --x11 --nvidia --oyr-run-arg "-p 50051 --name grpc_turtle" ros-grpc-turtle
```

```bash
# in a new terminal, generate the grpc server
docker exec -it grpc_turtle bash -c '. devel/setup.bash && roslaunch test generate_grpc_server.launch && catkin_make'

# run it
docker exec -it grpc_turtle bash -c '. devel/setup.bash && roslaunch turtles_grpc grpc_server.launch'

# and now the grpc server should be running at localhost:50051 ready to operate the turtle ٩(^‿^)۶!
```

## Try out the API

Now you should see the turtle_sim window and have a running gRPC server in the background. You quickly test the API with a tool like [BloomRPC](https://github.com/uw-labs/bloomrpc). You'll have to set the proto file (<generated pkg>/ros.proto) and the server address (localhost:50051 by default)