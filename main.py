import adb
import fastboot
from pathlib import Path

def menu():
    while True:
        print("Select an option:")
        print("1. List ADB devices")
        print("2. Reboot to bootloader via ADB")
        print("3. List Fastboot devices")
        print("4. Reboot to bootloader via Fastboot")
        print("5. Flash recovery(vendor_boot) image via Fastboot")
        print("6. Flash boot image via Fastboot")
        print("7. Flash custom rom(A15 firmware)")
        print("8. Exit")
        choice = input("Enter your choice (1-8): ")
        
        if choice == '1':
            devices = adb.get_devices()
            print(f"ADB Devices:\n{devices}")


        elif choice == '2':
            result = adb.reboot_bootloader()
            print("Rebooting to bootloader via ADB...")


        elif choice == '3':
            devices = fastboot.get_devices()
            print(f"Fastboot Devices:\n{devices}")


        elif choice == '4':
            result = fastboot.reboot_bootloader()
            print("Rebooting to bootloader via Fastboot...")


        elif choice == '5':
            image_path = Path(input("Enter the path to the recovery image: "))
            if image_path.exists():
                result = fastboot.flash_recovery(image_path)
                print(f"Flashing recovery image from {image_path}...")
            else:
                print("Fuck you")


        elif choice == '6':
            image_path = Path(input("Enter the path to the boot image: "))
            if image_path.exists():
                result = fastboot.flash_boot(image_path)
                print(f"Flashing boot image from {image_path}...")
            else:
                print("Fuck you")


        elif choice == '7':
            intialzip_path = Path(input("Enter the path to the initial install zip: "))
            rom_path = Path(input("Enter the path to the custom rom zip: "))
            if intialzip_path.exists() and rom_path.exists():
                result = fastboot.flash_custom_rom(intialzip_path, rom_path)
                print("Flashing custom rom")
            else:
                print("Fuck you")
        elif choice == '8':
            break

        else:
            print("Invalid choice. Please select a valid option.")
            
if __name__ == "__main__":
    menu()