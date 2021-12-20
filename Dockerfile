FROM ros:noetic-ros-base-focal
COPY . /catkin_ws
WORKDIR /catkin_ws
RUN apt-get update
RUN apt-get install python3-pip -y
RUN pip3 install --user grpcio grpcio-tools
# TODO remove when it got fixed in rosdep
RUN pip3 install --user cookiecutter
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src -r -y  || echo "There were some errors during rosdep install"
SHELL ["/bin/bash", "-c"]
RUN source /opt/ros/noetic/setup.bash && \
    catkin_make
CMD source devel/setup.bash && roslaunch test turtles.launch