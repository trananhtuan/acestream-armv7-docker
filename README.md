# acestream-armv7-docker
Acestream engine for ARMv7 devices (such as Raspberry Pi, Odroid)

This uses acestreamMOD provided by [pepsik-kiev](https://github.com/pepsik-kiev)

This does not require `--priviledged`, instead it uses a custom seccomp profile to allow personality syscall (PER_LINUX32) which is needed by acestreamMOD.

### Build & Run
```
git clone https://github.com/trananhtuan/acestream-armv7-docker
cd acestream-armv7-docker
```
Edit `acestream.conf` to change access token, change other options if needed. Login and password is optional.
```
docker build --tag=acestream-armv7 .
docker run --security-opt seccomp=profile.json --name acestream-armv7 --restart=always --network=host acestream-armv7
```

### Usage
Get Engine version via HTTP:
```
http://<IP>:6878/webui/api/service?method=get_version&format=jsonp&callback=mycallback
```

WebUI is available at:
```
http://<IP>:6878/webui/app/ReplaceMe3hdjsa/server#proxy-server-settings
```
(`ReplaceMe3hdjsa` is access-token set in acestream.conf)

#### Play a stream:
```
http://<IP>:6878/6878/ace/getstream?id=STREAM_ID
```
Example:
`
acestream://dd1e67078381739d14beca697356ab76d49d1a2d
`

STREAM_ID is `dd1e67078381739d14beca697356ab76d49d1a2d`

#### Stream a torrent:
```
http://<IP>:6878/6878/ace/getstream?infohash=INFOHASH
```
Example: `
magnet:?xt=urn:btih:dd8255ecdc7ca55fb0bbf81323d87062db1f6d1c&dn=Big+Buck+Bunny&tr=udp%3A%2F%2Fexplodie.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.empire-js.us%3A1337&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com&ws=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2F&xs=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2Fbig-buck-bunny.torrent
`

INFOHASH: `dd8255ecdc7ca55fb0bbf81323d87062db1f6d1` (The string follows `magnet:?xt=urn:btih:`)

Refer [Acestream Engine HTTP API](http://wiki.acestream.org/wiki/index.php/Engine_HTTP_API) for how to access and control the engine.

#### Known issues
This image uses a modded version as there is no official releases for ARMv7.
- Some packet loss occurs from time to time which causes stuttering and broken images, at worst case, media player might stop the playback
- Some other non-critical issues which can be seen from the log

