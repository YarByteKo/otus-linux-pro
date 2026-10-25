### Домашнее задание

1) запустить 2 виртуальные машины (сервер NFS и клиента);
2) на сервере NFS должна быть подготовлена и экспортирована директория;
3) в экспортированной директории должна быть поддиректория с именем upload с правами на запись в неё;
4) экспортированная директория должна автоматически монтироваться на клиенте при старте виртуальной машины (systemd, autofs или fstab — любым способом);
5) монтирование и работа NFS на клиенте должна быть организована с использованием NFSv3.

-----

В рамках домашнего задания установлены и исследованы возможности Vagrant и Ansible. 
Первой проблемой оказался выбор образа, т.к. после Ubuntu 24.04 Canonical перестали подготавливать адаптированные образа.
По итогу от использования Packer для официального ISO отказался, выбрал подходящий вариант от сообщества.

- Две машины объединены в одну сеть.
- SSH в конфигурации присутствует как альтернативный вариант доступа.
- Все шаги домашнего задания описаны в плейбуке.
- Для проверки итогового результата загружается архив с исходниками ядра, после чего сверяется его SHA-256 и проверяется доступность на клиентской стороне.
- В итоговом варианте остался NFSv4, т.к. рассматривалось добавление третьего сервера под задачи аутентификации Kerberos, он он отсутствует в плейбуке.

Для проверки тестового окружения нужно сначала установить зависимости:

```bash
sudo apt update && sudo apt install virtualbox

sudo modprobe vboxdrv

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt install vagrant

sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install ansible
```

Далее подготовить директорию с файлами Vagrantfile и playbook.yml, из которой всё разворачивается одной командой: **`vagrant up --provider virtualbox`**.

<details>
<summary><h7>Процесс развёртывания и результат</h7></summary>
  
<pre>Bringing machine &apos;server-side&apos; up with &apos;virtualbox&apos; provider...
Bringing machine &apos;client-side&apos; up with &apos;virtualbox&apos; provider...
<b>==&gt; server-side: Importing base box &apos;bento/ubuntu-26.04&apos;...</b>
<b>==&gt; server-side: Matching MAC address for NAT networking...</b>
<b>==&gt; server-side: Setting the name of the VM: Otus_server-side_1792964249883_30838</b>
<b>==&gt; server-side: Clearing any previously set network interfaces...</b>
<b>==&gt; server-side: Preparing network interfaces based on configuration...</b>
    server-side: Adapter 1: nat
    server-side: Adapter 2: intnet
<b>==&gt; server-side: Forwarding ports...</b>
    server-side: 22 (guest) =&gt; 28320 (host) (adapter 1)
    server-side: 22 (guest) =&gt; 2222 (host) (adapter 1)
<b>==&gt; server-side: Running &apos;pre-boot&apos; VM customizations...</b>
<b>==&gt; server-side: Booting VM...</b>
<b>==&gt; server-side: Waiting for machine to boot. This may take a few minutes...</b>
    server-side: SSH address: 127.0.0.1:2222
    server-side: SSH username: vagrant
    server-side: SSH auth method: private key
    server-side: 
    server-side: Vagrant insecure key detected. Vagrant will automatically replace
    server-side: this with a newly generated keypair for better security.
    server-side: 
    server-side: Inserting generated public key within guest...
    server-side: Removing insecure key from the guest if it&apos;s present...
    server-side: Key inserted! Disconnecting and reconnecting using new SSH key...
<b>==&gt; server-side: Machine booted and ready!</b>
<b>==&gt; server-side: Checking for guest additions in VM...</b>
<b>==&gt; server-side: Setting hostname...</b>
<b>==&gt; server-side: Configuring and enabling network interfaces...</b>
<b>==&gt; client-side: Importing base box &apos;bento/ubuntu-26.04&apos;...</b>
<b>==&gt; client-side: Matching MAC address for NAT networking...</b>
<b>==&gt; client-side: Setting the name of the VM: Otus_client-side_1792964424174_51926</b>
<b>==&gt; client-side: Fixed port collision for 22 =&gt; 2222. Now on port 2200.</b>
<b>==&gt; client-side: Clearing any previously set network interfaces...</b>
<b>==&gt; client-side: Preparing network interfaces based on configuration...</b>
    client-side: Adapter 1: nat
    client-side: Adapter 2: intnet
<b>==&gt; client-side: Forwarding ports...</b>
    client-side: 22 (guest) =&gt; 28321 (host) (adapter 1)
    client-side: 22 (guest) =&gt; 2200 (host) (adapter 1)
<b>==&gt; client-side: Running &apos;pre-boot&apos; VM customizations...</b>
<b>==&gt; client-side: Booting VM...</b>
<b>==&gt; client-side: Waiting for machine to boot. This may take a few minutes...</b>
    client-side: SSH address: 127.0.0.1:2200
    client-side: SSH username: vagrant
    client-side: SSH auth method: private key
    client-side: 
    client-side: Vagrant insecure key detected. Vagrant will automatically replace
    client-side: this with a newly generated keypair for better security.
    client-side: 
    client-side: Inserting generated public key within guest...
    client-side: Removing insecure key from the guest if it&apos;s present...
    client-side: Key inserted! Disconnecting and reconnecting using new SSH key...
<b>==&gt; client-side: Machine booted and ready!</b>
<b>==&gt; client-side: Checking for guest additions in VM...</b>
<b>==&gt; client-side: Setting hostname...</b>
<b>==&gt; client-side: Configuring and enabling network interfaces...</b>
<b>==&gt; client-side: Running provisioner: ansible...</b>
    client-side: Running ansible-playbook...
<font color="#FF00FF"><b>[WARNING]: Deprecation warnings can be disabled by setting `deprecation_warnings=False` in ansible.cfg.</b></font>
<font color="#CD00CD">[DEPRECATION WARNING]: The &apos;--inventory-file&apos; argument is deprecated. This feature will be removed from ansible-core version 2.23. Use -i or --inventory instead.</font>

PLAY [Старт развёртывания серверной части NFS] *********************************

TASK [Gathering Facts] *********************************************************
<font color="#FF00FF"><b>[WARNING]: Host &apos;server-side&apos; is using the discovered Python interpreter at &apos;/usr/bin/python3.14&apos;, but future installation of another Python interpreter could cause a different interpreter to be discovered. See https://docs.ansible.com/ansible-core/2.21/reference_appendices/interpreter_discovery.html for more information.</b></font>
<font color="#00CD00">ok: [server-side]</font>

TASK [Установка NFS-сервера] ***************************************************
<font color="#CDCD00">changed: [server-side]</font>

TASK [Создание группы, которая будет иметь доступ к NFS-экспорту] **************
<font color="#CDCD00">changed: [server-side]</font>

TASK [Добавление пользователя vagrant в группу загрузки на сервере NFS] ********
<font color="#CDCD00">changed: [server-side]</font>

TASK [Создание каталога для NFS-экспорта] **************************************
<font color="#CDCD00">changed: [server-side]</font>

TASK [Настройка экспорта NFS] **************************************************
<font color="#CDCD00">changed: [server-side]</font>

TASK [Запуск и активация NFS-сервера] ******************************************
<font color="#00CD00">ok: [server-side]</font>

TASK [Применение конфигурации экспорта NFS] ************************************
<font color="#00CD00">ok: [server-side]</font>

TASK [Тестовая загрузка архива ядра Linux] *************************************
<font color="#CDCD00">changed: [server-side]</font>

TASK [Результат] ***************************************************************
<font color="#00CD00">ok: [server-side] =&gt; {</font>
<font color="#00CD00">    &quot;msg&quot;: &quot;Развёртывание серверной части завершено.&quot;</font>
<font color="#00CD00">}</font>

TASK [Получение хеш-суммы архива] **********************************************
<font color="#00CD00">ok: [server-side]</font>

TASK [Верификация загруженного архива] *****************************************
<font color="#00CD00">ok: [server-side] =&gt; {</font>
<font color="#00CD00">    &quot;changed&quot;: false,</font>
<font color="#00CD00">    &quot;msg&quot;: &quot;Проверка пройдена: архив linux-7.2.12.tar.xz размещён в /srv/share/upload, хеш-сумма: bb18468a8dc8978aa00caa6446e753f7b6da3fee56b6b7f38b16f9430ba02d4f.&quot;</font>
<font color="#00CD00">}</font>

PLAY [Старт развёртывания клиентской части NFS] ********************************

TASK [Gathering Facts] *********************************************************
<font color="#FF00FF"><b>[WARNING]: Host &apos;client-side&apos; is using the discovered Python interpreter at &apos;/usr/bin/python3.14&apos;, but future installation of another Python interpreter could cause a different interpreter to be discovered. See https://docs.ansible.com/ansible-core/2.21/reference_appendices/interpreter_discovery.html for more information.</b></font>
<font color="#00CD00">ok: [client-side]</font>

TASK [Установка NFS-клиента] ***************************************************
<font color="#CDCD00">changed: [client-side]</font>

TASK [Создание группы, которая будет иметь доступ к NFS-экспорту] **************
<font color="#CDCD00">changed: [client-side]</font>

TASK [Добавление пользователя vagrant в группу загрузки на клиенте NFS] ********
<font color="#CDCD00">changed: [client-side]</font>

TASK [Создание каталога для монтирования] **************************************
<font color="#CDCD00">changed: [client-side]</font>

TASK [Ожидание запуска NFSv4 на сервере] ***************************************
<font color="#00CD00">ok: [client-side]</font>

TASK [Настройка автомонтирования NFS] ******************************************
<font color="#CDCD00">changed: [client-side]</font>

TASK [Получение хеш-суммы архива] **********************************************
<font color="#00CD00">ok: [client-side]</font>

TASK [Верификация загруженного архива] *****************************************
<font color="#00CD00">ok: [client-side] =&gt; {</font>
<font color="#00CD00">    &quot;changed&quot;: false,</font>
<font color="#00CD00">    &quot;msg&quot;: &quot;Проверка пройдена: клиент получил доступ к linux-7.2.12.tar.xz через NFS, хеш-сумма: bb18468a8dc8978aa00caa6446e753f7b6da3fee56b6b7f38b16f9430ba02d4f.&quot;</font>
<font color="#00CD00">}</font>

PLAY RECAP *********************************************************************
<font color="#CDCD00">client-side</font>                : <font color="#00CD00">ok=9   </font> <font color="#CDCD00">changed=5   </font> unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
<font color="#CDCD00">server-side</font>                : <font color="#00CD00">ok=12  </font> <font color="#CDCD00">changed=6   </font> unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

</pre>
</details>


-----
Источники: 

https://developer.hashicorp.com/vagrant/install

https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html
