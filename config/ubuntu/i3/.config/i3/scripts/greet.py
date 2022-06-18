#!/usr/bin/python3

import datetime
import getpass

def greet():
    u = getpass.getuser()
    h = datetime.datetime.now().hour
    m = "Good {0}, {1}!"
    if h in range(6, 12):
        return m.format('morning', u)
    elif h in range(12, 17):
        return m.format('afternoon', u)
    elif h in range(17, 22):
        return m.format('evening', u)
    else:
        return m.format('night', u)

if __name__ == '__main__':
    print(greet())
