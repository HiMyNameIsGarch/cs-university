def intput(prompt, method = None):
    if method is None:
        method = lambda x:x

    while True:
        try:
            val = int(input(prompt))
            if not method(val):
                raise ValueError("Invalid restriction")
            return val
        except:
            print('\033[1A'+ '\033[K', end="")


