import subprocess
import time
import adb

def run_fastboot_command(command):
    """Run a Fastboot command and return the output."""
    try:
        result = subprocess.run(command, shell=True, text=True, capture_output=True, check=True)
        return (result.stdout + result.stderr).strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e.stderr if e.stderr else e.stdout}"

    
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

def flash_custom_rom(initialzip_path, rom_path):
    print("Rebooting in fastbootD mode")
    run_fastboot_command("fastboot reboot fastboot")
    time.sleep(5)

    print("Installing initial zip")
    run_fastboot_command(f'fastboot --skip-reboot update "{initialzip_path}"')
    time.sleep(5)

    print("Rebooting into recovery mode")
    run_fastboot_command("fastboot reboot recovery")
    time.sleep(5)

    print("Sideloading.....")
    if adb.wait_for_device() == True:
        run_fastboot_command(f'adb sideload "{rom_path}"')