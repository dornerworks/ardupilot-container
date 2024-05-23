# ardupilot

Build Command:

`docker build --tag ardu .`

To run the image:

`docker run --rm -p 5760-5810:5760-5810 --env NUMCOPTERS=1 ardu`

This will start 3 ArduCopter SITL on host TCP ports 5760, 5770, and 5780; so to connect to it from the host, you could:

```
mavproxy.py --master=tcp:localhost:5760
mavproxy.py --master=tcp:localhost:5770
mavproxy.py --master=tcp:localhost:5780
```

Options
-------

Current set values:

```
INSTANCE          0
LAT              42.9193
LON              -85.5814
ALT               14
DIR               270
COPTERMODEL       +
SPEEDUP           1
NUMCOPTERS        1
INCREMENTSTEPLAT  0.01
INCREMENTSTEPLON  0.01
```

Vehicles and their corresponding models are listed below:

```
ArduCopter: octa-quad|tri|singlecopter|firefly|gazebo-
    iris|calibration|hexa|heli|+|heli-compound|dodeca-
    hexa|heli-dual|coaxcopter|X|quad|y6|IrisRos|octa
```
