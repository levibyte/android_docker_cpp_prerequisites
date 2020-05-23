# Android docker prerequisites

### What's this?

Dockerfile that produces an image the contain all nessary prerequisites for working with Android in C++/Qt 

For building image simple do
```
  docker built -t android_cppdev_prerequisites .
```

To run, execute 

```
  docker run -p 5903:5903 -p 5901:5901 --privileged android_cppdev_prerequisites
```
Container then can be accessed via vnc connection ( password:123456 )
option1. via browser http://localhost:5901/vnc.html  ( using noVNC )
option2. any vncviewer on *localhost:3*

### Creating c++ apps in two steps  
![img](https://i.ibb.co/q7zznTw/rsz-lolqt.png)


### What's included
Currently this docker file is *non parametrized* but there are plans to make it generic as much as possible
Here is what current image will contain
- Java 8
- SDK26 + tools, platform-tools, build-tools
- NDK 21
- Emulator and some basic device 
- Qt installer

### running on real devices 

Its also possible to deploy c++ applications to real devices. There are rwo approaches

- running via shared USB
```
  docker run -p 5903:5903 -p 5901:5901 --privileged -v /dev/bus/usb:/dev/bus/usb <img> 
```

- running by running ADB on host ( requires same version platform-tools on host and starting adb on host first )
```
  docker run -p 5903:5903 -p 5901:5901 --privileged --network=host <img> 
```
