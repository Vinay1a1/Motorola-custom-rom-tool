from tkinter import *
from tkinter import ttk
import gui_helper
from tkinter import scrolledtext


root = Tk()
root.title("G54_flashing_utility")

# Mainframe and label setup
mainframe = ttk.Frame(root) 
result = scrolledtext.ScrolledText(mainframe, width=60, height=20, state='disabled', background="black", foreground="white", font=("Consolas", 10))
result.grid(column=10, row=0, pady=0, padx=0)
mainframe.grid( sticky=(N, W, E, S))

# Groups
adb_group = ttk.LabelFrame(mainframe, text=" ADB Commands ", padding=10)
adb_group.grid(column=0, row=0, padx=5, pady=5, sticky=(N, W, E))
fastboot_group = ttk.LabelFrame(mainframe, text = "Fastboot Commands", padding=10)
fastboot_group.grid(column=0, row=1, padx=5, pady=5, sticky=(N, W, E))


# Buttons
adbDevices =ttk.Button(adb_group, text="List ADB devices", command=lambda: gui_helper.update_adb_list(result))
rebootBootloaderAdb = ttk.Button(adb_group, text="Reboot to bootloader via ADB", command=lambda: gui_helper.reboot_blADB(result))
fastbootDevices = ttk.Button(fastboot_group, text="List Fastboot devices", command=lambda: gui_helper.update_fastboot_list(result))
rebootBootloaderFastboot = ttk.Button(fastboot_group, text="Reboot to bootloader via Fastboot", command=lambda: gui_helper.reboot_blfastboot(result))
rebootFastbootD = ttk.Button(fastboot_group, text="Reboot to fastbootD", command= lambda: gui_helper.fastbootd(result))
flashBoot = ttk.Button(fastboot_group, text="Flash boot image", command= lambda:gui_helper.flash_boot(result))
flashRecovery = ttk.Button(fastboot_group, text="Flash vendor_boot(recovery) image", command= lambda:gui_helper.flash_recovery(result))
flashCustomRomBtn = ttk.Button(fastboot_group, text="Flash custom rom zip", command= lambda:gui_helper.flash_custom_rom(result, flashCustomRomBtn))


# Grids
adbDevices.grid(column= 0, row=1, padx=5, pady= 5)
fastbootDevices.grid(column=0, row= 0, padx=5, pady=5)
rebootBootloaderAdb.grid(column= 0, row=0, padx=5, pady= 5)
rebootBootloaderFastboot.grid(column=0,row=1,padx=5,pady=5)
rebootFastbootD.grid(column=0, row=2, padx=5, pady=5)
flashBoot.grid(column=0, row=3, padx=5, pady=5)
flashRecovery.grid(column=0, row=4, padx=5, pady=5)
flashCustomRomBtn.grid(column=0, row=5, padx=5, pady=5)


root.mainloop()
