#!/usr/bin/env python

import sys


def printHosts(ip, startRange, EndRange):
    for i in range(startRange, EndRange+1):
        print(ip.replace('X', str(i)))


def usage(name):
    print("Usage: Enter IP with 'X' as the modified octet")
    print(
        "Ex:\t./genHosts.py 10.X.1.2 5\n\t%s [IP] [StartTeam] [EndTeam]" % name)
    print("OR \t./genHosts.py 10.X.1.2.5\n\t%s [IP] [NumTeams]" % name)
    print("Optionally, pipe to xclip with `xclip -sel clip`")
    exit(1)


if __name__ == '__main__':
    args = sys.argv
    if len(args) == 3:
        printHosts(args[1], 1, int(args[2]))
    elif len(args) == 4:
        printHosts(args[1], int(args[2]), int(args[3]))
    else:
        usage(args[0])