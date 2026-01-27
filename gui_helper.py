import adb
import fastboot
import time
from tkinter import filedialog
from tkinter import ttk
from pathlib import Path





# ADB
def update_adb_list(result):
    devices = adb.get_devices()
    result.set(devices)


# Fastboot
def update_fastboot_list(result):
    devices = fastboot.get_devices()
    result.set(devices)


def reboot_blfastboot(result):
    result.set("Rebooting into fastboot mode.....")
    fastboot.reboot_bootloader()


def flash_recovery(result, image_path):
    file_selected = filedialog.askopenfilename(title = "Select vendor_boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        result.set("Trying to flash vendor_boot image")
        output = fastboot.flash_recovery(image_path)
        result.set(output)
    else:
        result.set("Are you retard?")

    

def flash_boot(result):
    file_selected = filedialog.askopenfilename(title = "Select boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        result.set("Trying to flash boot image")
        output = fastboot.flash_boot(image_path)
        result.set(output)
    else:
        result.set("Are you retard?")


def fastbootd(result):
    result.set("Rebooting into fastbootD mode.")
    fastboot.reboot_fastboot()


def flash_custom_rom(result, initialzip_path, rom_path):
    result.set("Flashing custom rom")
    fastboot.flash_custom_rom(initialzip_path, rom_path)