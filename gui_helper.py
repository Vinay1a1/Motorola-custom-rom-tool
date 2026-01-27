import adb
import fastboot
from tkinter import filedialog
from tkinter import messagebox
from pathlib import Path
import threading




# ADB
def update_adb_list(result):
    devices = adb.get_devices()
    console_update(result, devices)

def reboot_blADB(result):
    output = adb.reboot_bootloader()
    console_update(result, output)


# Fastboot
def update_fastboot_list(result):
    devices = fastboot.get_devices()
    console_update(result, devices)
    return devices.strip()


def reboot_blfastboot(result):
    if not check(result):
        return
    message = "Rebooting to bootloader"
    console_update(result, message)
    output = fastboot.reboot_bootloader()
    console_update(result, output)


def flash_recovery(result):
    if not check(result):
        return
    file_selected = filedialog.askopenfilename(title = "Select vendor_boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        console_update(result, "Trying to flash vendor boot image")
        output = fastboot.flash_recovery(image_path)
        console_update(result, output)
    else:
        console_update(result, "Aborted by user")

    

def flash_boot(result):
    if not check(result):
        return
    file_selected = filedialog.askopenfilename(title = "Select boot image", filetypes = [("Image files", "*.img"), ("All files", "*.*")])
    if file_selected:
        image_path = Path(file_selected)
        console_update(result, "Trying to flash boot image")
        output = fastboot.flash_boot(image_path)
        console_update(result, output)
    else:
        console_update(result, "Aborted by user")


def fastbootd(result):
    if not check(result):
        return
    console_update(result, "Rebooting into fastbootD mode.")
    output = fastboot.reboot_fastboot()
    console_update(result, output)


def flash_custom_rom(result, flashCustomRomBtn):
    console_update(result, "Flashing custom rom")


    initialzip = filedialog.askopenfilename(title = "Select initial zip", filetypes = [("Zip files", "*.zip"), ("All files", "*.*")])
    if not initialzip:
        console_update(result, "Operation cancelled.")
        return
    

    rom = filedialog.askopenfilename(title = "Select rom zip", filetypes = [("Zip files", "*.zip"), ("All files", "*.*")])
    if not rom:
        console_update(result, "Operation cancelled.")
        return
    
    initialzip_path = Path(initialzip)
    rom_path = Path(rom)

    if initialzip_path.suffix.lower() != '.zip' or rom_path.suffix.lower() != '.zip':
        messagebox.showerror("Invalid File type", "Both selected files must be .zip files!")
        console_update(result, "Error: Invalid file type selected.")
        return
    
    if not check(result):
        return
    
    confirm = messagebox.askyesno("Final confirmation", "Are you sure you want to proceed?")



    if confirm:
        console_update(result, "Trying to flash custom rom")

        thread = threading.Thread(target=fastboot.flash_custom_rom, args=(result, initialzip_path, rom_path))
        flashCustomRomBtn.config(state= 'disabled')
        thread.daemon = True
        thread.start()
        
        console_update(result, "Flashing running in background. Don't close this app")
        
    else:
        console_update(result, "Aborted by user.")
        flashCustomRomBtn.config(state= 'normal')


def console_update(result, message):
    result.configure(state = 'normal')

    result.insert('end', f">{message}\n")

    result.see('end')
    result.configure(state = 'disabled')
    result.update_idletasks()


def check(result):
    devices = update_fastboot_list(result)
    if not devices:
        console_update(result, "Something went wrong.")
        return None
    return True