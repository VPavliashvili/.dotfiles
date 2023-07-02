#!/usr/bin/python

import json
from helper import get_disk_stats

class Data:
    def __init__(self, text: str, tooltip: str):
        self.text = text
        self.tooltip = tooltip

result = get_disk_stats()

percentage = round(result['perc'], 1)
used = round(result['used'], 1)
total = round(result['total'], 1)

format = "%sG/%sG(%s%%) " %(used, total, percentage)
onhover = "%s -> %s" %(result['device'], result['dir'])

data = Data(format, onhover)

json = json.dumps(data.__dict__)
print(json)
