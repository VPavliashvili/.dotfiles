import os
import socket
import subprocess

def is_valid_file_system(fstype: str) -> bool:
    file_systems = [
        'ext2',
        'ext3',
        'ext4',
        'btrfs',
        'xfs',
        'jfs',
        'reiserfs',
        'f2fs',
        'zfs',
        'nilfs',
        'vfat',
        'ntfs',
        'hfs',
        'hfs+',
        'udf',
        'exfat',
        'tfat',
        'fat32',
        'fuseblk' # i.e microsoft ntfs hdd
    ]

    return file_systems.__contains__(fstype.lower())

def get_mntinfos() -> list[tuple[str, str]]:
    # findmnt -rno fstype,target
    cmd = ["findmnt", "-rno", "fstype,target,source"]
    result = subprocess.run(cmd, stdout=subprocess.PIPE)
    out = result.stdout.decode("ascii")
    lines = out.split('\n')

    res : list[tuple[str,str]] = []

    for line in lines:
        words = line.split(' ')
        if len(words) != 3:
            continue

        fstype = words[0]
        mntpoint = words[1] 
        if is_valid_file_system(fstype) and '/boot' not in mntpoint:
            source = words[2]
            res.append((mntpoint, source))

    # print(repr(res))
    return res

def get_mountpoint(counter: int) -> tuple[str, str]:
    partinions = get_mntinfos()
    lenght = len(partinions)
    idx = counter % lenght
    dir = partinions[idx]
    return dir

def get_disk_stats():
    counter = get_disk_index_from_socket()

    mntpoint = get_mountpoint(counter)

    stat = os.statvfs(mntpoint[0])

    total = stat.f_blocks * stat.f_frsize / 1024 ** 3
    free = stat.f_bavail * stat.f_frsize / 1024 ** 3
    used = total - free

    return {
        'free': free,
        'total': total,
        'used': used,
        'perc': 100 * used / total,
        'dir': mntpoint[0],
        'device': mntpoint[1] 
    }

def get_disk_index_from_socket() -> int:
    # IPC parameters
    HOST = '127.0.0.1' # The server's hostname or IP address
    PORT = 6000 # The port used by the server
         
    # Create socket
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
         
    s.send("get_disk".encode("ascii"))

    # Wait for 'response'
    data = s.recv(1024)
    disk_counter = int(data.decode())
    return disk_counter
