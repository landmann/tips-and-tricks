

# Arch Linux

I've started to use ArchLinux at work and it's honestly quite buggy, but it does help you learn about what's happening in the back.

## For a cron job

```bash
pacman -Syu cronie
systemctl enable --now cronie.service
crontab -e
```


## Copy Files From Terminal to Clipboard
I use `xclip` on Konsole (the Arch console that is also buggy - particularly with `htop`). To copy a file with xclip, type

```bash
xclip -sel clip < ~/path/to/file.txt
```
Then you can use `Ctrl+V` to paste elsewhere.

## Mapping CapsLock to Ctrl
First thing I do when using a new ArchLinux computer is to map the `CapsLock` key to `Ctrl`. To do this, add the following to `~/.Xmodmap`

```bash
clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R
```
and execute it typing `xmodmap ~/.Xmodmap`.


## Baloo File Extractor

Sometimes, the computer will start to lag for no apparent reason. Upon inspecting the computer processes, one may find that the `baloo_file_extractor` is taking up a substantial amount of CPU power. The `baloo_file_extractor` indexes the files on the computer for easy searching, but the process is so slow it makes the computer extremely painful to use. So, there are two things you must do. If you run into this problem, first type `balooctl disable,` then you'll have to restart the computer (Sorry!), and finally enable it again on startup with `balooctl enable`.  Some blogs say to disable balooctl altogether writing `Indexing-Enabled=false` in  `~/.kde4/share/config/baloofilerc`.

## Disk Full

My disk often gets full without downloading any large files. Although I haven't found a method to systematically stop this from happening, I often run these diagnostic tools in order to fix the issue.

1. Type `df -h` to get a report of the Filesystem's usage.

```bash
Filesystem      Size  Used Avail Use% Mounted on
dev              16G     0   16G   0% /dev
run              16G  9.4M   16G   1% /run
/dev/sda6       283G  141G  128G  53% /
tmpfs            16G  576M   16G   4% /dev/shm
tmpfs            16G     0   16G   0% /sys/fs/cgroup
tmpfs            16G  6.7M   16G   1% /tmp
tmpfs           3.2G   32K  3.2G   1% /run/user/1000
```

Then you can check for the files of size > 1G and remove them from your computer.
```
sudo find / -size +1G
```

The place that was hogging most of my disk space was in `logs`, so check there first:

```
du -h /var/log
```

If it is, in fact, hogging a lot of disk space, see what's being printed in the logs with a simple `head /var/log/error_log`. My issue dealt with some `insecure permissions`, so I just changed the some settings in this file. The first one is `MaxLogSize 1` and `LogLevel none`.

```
sudo vim /etc/cups/cupsd.conf
```
Lastly, remove all the files

```
sudo rm -vfr /var/log && sudo mkdir /var/log
```

If you want to kill it, do 

```
sudo systemctl stop org.cups.cupsd org.cups.cupsd.path org.cups.cupsd.socket
```

## Ethernet connection

Sometimes the ethernet connection doesn't work. This has been the fix for me.

Type `ip link` and you'll get a few connections. Find the one that says `link/ether`. In my case, that was `eno1`. Then type 
```
sudo ip link set eno1 up
```
Wait a few seconds and voila! Internet should be up. Or at least see that the brackets contain `<UP>`.
