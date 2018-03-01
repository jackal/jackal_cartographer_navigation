## Mapping with Google Cartographer

To get started with 2D SLAM using Google Cartographer, clone this repo into your working directory:

`git clone http://gitlab.clearpathrobotics.com/research/jackal_cartographer_navigation.git`

Run the following script to create a workspace and install the packages required for Cartographer:

`source $(pwd)/jackal_cartographer_navigation/protobuf3_local.sh`

Open three new terminal/tabs, source the workspace for each terminal/tab:

`source install_isolated/setup.bash`

Launch the Gazebo simulation with the front_laser config:

`roslaunch jackal_gazebo jackal_world.launch config:=front_laser`

Launch RViz to visualize the robot:

`roslaunch jackal_viz view_robot.launch config:=gmapping`

Launch the Cartographer node to begin SLAM:

`roslaunch jackal_navigation cartographer_demo.launch`

To tune Cartographer for low latency SLAM, edit the Jackal.lua configuration file found in:

`cd $(pwd)/jackal_cartographer_navigation/jackal/jackal_navigation/launch`

For more information on tuning, click [here](http://google-cartographer-ros.readthedocs.io/en/latest/tuning.html)
