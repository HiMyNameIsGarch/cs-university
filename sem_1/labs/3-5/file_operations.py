BASE_FILE="input"

def read():
    lst = []
    data = ""
    with open(BASE_FILE, 'r') as f:
        s = f.read()
        if s != '' and s != ' ': data += s

    for e in data.split(' '):
        try:
            lst.append(int(e))
        except:
            continue

    return lst

def append_num(num):
    with open(BASE_FILE, 'a') as f:
        f.write(" " + str(num))

def write_lst(lst:list):
    txt = ""
    for e in lst: txt += str(e) + " "
    with open(BASE_FILE, 'w') as f:
        f.write(txt)
