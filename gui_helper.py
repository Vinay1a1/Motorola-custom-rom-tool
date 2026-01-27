import adb
import fastboot
import time
from tkinter import filedialog
from tkinter import messagebox
from pathlib import Path





# ADB
def update_adb_list(result):
    devices = adb.get_devices()
    console_update(result, devices)


# Fastboot
def update_fastboot_list(result):
    devices = fastboot.get_devices()
    console_update(result, devices)


def reboot_blfastboot(result):
    message = "Rebooting to bootloader"
    console_update(result, message)
    fastboot.reboot_bootloader()


def flash_recovery(result):
    file_selected = filedialog.askopenfilename(title = "Select vendor_boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        console_update(result, "Trying to flash vendor boot image")
        output = fastboot.flash_recovery(image_path)
        console_update(result, output)
    else:
        console_update(result, "Aborted by user")

    

def flash_boot(result):
    file_selected = filedialog.askopenfilename(title = "Select boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        console_update(result, "Trying to flash boot image")
        output = fastboot.flash_boot(image_path)
        console_update(result, output)
    else:
        console_update(result, "Aborted by user")


def fastbootd(result):
    console_update(result, "Rebooting into fastbootD mode.")
    output = fastboot.reboot_fastboot()
    console_update(result, output)


def flash_custom_rom(result):
    console_update(result, "Flashing custom rom")


    initialzip = filedialog.askopenfilename(title = "Select initial zip", filetypes = [("Zip files", "*.zip"), ("All files", "*.*")])
    if not initialzip:
        console_update(result, "Operation cancelled.")
        return
    

    rom = filedialog.askopenfilename(title = "Select rom zip", filetypes = [("Zip files", "*.zip"), ("All files", "*.*")])
    if not rom:
        console_update(result, "Operation cancelled.")
        return
    
    confirm = messagebox.askyesno("Final confirmation", "Are you sure you want to proceed?")


    if confirm:
        initialzip_path = Path(initialzip)
        rom_path = Path(rom)

        console_update(result, "Trying to flash custom rom")

        output = fastboot.flash_custom_rom(initialzip_path, rom_path)
        console_update(result, output)
    else:
        console_update(result, "Aborted by user.")


def console_update(result, message):
    result.config(state = 'normal')

    result.insert('end', f">{message}\n")

    result.see('end')
    result.config(state = 'disabled')
    result.update_idletasks()
