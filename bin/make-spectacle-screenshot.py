#!/bin/python3
import os
import datetime

current_time = datetime.datetime.now()

date = current_time.strftime("%Y") + "-" + current_time.strftime("%m") + "-" + current_time.strftime("%d")
time = current_time.strftime("%X")

file_name = date + "T" + time + ".png"

command = "spectacle --region --background --nonotify --copy-image --output "
command = command + "/home/lucy/Pictures/Screenshots/" + file_name

os.system(command)