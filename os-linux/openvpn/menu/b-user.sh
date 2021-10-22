#!/usr/bin/env python

STATUS = "/etc/openvpn/log.log"
status_file = open(STATUS, 'r')  
stats = status_file.readlines()  
status_file.close()
hosts = []
headers = {  
    'cn':    'CLIENT', 
    'virt':  'CLIENT IP',
    'sent':  'DOWNLOAD', 
    'recv':  'UPLOAD',
}
sizes = [  
    (1<<50L, 'PB'),
    (1<<40L, 'TB'),
    (1<<30L, 'GB'),
    (1<<20L, 'MB'),
    (1<<10L, 'KB'),
    (1,       'B')
]
def byte2str(size):  
    for f, suf in sizes:
        if size >= f:
            break
    return "%.2f %s" % (size / float(f), suf)
for line in stats:  
    cols = line.split(',')
    if len(cols) == 5 and not line.startswith('Common Name'):
        host  = {}
        host['cn']    = cols[0]
        host['recv']  = byte2str(int(cols[2]))
        host['sent']  = byte2str(int(cols[3]))
        hosts.append(host)
    if len(cols) == 4 and not line.startswith('Virtual Address'):
        for h in hosts:
            if h['cn'] == cols[1]:
                h['virt'] = cols[0]
fmt = "   %(cn)-16s %(virt)-16s %(sent)14s %(recv)15s "
print fmt % headers  
print "\n".join([fmt % h for h in hosts])