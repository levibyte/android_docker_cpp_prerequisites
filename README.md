# Android docker prerequisites

### What's this?

Dockerfile that produces image containt all prerequisites for working with Android in C++ 

```
  docker run -p 5903:5903 -p 5901:5901 <img>
```
Container then can be accessed via noVNC session via http://localhost:5901/vnc.html or by any vncviewer on *localhost:3*


### running on real devices 

- running via shared USB
```
  docker run -p 5903:5903 -p 5901:5901 --privileged -v /dev/bus/usb:/dev/bus/usb wip_<img> 
```

- running ADB on host ( requires same version platform-tools on host and starting adb on host first )
```
  docker run -p 5903:5903 -p 5901:5901 --privileged --network=host <img> 
```
