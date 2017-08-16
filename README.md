# SDK Example iOS

## Description

This is a proof-of-concept iOS app built on top of the Yuneec SDK.

## Building

### XCode

The project was last built using XCode 8.2.1 and the iOS SDK 10.2.

### Checkout this repo

To get the XCode project, do:
```
git clone git@github.com:YUNEEC/Yuneec-SDK-iOS-Example-prerelease.git
```

### Add C++ wrapper framework

The [C++ wrapper framework](https://github.com/YUNEEC/Yuneec-SDK-iOS) around the [Yuneec-SDK](https://github.com/YUNEEC/Yuneec-SDK) can be added using [Carthage](https://github.com/Carthage/Carthage).

First, make sure Carthage is installed:
```
brew install carthage
```

Then, use it to download the framework:
```
cd Yuneec-SDK-iOS-Example-prerelease
carthage update --use-ssh
```
(TODO: remove ssh once this is public)

Make sure framework is added in project (it should already be there):

1. Open project settings -> General
2. Find Embedded Binaries and press +
3. Click Other, go one folder up, and select `Carthage/Build/iOS/Yuneec_SDK_iOS.framework`.
4. Do "Product Clean" and "Product Build"

## Use the Yuneec software in the loop (SITL) simulation for testing

The iOS app can be tested against the software simulation.

The SITL can be used on Linux or Mac. The use in a virtualization environment such as VirtualBox is possible but generally not recommended for performance reasons. A headless instance can be run inside a Docker container, as explained [here](sitl).

### Installing Gazebo7

#### Mac

Tested on macOS 10.11 and 10.12.

Make sure to have [homebrew](http://brew.sh).

```
brew cask install xquartz
brew tap px4/simulation
brew update
brew install gazebo7
```

OpenCV is required to run the simulation.
```
brew tap homebrew/science
brew install opencv
```

#### Ubuntu

Tested on Ubuntu 16.04.

```
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install gazebo7 libgazebo7-dev
```

Instructions taken from [gazebosim.org](http://gazebosim.org/tutorials?tut=install_ubuntu&ver=7.0&cat=install).

### Get the SITL simulation

Download the zip containing the SITL simulation for [Mac](https://s3.eu-central-1.amazonaws.com/08f61bbd-8958-433e-8e83-5d79160fa0be/sitl/latest/Yuneec-SITL-Simulation-macOS.zip) or [Linux](https://s3.eu-central-1.amazonaws.com/08f61bbd-8958-433e-8e83-5d79160fa0be/sitl/latest/Yuneec-SITL-Simulation-Linux.zip).

### Run the simulation

Use the included bash script to start the simulation environment:

```
cd Yuneec-SITL-simulation-xxx/
./typhoon_sitl.bash
```

To run it without simulation GUI, use:

```
HEADLESS=1 ./typhoon_sitl.bash
```

Sometimes the simulation hangs on startup. If it happens, press Ctrl+C in the console and try again.

To test if the simulation works, you can type `commander takeoff` or `commander land` in the `pxh>` shell.

### Use the iOS emulator

If the iOS simulator runs on the same computer as the SITL simulation, it should automatically connect.

### Use a real iOS device

By default, the SITL simulation will only try to connect on localhost but not to an iPhone/iPad on the network.

There are two options to connect to another IP:

1. Use broadcasting: This has the advantage that you don't need to determine the IP of the iOS device because it will pick it up automatically in the network. However, this can be a race if to devices are listening on the network.

2. Set the IP: This let's you choose the IP and avoid races for who gets to be the client.

#### Use broadcasting:

Start the SITL simuation and type the following in the `pxh>`:

```
param set MAV_BROADCAST 1
param save
```

#### Set IP:

Before starting the SITL simulation, open the file `posix-configs/SITL/init/ekf2/typhoon_h480` and look for this line:

```
mavlink start -u 14557 -r 4000000 -m custom -o 14540
```

then add the IP of the iOS device in the local network with `-t`:
```
mavlink start -u 14557 -r 4000000 -m custom -o 14540 -t 192.168.0.X
```

## License

This example app is published under the [BSD 3-Clause license](LICENSE).

