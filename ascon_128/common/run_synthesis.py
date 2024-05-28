#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27
import sys
import logging
import subprocess
import queue
import threading
import subprocess
import os, shutil, re
import sys, logging, argparse, time
from pathlib import Path
from datetime import date


  ##////////////////////////##
 ##       FRONT END        ##
##////////////////////////##
##NEW
PROGRAM_DESCRIPTION = \
'''Script to run synthesis on all ascon modules on DC/Genus.'''

parser = argparse.ArgumentParser(description =  PROGRAM_DESCRIPTION,
    epilog = 'Report any bugs... :)')

# Top name 
parser.add_argument('-pdk', '--pdk_name', default = "45nm", type = str,
    help = 'Type of operation to perform: {32nm, 45nm, 7nm}.')

args = parser.parse_args()


def delay(work, word):
    with open(work+"/final_reports/delay.txt") as f:
        for line in f:
            if re.search(word,line):
                splits = line.strip().split(" ")
                x=splits[len(splits)-1:]
    f.close()
    uclock_period = x[0]
    return uclock_period


top_dir     = os.path.dirname(os.path.realpath(__file__))
design  = "encrypt_1block_128" 
## STA/Tool Constraints     
clock_period = 0.2
dc_version = 15
#Started_Logging
os.environ['UUT']					    =	str(design)
os.environ['TIME_PERIOD']               =   str(clock_period) #from here to Makefile
os.environ['PDK']                       =   str(args.pdk_name) #from here to Makefile

with open("./flist.f", "w") as f:
    f.write(top_dir+"/verilog/"+design+".v\n")
    f.write(top_dir+"/verilog/top.v\n")
f.close()

with open("./nflist.f", "w") as f:
    f.write(top_dir+"/work_dc/designs/postdc_netlist.v\n")
    if(args.pdk_name== "45nm"):
        f.write("/soc/vlsi/PDK/FreePDK45/osu_soc/lib/files/gscl45nm.v\n")
    elif(args.pdk_name == "32nm"):
        f.write("/soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v\n")
    elif(args.pdk_name == "14nm"):
        f.write("/soc/vlsi/PDK/FreePDK45/osu_soc/lib/files/gscl45nm.v\n")
    else:
        print("Please specify PDK correctly: e.g, 14nm, 32nm, 45nm or 130nm")
f.close()

sys.stdout = open('log_synthesis.txt', 'w')

#Pre-synthesis verification
pre_test=subprocess.run(['make', '-f', 'Makefile', 'pre-vcs'], check=True, capture_output=True)
print(pre_test)



synthesis=subprocess.run(['make', '-f', 'Makefile', 'syn'], check=True, capture_output=True)
print(synthesis)

work_synth=top_dir+"/work_dc"

delay = delay(work_synth, "slack")

print("Delay is ="+str(delay))

uclock= float(clock_period)-float(delay)
os.environ['TIME_PERIOD'] = str(round(uclock,5))
print("New Clock Period is ="+str(uclock))

synthesis=subprocess.run(['make', '-f', 'Makefile', 'syn'], check=True, capture_output=True)
print(synthesis)

#Pre-synthesis verification
subprocess.run(['make', '-f', 'Makefile', 'post-vcs'], check=True)


sys.stdout.close()

##  Save Synthesize Results 



