import subprocess
import time

def run_adb_command(command):
    """Run an ADB command and return the output."""
    try:
        result = subprocess.run(command, shell=True, text=True, capture_output=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error running adb command: {e.stderr}")
        return None
    
def get_devices():
    return run_adb_command("adb devices")

def reboot_bootloader():
    return run_adb_command("adb reboot bootloader")

def wait_for_device():
    while True:
        result = subprocess.run("adb devices", shell=True, capture_output=True, text=True)
        if "sideload" in result.stdout:
            print("Device is in adb sideload mode")
            return True
        print(".", end="", flush = True)
        time.sleep(5)