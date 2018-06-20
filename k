#!/bin/bash
adb='/home/ltan/system-config/bin/my-adb'
target=$1

case $target in
    settings|setting|set)
        $adb k 'com.android.settings'
        ;;
    setup|setupwizard|suw)
        $adb k 'com.smartisanos.setupwizard'
        ;;
    packageInstaller|package|pack|pi|PI)
        $adb k 'com.android.packageinstaller'
        ;;
    sara|voice)
        $adb k 'com.smartisanos.sara'
        ;;
    *)
        ;;
esac
