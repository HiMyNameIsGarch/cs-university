from ui.console import UI
import sys

# Main entry point
# This is the first file that is executed when the program is run
# It creates a UI object and starts it
# If an exception is raised, it is caught and printed
# The program exits with an error code
try:
    ui = UI(sys.argv)
    ui.start()
except Exception as e:
    print(e)
    input("Press any key to exit...")
    exit(1)
