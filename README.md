# TGInjector

TGInjector v1
19/01/2021

First of all, you need to have the game Soldier Blade on your PSP, nice and working. Note that the game needs an extra folder PSP/GAME/NPUF30016, the iso is not enough.

This tool accepts a Turbografx-16 rom filename as a parameter, or a full pathname, or you can simply drag'n'drop onto the executable. It will produce a file called CONTENT.DAT, which you can copy over the existing one inside PSP/GAME/NPUF30016. Then the internal emulator of the game will use this rom instead of Soldier Blade. Do not use zipped roms, just simple TG-16 roms with the pce extension.

This would be impossible without qwikrazor87's code for the encryption/decryption code and also big thanks to reprep for his guide here, where I found out about this:
https://wololo.net/talk/viewtopic.php?t=41526
