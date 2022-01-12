#!/bin/sh -ex

if [ $npm_config_runtime != electron ]; then
    echo Skipping WCJS installation
    exit
fi

wcjs_version=0.5.2
electron_version=$(echo $npm_config_target | sed s/^v//)
electron_arch=$npm_config_target_arch

case $(uname -s) in
    Linux)
        platform=linux
    ;;
    Darwin)
        platform=osx
        vlc_version=3.0.11
    ;;
    *)
        platform=win
        vlc_version=3.0.11
    ;;
esac

if [ "$vlc_version" = "" ]; then
    url="https://github.com/RSATom/WebChimera.js/releases/download/v${wcjs_version}/WebChimera.js_electron_${electron_version}_${electron_arch}_${platform}.zip"
else
    url="https://github.com/RSATom/WebChimera.js/releases/download/v${wcjs_version}/WebChimera.js_v${wcjs_version}_electron_v${electron_version}_VLC_v${vlc_version}_${electron_arch}_${platform}.zip"
fi

curl -sL "$url" >wcjs.zip
mkdir -p bin
unzip -qq -o -d bin/ wcjs.zip
rm wcjs.zip
