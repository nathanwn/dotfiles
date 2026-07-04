#!/usr/bin/python3

import datetime


def greet():
    h = datetime.datetime.now().hour
    m = "Good {0}!"
    if h in range(6, 12):
        return m.format("morning")
    elif h in range(12, 17):
        return m.format("afternoon")
    elif h in range(17, 22):
        return m.format("evening")
    else:
        return m.format("night")


if __name__ == "__main__":
    print(greet())
