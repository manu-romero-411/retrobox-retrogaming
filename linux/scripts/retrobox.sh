#!/bin/bash

#touch /pcgrande/.isRetroBoot
#qdbus org.kde.ksmserver /KSMServer logout 0 1 0

RETROBOXROOT=/pcgrande/Aplicaciones/retrobox

#for window_id in $(xdotool search --onlyvisible ".*"); do
#	xdotool windowminimize $window_id
#done

#kquitapp5 plasmashell
#sleep 2
#qdbus org.kde.KWin /Compositor resume
cd "$RETROBOXROOT"
rm "$RETROBOXROOT/pc-games/*.retro"
#"$RETROBOXROOT/scripts/generate-es-entries.sh"
"$RETROBOXROOT/emulationstation" --home "$RETROBOXROOT"
cd "$HOME"
#qdbus org.kde.KWin /Compositor resume
#plasmashell --replace & exit 0
