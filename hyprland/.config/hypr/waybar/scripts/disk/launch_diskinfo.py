#!/usr/bin/env python

import os
import subprocess
from helper import get_disk_stats

def launch_ncdu():
    stats = get_disk_stats()
    mp = stats['dir']

    if not mp or not os.path.exists(mp) or mp is None:
        print('provided path is not valid')
        return

    print('provided path -> %s' % mp)
    
    cmd = [
		'/usr/bin/sakura',
		'-t',
		'pop-up',
		'-e',
		'/usr/bin/ncdu %s' % mp,
		'-x',
	]

    subprocess.Popen(
		cmd,
		stdout=open(os.devnull, 'w'),
		stderr=subprocess.STDOUT
	)

launch_ncdu()
