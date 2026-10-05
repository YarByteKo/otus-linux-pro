## Домашнее задание: обновить ядро системы.

Задание выполнялось на развернутой через [Multipass](https://canonical.com/multipass) редакции Ubuntu Server 26.04 LTS со всеми установленными обновлениями на дату выполнения. 

Использовано два варианта обновления: с ручной загрузкой пакетов и PPA от команды Canonical. Преимуществом второго является нативный поиск посредством менеджера apt. 

Все действия выполнялись из под sudo.

```
## ==== Вариант 1: ручная загрузка по URL ==== ##

uname -r
7.0.0-38-generic
mkdir kernel_src && cd kernel_src

wget -r -e robots=off -np -nH --cut-dirs=1 https://kernel.ubuntu.com/mainline/v7.2/amd64/
ls v7.2/amd64/
 CHECKSUMS      'index.html?C=D;O=A'  'index.html?C=N;O=A'   linux-headers-7.2.0-070200-generic_7.2.0-070200.202608162350_amd64.deb          log
 CHECKSUMS.gpg  'index.html?C=D;O=D'  'index.html?C=N;O=D'   linux-headers-7.2.0-070200_7.2.0-070200.202608162350_all.deb                    self-tests
 REBUILD        'index.html?C=M;O=A'  'index.html?C=S;O=A'   linux-image-unsigned-7.2.0-070200-generic_7.2.0-070200.202608162350_amd64.deb   status
 index.html     'index.html?C=M;O=D'  'index.html?C=S;O=D'   linux-modules-7.2.0-070200-generic_7.2.0-070200.202608162350_amd64.deb          summary.yaml

cd v7.2/amd64/
dpkg -i *.deb

ls /boot/
System.map-7.0.0-30-generic      config-7.0.0-30-generic      efi         initrd.img-7.0.0-30-generic      initrd.img.old            vmlinuz-7.0.0-38-generic
System.map-7.0.0-38-generic      config-7.0.0-38-generic      grub        initrd.img-7.0.0-38-generic      vmlinuz                   vmlinuz-7.2.0-070200-generic
System.map-7.2.0-070200-generic  config-7.2.0-070200-generic  initrd.img  initrd.img-7.2.0-070200-generic  vmlinuz-7.0.0-30-generic  vmlinuz.old

reboot

uname -r
7.2.0-070200-generic

## ==== Вариант 2: через PPA с поиском по репозиторию ==== ##

# Добавляем репозиторий и обновляем индекс.
# Остальные действия аналогичны первому варианту.

add-apt-repository ppa:canonical-kernel-team/ppa
apt update
apt search
apt search linux-headers-7
```

В Ubuntu после обновления grub автоматически триггерится и сам обновляет свою конфигурацию, поэтому update-grub не применял. 

После проверки работоспособности новой версии ядра периодически делаю очистку от старых версий.

```
dpkg --list | egrep "linux-image|linux-headers"
apt purge linux-headers-x.x.x.-xx
apt purge linux-image-x.x.x.-xx-generic
```
