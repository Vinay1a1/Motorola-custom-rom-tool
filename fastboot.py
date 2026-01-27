import subprocess
import time
import adb
import gui_helper

def run_fastboot_command(command):
    """Run a Fastboot command and return the output."""
    try:
        result = subprocess.run(command, shell=True, text=True, capture_output=True, check=True)
        return (result.stdout + result.stderr).strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e.stderr}"

    
def get_devices():
    return run_fastboot_command("fastboot devices")

def reboot_bootloader():
    return run_fastboot_command("fastboot reboot bootloader")

def flash_recovery(image_path):
    return run_fastboot_command(f'fastboot flash vendor_boot "{image_path}"')

def flash_boot(image_path):
    return run_fastboot_command(f'fastboot flash boot "{image_path}"')

def reboot_fastboot():
    return run_fastboot_command("fastboot reboot fastboot")



def flash_custom_rom(result, initialzip_path, rom_path):
    output = "Step 1/4: Rebooting into FastbootD"
    gui_helper.console_update(result, output)

    fastbootd = run_fastboot_command("fastboot reboot fastboot")
    gui_helper.console_update(result, fastbootd)
    time.sleep(5)

    output = ("Step 2/4: Installing initial zip")
    gui_helper.console_update(result, output)
    initialZipInstall = run_fastboot_command(f'fastboot --skip-reboot update "{initialzip_path}"')
    gui_helper.console_update(result, initialZipInstall)
    time.sleep(5)

    output = ("Step 3/4: Rebooting into recovery mode")
    gui_helper.console_update(result, output)
    reboot = run_fastboot_command("fastboot reboot recovery")
    gui_helper.console_update(result, reboot)
    time.sleep(5)

    output = ("Step 4/4: Sideloading......")
    gui_helper.console_update(result, output)
    if adb.wait_for_device():
        sideload = run_fastboot_command(f'adb sideload "{rom_path}"')
        gui_helper.console_update(result, sideload)