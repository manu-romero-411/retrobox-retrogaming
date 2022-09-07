@echo off

rem # HAY QUE BORRAR ESTOS ARCHIVOS PARA QUE EN VEZ DE REARRANCAR WINDOWS SALGA EL GRUB
del D:\.winboot
del D:\.wingaming
del D:\.noreboot
start D:\Aplicaciones\windows\Reiniciar.lnk
