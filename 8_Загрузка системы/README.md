#### Домашнее задание: работа с загрузчиком

Что нужно сделать?
- Включить отображение меню Grub.
- Попасть в систему без пароля несколькими способами.
- Установить систему с LVM, после чего переименовать VG.

#### Описание работы

Включение меню загрузчика на 15 секунд: `nano /etc/default/grub`.

<img width="1021" height="762" alt="Снимок экрана от 2026-11-05 16-55-15" src="https://github.com/user-attachments/assets/f752b454-ad04-4958-b466-0481546d4cfb" />

Вход без пароля с переключением сразу в режим чтения/записи:

<img width="1015" height="761" alt="Снимок экрана от 2026-11-05 17-11-13" src="https://github.com/user-attachments/assets/0215b2ab-f0b4-42fc-b288-94ad3f79de4a" />

Переименование группы томов:

```bash
root@otus:/home/otus# vgs
  VG        #PV #LV #SN Attr   VSize   VFree  
  ubuntu-vg   1   1   0 wz--n- <12.55g <2.55g 
  vg-primary  3   3   0 wz--n- <14.99g  2.98g 

root@otus:/home/otus# vgrename ubuntu-vg ubuntu-ottus
  Volume group "ubuntu-vg" successfully renamed to "ubuntu-ottus"
```
Картина после перезагрузки:

```bash
root@otus:/home/otus# vgs
  VG           #PV #LV #SN Attr   VSize   VFree  
  ubuntu-ottus   1   1   0 wz--n- <12.55g <2.55g 
  vg-primary     3   3   0 wz--n- <14.99g  2.98g 
```
