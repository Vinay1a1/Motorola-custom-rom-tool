## flashing-AIO

# Run the adb-set-path.bat first as admin to set the platform tools to path. After that use run.bat. You only need to run adb-set-path once.


It's made for Moto G54. So, use it for other devices at your own risk.

This script can-

 [1] Flash custom rom using adb sideload

 [2] Flash custom rom using fastboot

 [3] Extract vendor boot

 [4] Extract boot image

 [5] Patch boot image using KSU

 [6] Patch boot image using Magisk

 [7] Flash vendor boot using fastbootd

 [8] Flash boot image using fastbootd

 [9] Flash stock using flashfile.xml

The magisk patching option is currently broken and will be added later.

# Note1: To flash rom using fastboot, place rom zip in the same folder.

Use the linux branch if you want to use this tool on linux. If anything is broken then report it. 
