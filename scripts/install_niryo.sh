# Requistos previos_
# - Instalación minima de ubuntu 18.04
# 
# El script debe ser ejecutado con este comando desde la raíz de la carpeta de usuario
# source ~/install_niryo.sh
!/bin/bash

# Ros Melodic + Gazebo
echo "Instalación de ROS y GAZEBO"
cd
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl -y
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update -y

sudo apt install ros-melodic-desktop-full -y
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Gazebo REST error
gazebo -v
sed -i 's/ignitionfuel/ignitionrobotics/g' ~/.ignition/fuel/config.yaml 

# Creating structure
echo "Creating Niryo folder..."
cd
mkdir Niryo 
cd Niryo

#Niryo Studi
echo "Installing NiryoStudio"
mkdir downloads
cd downloads
wget -U firefox  https://archive-docs.niryo.com/download/NiryoStudio/v4.1.2/Linux/NiryoStudio-linux-x64_v4.1.2.zip
unzip NiryoStudio-linux-x64_v4.1.2.zip
cd ..
mv downloads/dist-app/NiryoStudio-linux-x64 NiryoStudio
rmdir downloads/dist.app
cd


# Installing Niryo NED packages
sudo apt install sqlite3 -y
sudo apt install ffmpeg -y
sudo apt install build-essential -y

sudo apt install ros-melodic-moveit -y
sudo apt install ros-melodic-control-* -y
sudo apt install ros-melodic-controllers-* -y
sudo apt install ros-melodic-tf2-web-republisher -y
sudo apt install ros-melodic-rosbridge-server -y
sudo apt install ros-melodic-joint-state-publisher -y
#sudo apt install ros-melodic-foxglove-bridge -y

sudo apt install python-catkin-pkg -y
sudo apt install python-pymodbus -y
sudo apt install python-rosdistro -y
sudo apt install python-rospkg -y
sudo apt install python-rosdep -y
sudo apt install python-rosinstall -y 
sudo apt install python-rosinstall-generator -y 
sudo apt install python-wstool -y

sudo apt install python-pip -y
#sudo pip2 install --target=/opt/ros/melodic/lib/python2.7/dist-packages rospkg

sudo rosdep init
rosdep update --rosdistro melodic

# Installing NED ROS Stack
source /opt/ros/melodic/setup.bash
cd ~/Niryo
mkdir -p catkin_ws_niryo_ned/src
cd catkin_ws_niryo_ned
cd ..
cd src
git checkout tags/v4.0.1
cd ..
pip2 install -r src/requirements_ned2.txt
rosdep install --from-paths src --ignore-src --default-yes --rosdistro melodic --skip-keys "python-rpi.gpio"


catkin_make
echo "source $(pwd)/devel/setup.bash" >> ~/.bashrc

#echo "alias gzgkill='killall -9 gzclient && killall -9 gzserver && killall -9 rosmaster'" >> ~/.bashrc

sudo apt autoremove -y
source ~/.bashrc

# Pyniryo (for python3)
sudo apt install libcanberra-gtk-module libcanberra-gtk3-module -y
sudo apt install -y python3-pip
pip3 install --upgrade pip
pip3 install -v numpy
pip3 install -v opencv-python
pip3 install pyniryo==1.1.1
pip3 install pyniryo2

cd ..

# Installing Movit for Niryo
sudo apt install python-catkin-tools -y
sudo apt install ros-melodic-moveit* -y
sudo apt install ros-melodic-franka* -y
sudo apt install ros-melodic-joy* -y

mkdir -p ~/Niryo/moveit_ws/src
cd ~/Niryo/moveit_ws/src

git clone https://github.com/ros-planning/moveit_tutorials.git -b melodic-devel
git clone https://github.com/ros-planning/panda_moveit_config.git -b melodic-devel

rosdep update --rosdistro melodic
rosdep install -y --from-paths . --ignore-src --rosdistro melodic

cd ~/Niryo/moveit_ws
catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build

echo 'source ~/Niryo/moveit_ws/devel/setup.bash' >> ~/.bashrc

# Github Desktop
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null

sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list' 
sudo apt update && sudo apt install github-desktop -y

# Installación de Visual Studio
sudo snap install --classic code

code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-vscode.cmake-tools
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cpptools-themes
code --install-extension twxs.cmake
code --install-extension ms-iot.vscode-ros

