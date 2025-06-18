SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
print_modname() {
ui_print "    ●=================● ●=================●"
sleep 2s
ui_print "[~] Checking Your Device"
ui_print " Device -> $(getprop ro.product.system.device)"
sleep 1s
ui_print " Kernel -> $(uname -r)"
sleep 1s
ui_print " Brand -> $(getprop ro.product.system.brand)"
sleep 1s
if [[ $sdm == "SDM" ]]; then
cpus=Snapdragon
elif [[ $mtk == "MT" ]]; then
cpus=Mediatek
fi
ui_print " • SELinux Status : $(getenforce)"
ui_print "    ●=================● ●=================●"
sleep 1s
ui_print "    ●========●𝗢𝗣𝗧𝗜𝗠𝗜𝗭𝗜𝗡𝗚 𝗚𝗔𝗠𝗘𝗦●==========●"
sleep 3
ui_print "________________________________________________________"
ui_print ""
busybox sleep 1
ui_print " 🚩𝑹𝒂𝒑𝒉𝒂𝒆𝒍 𝑮𝒂𝒎𝒆𝒓𝒔 🇮🇳"
ui_print "________________________________________________________"
sleep 1
ui_print ""
ui_print "  [𝐒𝐜𝐫𝐢𝐩𝐭] >> 𝙇𝙤𝙖𝙙𝙞𝙣𝙜.... "
sleep 2
ui_print "  [𝐒𝐜𝐫𝐢𝐩𝐭] >> 𝙄𝙣𝙨𝙩𝙖𝙡𝙡𝙞𝙣𝙜.... "
ui_print "  [𝐈𝐧𝐬𝐭𝐚𝐥𝐥𝐞𝐝 ] >> 𝐏𝐥𝐞𝐚𝐬𝐞 𝐖𝐚𝐢𝐭 𝐚 𝐦𝐨𝐦𝐞𝐧𝐭, 𝐅𝐢𝐧𝐚𝐥 𝐏𝐫𝐨𝐜𝐞𝐬𝐬𝐢𝐧𝐠 "
sleep 3
ui_print ""
ui_print "    ●=================● ●=================●"
ui_print ""
ui_print "    ✴️Feel The Performance and Smoothness ✴️  "
}
on_install() {
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  
}
extract_files() {
unzip -o "$ZIPFILE" 'post-fs-data.sh' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'service.sh' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'data/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'system.prop' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}
unzip -o "$ZIPFILE" 'common*' -d $MODPATH >&2
chmod +x /data/adb/modules/Raphael/common/Majestic.sh >&2
perm() {
set_perm_recursive $MODPATH 0 0 0777 0777

}
  
set -x
mod_print
extract_files
perm
