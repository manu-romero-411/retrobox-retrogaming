#!/bin/bash

ROOTDIR="$(realpath $(realpath $(dirname $0))/..)"
GAMEPATH="/pcgrande/Juegos"

function error(){
	echo "[ERROR] $@"
}

function restore_desktop(){
	cd $HOME
	for i in $(xrandr | grep " connected" | cut -d" " -f1 | tr "\n" " "); do
		    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor${i}/workspace0/last-image -s "$(cat $HOME/.fondo-$i)"
		    rm "$HOME/.fondo-$i"
	done
	xfdesktop -Q
	xfconf-query -c xfce4-desktop -np '/desktop-icons/style' -t 'int' -s '2'
	xfdesktop &
	xfce4-panel &

}

function kodi_load(){
	/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=kodi tv.kodi.Kodi
}

function kahvibreak_load(){
	cd "$GAMEPATH/kahvibreak"
	antimicrox --hidden --profile "$ROOTDIR/antimicro/kahvibreak.gamecontroller.amgp"  & disown
	bash start.sh
}

function vfio_load(){
	restore_desktop
	vfio-iniciarVM "$1"
}

function batocera_load(){
	restore_desktop
	touch "/pcgrande/.isRetroBoot"
	xfce4-session-logout -rf
}

if [ $# -eq 0 ]; then
	error "No hay argumentos"
	exit 1
fi

if [[ $1 != "-rom" ]] || \
[[ $3 != "-system" ]] || \
[[ $5 != "-emu" ]] ; then
	error "Argumentos inválidos"
	exit 1
fi

if [ ! -f "$2" ]; then
	error "Argumento inválido"
fi

app=$(cat "$2" | cut -d"=" -f2)
errorcode=0

if echo "$app" | grep "http"; then
	antimicrox --hidden --profile "$ROOTDIR/antimicro/webapp.gamecontroller.amgp" &
	google-chrome-stable --force-device-scale-factor=1.25 --kiosk --profile-directory="Retrobox" "$app"
	errorcode=$?

else
	if echo "$app" | grep "_vfio"; then
		vfio_load $(echo "$app" | cut -d"_" -f1)
		errorcode=$?
	else
		"${app}_load"
		errorcode=$?
	fi


fi
killall antimicrox

exit $errorcode
