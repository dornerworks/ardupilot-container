# DockArdu

Ardupilot instance created in a docker container for use on arm64 based architecutre.  Building dockardu requires a builder image which is auto built when using the `build-compose.yml` docker-compose file.

## To Build:

```
docker-compose -f build-compose.yml build
```

## To Run:

```
docker-compose up -d
```
