@echo off

rem # HAY QUE BORRAR ESTOS ARCHIVOS PARA QUE EN VEZ DE REARRANCAR WINDOWS SALGA EL GRUB
sudo del C:\.winboot
sudo del D:\.noreboot
shutdown /r /t 0
