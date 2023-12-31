from ui.console import UI
import sys

try:
    ui = UI(sys.argv)
    ui.start()
except Exception as e:
    print(e)
    input("Press any key to exit...")
    exit(1)
