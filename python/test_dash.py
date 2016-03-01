## Streaming Videos from a CDN and do traceroute and pings to the CDN
# trace_cdn.py
# Chen Wang, Jan. 3, 2016
# chenw@cmu.edu
import random
import sys
import os
import logging
import shutil
import time
import csv
from datetime import datetime
from dash_client import *
from monitor.ping import *
from monitor.get_hop_info import *

### Get client name and attache to the closest cache agent
client_name = getMyName()

## Denote the server info
# cdn_host = 'cmu-agens.azureedge.net'
# cdn_host = 'aws.cmu-agens.com'
cdn_host = sys.argv[1]
video_name = 'BBB'
print "Server to download the video:", cdn_host

if len(sys.argv) > 2:
	num_runs = int(sys.argv[2])
else:
	num_runs = 2

print "Number of runs:", str(num_runs)

## ==================================================================================================
## Client name and info
client = getMyName()
cur_ts = time.strftime("%m%d%H%M")
client_ID = client + "_" + cur_ts

trace_fields = ["TS", "Buffer", "Freezing", "QoE1", "QoE2", "Representation", "Response", "Server", "ChunkID"]
csv_trace_folder = os.getcwd() + "/dataQoE/"

try:
	os.stat(csv_trace_folder)
except:
	os.mkdir(csv_trace_folder)

csv_trace_file = client_ID + ".csv"
out_csv_trace = open(csv_trace_folder + csv_trace_file, 'wb')
out_csv_writer = csv.DictWriter(out_csv_trace, fieldnames=trace_fields)
out_csv_writer.writeheader()

## ==================================================================================================
### Get the server to start streaming
for i in range(num_runs):

	## Testing rtt based server selection
	selected_srv_addr = cdn_host + '/videos/'
	CDN_SQS, uniq_srvs = dash_client(selected_srv_addr, video_name, client_ID, out_csv_writer)

## Close tracefile
out_csv_trace.close()
