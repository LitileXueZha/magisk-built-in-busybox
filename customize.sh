#!/system/bin/sh

# https://topjohnwu.github.io/Magisk/guides.html#customization
# https://kernelsu.org/zh_CN/guide/module.html#customizing-installation
#


TARGET="/system/bin"
BIN="/data/local/tmp/busybox"
DIR="$MODPATH$TARGET"
if [ -f $BIN ];then :;
elif [ "$KSU" ];then
    BIN="/data/adb/ksu/bin/busybox"
else
    BIN="/data/adb/magisk/busybox"
fi
APPLETS=`$BIN --list`
if [ $? != 0 ];then
    ui_print "******"
    ui_print "BusyBox binary not found."
    ui_print "******"
    abort "exit"
fi

rm -f $DIR/* && cd $DIR
cp $BIN busybox
for applet in $APPLETS;do
    link="$TARGET/$applet"
    if [ ! -x $link -o -L $link -a "$(realpath $link|grep busybox)" ];then
        ln -s busybox $applet
    fi
done
set_perm busybox root shell 755
