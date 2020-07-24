# aria2-alpine
Docker image for Aria2 RPC daemon based on the super lightweight Alpine Linux.

## Usage
Docker image: `ndthuan/aria2-alpine`
the tag RPC_SECRET has to recive an value,it is mandatory to work
Example:
```bash
docker run --rm -p 6800:6800 --name aria2 -d \
-e RPC_SECRET=xxx \
-v $HOME/Downloads:/downloads \
-v $HOME/Documents/Aria2configs:/config \
mzramna/aria2-alpine
```
it will automaticaly move any completed download into the download folder to the subfolder "download_complete",this could be easily changed into mvcompleted.sh file into the config folder

## Supported environment variables
First, you might want to check out the comprehensive [aria2 configuration docs](https://aria2.github.io/manual/en/html/aria2c.html) along with checking env vars supported by this image:
* `DOWNLOAD_DIR`: maps to aria2's [--dir](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-d) config, where inside the container to put your downloads (default: `/downloads`). You'd rather mount downloads directory on your host to `/downloads` than changing this default value.
* `DOWNLOAD_SUBFOLDER`: add an subfolder to `DOWNLOAD_DIR` parameter,useful to organize host folders,even more with the `COMPLETE_DOWNLOAD_DIR` parameter (default: `/`). 
* `COMPLETE_DOWNLOAD_DIR`: sets the finished downloads output folder,when completed,torrents and downloads are moved to this folder (default: `/downloads/download_complete`).
* `CONCURRENT_DOWNLOADS`: maps to aria2's [--max-concurrent-downloads](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-j), number of concurrent downloads, default: `4`.
* `CONNECTIONS_PER_SERVER`: maps to aria2 [--max-connection-per-server](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-x), this affects the `SPLIT` config down below, default: `4`.
* `SPLIT`: maps to aria2's [--split](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-s), maximum number of active connections when downloading a file, default: `4`.
* `USER_AGENT`: maps to aria2's [--user-agent](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-u), user agent for HTTP(S) downloads,default ` `.
* `FILE_ALLOCATION`: file allocation method, read [--file-allocation explanation here]([FILE_ALLOCATION](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-file-allocation)) default: `none`.
* `ALLOW_OVERWRITE`: maps to aria2's [--allow-overwrite](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-allow-overwrite), default: `true`.
* `AUTO_FILE_RENAMING`: maps to aria2's [--auto-file-renaming](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-auto-file-renaming), default: `false`.
* `RPC_SECRET`: maps to aria2's [--rpc-secret](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-rpc-secret),default ` `.
* `CONNECTIONS_PER_SERVER`: maps to aria2's [--max-connection-per-server](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-x),default `4`.
* `LOG_LEVEL`: maps to aria2's [--log-level](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-console-log-level),default `warn`.
* `HTTP_PIPELINE`: maps to aria2's [--enable-http-pipelining](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-enable-http-pipelining),default `true`.
* `MIN_SPLIT_SIZE`: maps to aria2's [--min-split-size](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-k),default `10M`.
* `CONTINUE`: maps to aria2's [--continue](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-c), continue download automaticaly, default: `true`.
* `MAX_OVERALL_DOWNLOAD_LIMIT`: maps to aria2's [--max-overall-download-limit](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-max-overall-download-limit), the maximum speed that the container will use,limiting every torrent download speed,0 means unlimited, default: `0`.
* `REMOVE_UNSELECTED`: maps to [--bt-remove-unselected-file](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-bt-remove-unselected-file),if true non selected files on torrents will not be downloaded and will be deleted if already downloaded,default `true`.
* `MAX_OVERALL_UPLOAD_LIMIT`: maps to aria2's [--max-overall-upload-limit](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-max-overall-upload-limit), the maximum speed that the container will use,limiting every torrent upload speed,1K means 1kbps, default: `1K`.
* `SEED_TIME`: maps to aria2's [--seed-time](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-seed-time), the time after a torrent has finished that it will keep seeding,the time is given in minutes, default: `30`.

