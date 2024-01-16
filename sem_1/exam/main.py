from ui.console import UI

ui = UI()
try:
    ui.start()
except:
    print("Something went wrong. Try again later.")
    print('\033[1A' + '\033[K', end='')

