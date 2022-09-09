# Proyecto Retrobox

Proyecto de desarrollo de un centro de **emulación**, **gaming** y **multimedia** en #pcgrande.

## Requisitos
Se necesita usar como base **Windows 10** o posterior. Pronto se traducirán los scripts para que funcionen en GNU/Linux.

## Aplicaciones y dependencias necesarias
* [EmulationStation de RetroBat]()
* [AntimicroX](https://github.com/AntiMicroX/antimicrox)
* [Nircmd](https://www.nirsoft.net/utils/nircmd-x64.zip)
* [Sleep.exe]()
* [SilentCMD](https://github.com/stbrenner/SilentCMD)
* [Kodi](https://kodi.tv)
* [Acestream](https://wiki.acestream.media)

## Emuladores
* [RetroArch](https://www.retroarch.com/?page=platforms)
* [Dolphin](https://es.dolphin-emu.org/download/)
* [Redream](https://redream.io/)
* [PCSX2](https://pcsx2.net/downloads/)
* [PPSSPP](https://www.ppsspp.org/downloads.html)
* [Cemu](https://cemu.info/)
* [model2emu](https://segaretro.org/Model_2_Emulator)

## Dónde colocar todo
* Los emuladores van en la carpeta `%retroboxroot%\emuladores`.
* EmulationStation va en `%retroboxroot%\emulationstation`.
* Los scripts auxiliares de EmulationStation van en `%retroboxroot%\emulationstation\loaders`.
* Los archivos de EmulationStation (`es_*.xml`) van en  `%retroboxroot%\emulationstation\.emulationstation`
* Las herramientas y dependencias sueltas deberán ir en `%retroboxroot\misc\tools`. No se incluyen aquí porque son de terceros.

Se debe tener especial esmero al colocar cada archivo en su sitio, ya que se comprobará si existen y se cancelará la ejecución del entorno gaming si alguno falta.