# qt_android_docker

```
  docker run -p 5903:5903 -p 5901:5901 <img>
```



#### running on real devices 

- running via shared USB
```
  docker run -p 5903:5903 -p 5901:5901 --privileged -v /dev/bus/usb:/dev/bus/usb wip_<img> 
```

- running ADB on host ( requires same version platform-tools on host and starting adb on host first )
```
  docker run -p 5903:5903 -p 5901:5901 --privileged --network=host <img> 
```
