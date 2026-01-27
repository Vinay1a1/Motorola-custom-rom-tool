from tkinter import *
import gui_helper
import customtkinter as ctk

# Main window
root = ctk.CTk()
root.title("G54_flashing_utility")
ctk.set_appearance_mode("System")
root.geometry("800x600")
root.columnconfigure(0, weight=1) 
root.rowconfigure(0, weight=1) 

# Mainframe
mainframe = ctk.CTkFrame(root)
mainframe.grid(row=0, column = 0, sticky=(N, W, E, S))
mainframe.columnconfigure(1, weight=1) 
mainframe.rowconfigure(1, weight=1)


# Console "result setup"

result = ctk.CTkTextbox(mainframe, width=60, height=20, font=("Consolas", 12))
result.configure(state = 'disabled')
result.grid(column=1, row=0, rowspan=2, pady=5, padx=5, sticky="nsew")


# Groups
adb_group = ctk.CTkFrame(mainframe)
adb_group.grid(column=0, row=0, padx=5, pady=20, sticky="new")
adb_group.grid_columnconfigure(0, weight=1)
ctk.CTkLabel(adb_group, text="ADB Commands", font=("Segoe UI", 13, "bold")).grid(row=0, column=0, pady=5)


fastboot_group = ctk.CTkFrame(mainframe)
fastboot_group.grid(column=0, row=1, padx=5, pady=20, sticky="new")
fastboot_group.grid_columnconfigure(0, weight=1)
ctk.CTkLabel(fastboot_group, text="Fastboot Commands", font=("Segoe UI", 13, "bold")).grid(row=0, column=0, pady=5)



# Buttons

btn_w = 220 #Button width
# ADB buttons
adbDevices =ctk.CTkButton(adb_group, text="List ADB devices",width=btn_w, command=lambda: gui_helper.update_adb_list(result))
rebootBootloaderAdb = ctk.CTkButton(adb_group, text="Reboot to bootloader via ADB",width=btn_w, command=lambda: gui_helper.reboot_blADB(result))

# Fastboot buttons
fastbootDevices = ctk.CTkButton(fastboot_group, text="List Fastboot devices",width=btn_w, command=lambda: gui_helper.update_fastboot_list(result))
rebootBootloaderFastboot = ctk.CTkButton(fastboot_group, text="Reboot to bootloader via Fastboot",width=btn_w, command=lambda: gui_helper.reboot_blfastboot(result))
rebootFastbootD = ctk.CTkButton(fastboot_group, text="Reboot to fastbootD",width=btn_w, command= lambda: gui_helper.fastbootd(result))
flashBoot = ctk.CTkButton(fastboot_group, text="Flash boot image",width=btn_w, command= lambda:gui_helper.flash_boot(result))
flashRecovery = ctk.CTkButton(fastboot_group, text="Flash vendor_boot(recovery) image",width=btn_w, command= lambda:gui_helper.flash_recovery(result))
flashCustomRomBtn = ctk.CTkButton(fastboot_group, text="Flash custom rom zip",width=btn_w,fg_color="#d35400",hover_color="#e67e22", command= lambda:gui_helper.flash_custom_rom(result, flashCustomRomBtn))


# Grids

# ADB button grid
adbDevices.grid(column= 0, row=1, padx=10, pady= 5)
rebootBootloaderAdb.grid(column= 0, row=2, padx=10, pady= 5)


# Fastboot buttons grid
fastbootDevices.grid(column=0, row= 1, padx=5, pady=5)
rebootBootloaderFastboot.grid(column=0,row=2,padx=5,pady=5)
rebootFastbootD.grid(column=0, row=3, padx=5, pady=5)
flashBoot.grid(column=0, row=4, padx=5, pady=5)
flashRecovery.grid(column=0, row=5, padx=5, pady=5)
flashCustomRomBtn.grid(column=0, row=6, padx=5, pady=5)


root.mainloop()
