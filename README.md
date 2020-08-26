# Example ROS workspace for [ros-grpc-api-generator](https://github.com/azazdeaz/ros-grpc-api-generator)

## Run 
> Tested on Ubuntu 20.04 with ROS Noetic. You can run with [Docker](#Docker) if you have a different setup. 

```bash
# clone this repo
git clone --recurse-submodules https://github.com/azazdeaz/ros-grpc-api-generator-example
cd ros-grpc-api-generator-example

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
# this should get turtlesim and the gRPC server running
./run_in_docker
```

## Try out the API

Now you should see the turtle_sim window and have a running gRPC server in the background. You quickly test the API with a tool like [BloomRPC](https://github.com/uw-labs/bloomrpc). You'll have to set the proto file (<generated pkg>/ros.proto) and the server address (localhost:50051 by default)