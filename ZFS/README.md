**lsblk**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0 66.8M  1 loop /snap/core24/1643
loop1                       7:1    0  1.5M  1 loop /snap/hwctl/123
loop2                       7:2    0 50.1M  1 loop /snap/snapd/27710
sda                         8:0    0   15G  0 disk 
├─sda1                      8:1    0  715M  0 part /boot/efi
├─sda2                      8:2    0  1.8G  0 part /boot
└─sda3                      8:3    0 12.5G  0 part 
  └─ubuntu--vg-ubuntu--lv 252:0    0   10G  0 lvm  /
sdb                         8:16   0    5G  0 disk 
sdc                         8:32   0    5G  0 disk 
sdd                         8:48   0    5G  0 disk 
sde                         8:64   0    1G  0 disk 
sdf                         8:80   0    1G  0 disk 
sdg                         8:96   0    1G  0 disk 
sdh                         8:112  0    1G  0 disk 
sdi                         8:128  0    1G  0 disk 
sdj                         8:144  0    1G  0 disk 
sr0                        11:0    1 1024M  1 rom  
</pre>
</details>

**sudo apt install zfsutils-linux**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>The following packages were automatically installed and are no longer required:
  linux-headers-7.0.0-30          linux-image-unsigned-7.0.0-30-generic    linux-modules-7.0.0-30-generic  linux-tools-7.0.0-30-generic
  linux-headers-7.0.0-30-generic  linux-main-modules-zfs-7.0.0-30-generic  linux-tools-7.0.0-30
Use &apos;sudo apt autoremove&apos; to remove them.

Installing:
<font color="#55FF55">  zfsutils-linux</font>

Installing dependencies:
<font color="#55FF55">  libnvpair3linux  libuutil3linux  libzfs7linux  libzpool7linux  zfs-zed</font>

Suggested packages:
  nfs-kernel-server  samba-common-bin  zfs-initramfs  | zfs-dracut

Summary:
  Upgrading: 0, Installing: 6, Removing: 0, Not Upgrading: 26
  Download size: 2,504 kB
  Space needed: 7,693 kB / 4,597 MB available

Continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 libnvpair3linux amd64 2.4.1-1ubuntu5.1 [58.9 kB]
Get:2 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 libuutil3linux amd64 2.4.1-1ubuntu5.1 [50.0 kB]
Get:3 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 libzfs7linux amd64 2.4.1-1ubuntu5.1 [235 kB]
Get:4 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 libzpool7linux amd64 2.4.1-1ubuntu5.1 [1,483 kB]
Get:5 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 zfsutils-linux amd64 2.4.1-1ubuntu5.1 [606 kB]
Get:6 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 zfs-zed amd64 2.4.1-1ubuntu5.1 [71.2 kB]
Fetched 2,504 kB in 2s (1,116 kB/s)
Selecting previously unselected package libnvpair3linux:amd64.
(Reading database… 139577 files and directories currently installed.)
Preparing to unpack …/0-libnvpair3linux_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking libnvpair3linux:amd64 (2.4.1-1ubuntu5.1)…
Selecting previously unselected package libuutil3linux:amd64.
Preparing to unpack …/1-libuutil3linux_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking libuutil3linux:amd64 (2.4.1-1ubuntu5.1)…
Selecting previously unselected package libzfs7linux:amd64.
Preparing to unpack …/2-libzfs7linux_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking libzfs7linux:amd64 (2.4.1-1ubuntu5.1)…
Selecting previously unselected package libzpool7linux:amd64.
Preparing to unpack …/3-libzpool7linux_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking libzpool7linux:amd64 (2.4.1-1ubuntu5.1)…
Selecting previously unselected package zfsutils-linux.
Preparing to unpack …/4-zfsutils-linux_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking zfsutils-linux (2.4.1-1ubuntu5.1)…
Selecting previously unselected package zfs-zed.
Preparing to unpack …/5-zfs-zed_2.4.1-1ubuntu5.1_amd64.deb…
Unpacking zfs-zed (2.4.1-1ubuntu5.1)…
Setting up libnvpair3linux:amd64 (2.4.1-1ubuntu5.1)…
Setting up libuutil3linux:amd64 (2.4.1-1ubuntu5.1)…
Setting up libzpool7linux:amd64 (2.4.1-1ubuntu5.1)…
Setting up libzfs7linux:amd64 (2.4.1-1ubuntu5.1)…
No diversion «diversion of /lib/x86_64-linux-gnu/libzfs_core.so.3 to /lib/x86_64-linux-gnu/libzfs_core.so.3.usr-is-merged by libzfs6linux», none removed.
No diversion «diversion of /lib/x86_64-linux-gnu/libzfs_core.so.3.0.0 to /lib/x86_64-linux-gnu/libzfs_core.so.3.0.0.usr-is-merged by libzfs6linux», none removed.
Setting up zfsutils-linux (2.4.1-1ubuntu5.1)…
insmod /lib/modules/7.0.0-38-generic/ubuntu/dkms/zfs/spl.ko.zst 
insmod /lib/modules/7.0.0-38-generic/ubuntu/dkms/zfs/zfs.ko.zst 
Created symlink &apos;/etc/systemd/system/zfs-import.target.wants/zfs-import-cache.service&apos; → &apos;/usr/lib/systemd/system/zfs-import-cache.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-import.target&apos; → &apos;/usr/lib/systemd/system/zfs-import.target&apos;.
Created symlink &apos;/etc/systemd/system/zfs-mount.service.wants/zfs-load-module.service&apos; → &apos;/usr/lib/systemd/system/zfs-load-module.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-load-module.service&apos; → &apos;/usr/lib/systemd/system/zfs-load-module.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-mount.service&apos; → &apos;/usr/lib/systemd/system/zfs-mount.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-share.service&apos; → &apos;/usr/lib/systemd/system/zfs-share.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs-volumes.target.wants/zfs-volume-wait.service&apos; → &apos;/usr/lib/systemd/system/zfs-volume-wait.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-volumes.target&apos; → &apos;/usr/lib/systemd/system/zfs-volumes.target&apos;.
Created symlink &apos;/etc/systemd/system/multi-user.target.wants/zfs.target&apos; → &apos;/usr/lib/systemd/system/zfs.target&apos;.
zfs-import-scan.service is a disabled or a static unit, not starting it.
Setting up zfs-zed (2.4.1-1ubuntu5.1)…
Created symlink &apos;/etc/systemd/system/zed.service&apos; → &apos;/usr/lib/systemd/system/zfs-zed.service&apos;.
Created symlink &apos;/etc/systemd/system/zfs.target.wants/zfs-zed.service&apos; → &apos;/usr/lib/systemd/system/zfs-zed.service&apos;.
Processing triggers for man-db (2.13.1-1build1)…
Processing triggers for libc-bin (2.43-2ubuntu2.4)…
Scanning processes...                                                                                                                                                   
Scanning linux images...                                                                                                                                                

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
</pre>
</details>

**zpool create pool-1 mirror /dev/sdb /dev/sdc**

**zpool create pool-2 mirror /dev/sdd /dev/sde**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>
  
<pre>invalid vdev specification
use &apos;-f&apos; to override the following errors:
mirror contains devices of different sizes
</pre>
</details>

**zpool create -f pool-2 mirror /dev/sdd /dev/sde**

**zpool create pool-3 mirror /dev/sdf /dev/sdg**

**zpool create pool-4 mirror /dev/sdh /dev/sdi /dev/sdj**

**zpool list**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>NAME     SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
pool-1  4.50G   124K  4.50G        -         -     0%     0%  1.00x    ONLINE  -
pool-2   960M   122K   960M        -         -     2%     0%  1.00x    ONLINE  -
pool-3   960M   126K   960M        -         -     2%     0%  1.00x    ONLINE  -
pool-4   960M   190K   960M        -         -     2%     0%  1.00x    ONLINE  -
</pre>
</details>

**zpool status**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>  pool: pool-1
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-1      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdb     ONLINE       0     0     0
	    sdc     ONLINE       0     0     0

errors: No known data errors

  pool: pool-2
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-2      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdd     ONLINE       0     0     0
	    sde     ONLINE       0     0     0

errors: No known data errors

  pool: pool-3
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-3      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdf     ONLINE       0     0     0
	    sdg     ONLINE       0     0     0

errors: No known data errors

  pool: pool-4
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-4      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdh     ONLINE       0     0     0
	    sdi     ONLINE       0     0     0
	    sdj     ONLINE       0     0     0

errors: No known data errors
</pre>
</details>

**zfs set compression=lzjb pool-1**

**zfs set compression=lz4 pool-2**

**zfs set compression=gzip-9 pool-3**

**zfs set compression=zle pool-4**

**zfs get all | grep compression**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>pool-1  <font color="#FF5555"><b>compression</b></font>             lzjb                    local
pool-2  <font color="#FF5555"><b>compression</b></font>             lz4                     local
pool-3  <font color="#FF5555"><b>compression</b></font>             gzip-9                  local
pool-4  <font color="#FF5555"><b>compression</b></font>             zle                     local
</pre>
</details>

**for i in {1..4}; do wget -P /pool-$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done**

**ls -l /pool-***

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>/pool-1:
total 22135
-rw-r--r-- 1 root root 41273476 Oct  2 07:31 pg2600.converter.log

/pool-2:
total 18025
-rw-r--r-- 1 root root 41273476 Oct  2 07:31 pg2600.converter.log

/pool-3:
total 10974
-rw-r--r-- 1 root root 41273476 Oct  2 07:31 pg2600.converter.log

/pool-4:
total 40349
-rw-r--r-- 1 root root 41273476 Oct  2 07:31 pg2600.converter.log
</pre>
</details>

**zfs get all | grep compressratio | grep -v ref**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>pool-1  compressratio           1.82x                   -
pool-2  compressratio           2.23x                   -
pool-3  compressratio           3.66x                   -
pool-4  compressratio           1.00x                   -
</pre>
</details>

**wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>--2026-10-18 19:14:42--  https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&amp;export=download
Resolving drive.usercontent.google.com (drive.usercontent.google.com)... 172.217.23.225, 2a00:1450:400e:811::2001
Connecting to drive.usercontent.google.com (drive.usercontent.google.com)|172.217.23.225|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 7275140 (6.9M) [application/octet-stream]
Saving to: ‘archive.tar.gz’

archive.tar.gz                            100%[=====================================================================================&gt;]   6.94M  5.88MB/s    in 1.2s    

2026-10-18 19:14:55 (5.88 MB/s) - ‘archive.tar.gz’ saved [7275140/7275140]

</pre>
</details>

**tar -xzvf archive.tar.gz**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>zpoolexport/
zpoolexport/filea
zpoolexport/fileb
</pre>
</details>

**zpool import -d zpoolexport/**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>  pool: otus
    id: 6554193320433390805
 state: ONLINE
status: Some supported features are not enabled on the pool.
	(Note that they may be intentionally disabled if the
	&apos;compatibility&apos; property is set.)
action: The pool can be imported using its name or numeric identifier, though
	some features will not be available without an explicit &apos;zpool upgrade&apos;.
config:

	otus                                 ONLINE
	  mirror-0                           ONLINE
	    /home/zfs-ops/zpoolexport/filea  ONLINE
	    /home/zfs-ops/zpoolexport/fileb  ONLINE
</pre>
</details>

**zpool import -d zpoolexport/ otus**

**zpool status**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>  pool: otus
 state: ONLINE
status: Some supported and requested features are not enabled on the pool.
	The pool can still be used, but some features are unavailable.
action: Enable all features using &apos;zpool upgrade&apos;. Once this is done,
	the pool may no longer be accessible by software that does not support
	the features. See zpool-features(7) for details.
config:

	NAME                                 STATE     READ WRITE CKSUM
	otus                                 ONLINE       0     0     0
	  mirror-0                           ONLINE       0     0     0
	    /home/zfs-ops/zpoolexport/filea  ONLINE       0     0     0
	    /home/zfs-ops/zpoolexport/fileb  ONLINE       0     0     0

errors: No known data errors

  pool: pool-1
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-1      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdb     ONLINE       0     0     0
	    sdc     ONLINE       0     0     0

errors: No known data errors

  pool: pool-2
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-2      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdd     ONLINE       0     0     0
	    sde     ONLINE       0     0     0

errors: No known data errors

  pool: pool-3
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-3      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdf     ONLINE       0     0     0
	    sdg     ONLINE       0     0     0

errors: No known data errors

  pool: pool-4
 state: ONLINE
config:

	NAME        STATE     READ WRITE CKSUM
	pool-4      ONLINE       0     0     0
	  mirror-0  ONLINE       0     0     0
	    sdh     ONLINE       0     0     0
	    sdi     ONLINE       0     0     0
	    sdj     ONLINE       0     0     0

errors: No known data errors
</pre>
</details>

**zfs get all otus**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>NAME  PROPERTY                VALUE                   SOURCE
otus  type                    filesystem              -
otus  creation                Fri May 15  4:00 2020   -
otus  used                    2.04M                   -
otus  available               350M                    -
otus  referenced              24K                     -
otus  compressratio           1.00x                   -
otus  mounted                 yes                     -
otus  quota                   none                    default
otus  reservation             none                    default
otus  recordsize              128K                    local
otus  mountpoint              /otus                   default
otus  sharenfs                off                     default
otus  checksum                sha256                  local
otus  compression             zle                     local
otus  atime                   on                      default
otus  devices                 on                      default
otus  exec                    on                      default
otus  setuid                  on                      default
otus  readonly                off                     default
otus  zoned                   off                     default
otus  snapdir                 hidden                  default
otus  aclmode                 discard                 default
otus  aclinherit              restricted              default
otus  createtxg               1                       -
otus  canmount                on                      default
otus  xattr                   sa                      default
otus  copies                  1                       default
otus  version                 5                       -
otus  utf8only                off                     -
otus  normalization           none                    -
otus  casesensitivity         sensitive               -
otus  vscan                   off                     default
otus  nbmand                  off                     default
otus  sharesmb                off                     default
otus  refquota                none                    default
otus  refreservation          none                    default
otus  guid                    14592242904030363272    -
otus  primarycache            all                     default
otus  secondarycache          all                     default
otus  usedbysnapshots         0B                      -
otus  usedbydataset           24K                     -
otus  usedbychildren          2.01M                   -
otus  usedbyrefreservation    0B                      -
otus  logbias                 latency                 default
otus  objsetid                54                      -
otus  dedup                   off                     default
otus  mlslabel                none                    default
otus  sync                    standard                default
otus  dnodesize               legacy                  default
otus  refcompressratio        1.00x                   -
otus  written                 24K                     -
otus  logicalused             1020K                   -
otus  logicalreferenced       12K                     -
otus  volmode                 default                 default
otus  filesystem_limit        none                    default
otus  snapshot_limit          none                    default
otus  filesystem_count        none                    default
otus  snapshot_count          none                    default
otus  snapdev                 hidden                  default
otus  acltype                 off                     default
otus  context                 none                    default
otus  fscontext               none                    default
otus  defcontext              none                    default
otus  rootcontext             none                    default
otus  relatime                on                      default
otus  redundant_metadata      all                     default
otus  overlay                 on                      default
otus  encryption              off                     default
otus  keylocation             none                    default
otus  keyformat               none                    default
otus  pbkdf2iters             0                       default
otus  special_small_blocks    0                       default
otus  prefetch                all                     default
otus  direct                  standard                default
otus  longname                off                     default
otus  defaultuserquota        0                       -
otus  defaultgroupquota       0                       -
otus  defaultprojectquota     0                       -
otus  defaultuserobjquota     0                       -
otus  defaultgroupobjquota    0                       -
otus  defaultprojectobjquota  0                       -
</pre>
</deatils>

**zfs get available otus**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>NAME  PROPERTY   VALUE  SOURCE
otus  available  350M   -
</pre>
</details>

**wget -O otus_task2.file --no-check-certificate https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download**

**zfs receive otus/test@today < otus_task2.file**

**find /otus/test -name "secret_message"**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>/otus/test/task1/file_mess/secret_message</pre>
</details>

**cat /otus/test/task1/file_mess/secret_message**

<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>https://otus.ru/lessons/linux-hl/</pre>
</details>
