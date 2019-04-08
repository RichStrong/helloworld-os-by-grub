# helloworld-os-by-grub
在x86 PC上编写的最简单的helloworld操作系统，并采用grub引导

## 编译配置
编译测试环境为Ubuntu18，需要安装如下工具，其它版本的Linux请自行尝试。

```bash
sudo apt-get install build-essential qemu xorriso nasm
```

## 编译
在源码根目录直接执行：

```bash
make
```

## 运行
### 软件模拟运行
运行main.elf：

```bash
make run
```

运行main.img：
```bash
make run-img
```

### 实际物理机测试
插入一个空白的u盘到电脑，执行如下命令进行刻录：

```bash
sudo dd if=main.img of=/dev/sdb
sync
```

注意：sdb为u盘对应的设备文件，请根据实际情况进行设置，如sda、sdc、sdd等，一定不要弄错。如果误写成了本地硬盘设备文件，将会造成硬盘数据丢失，一定要小心！另外，要保证u盘中无可用数，不然刻录成启动盘后，里面的数据也会被破坏。<br>
刻录好后重启电脑，手动选择从u盘启动。一般为F12、Esc、F11等，由具体电脑的主板所决定，请自行百度。<br>
启动后就可以在电脑的显示器上看到helloworld几个绿色的小字了。
