#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27
import sys
import logging
import subprocess
import queue
import threading
import os, shutil, re
import sys, logging, argparse, time
from pathlib import Path
from datetime import date


##NEW
PROGRAM_DESCRIPTION = \
'''Script to run synthesis on all ascon modules on DC/Genus.'''

parser = argparse.ArgumentParser(description =  PROGRAM_DESCRIPTION,
    epilog = 'Report any bugs... :)')

# Top name 
parser.add_argument('-pdk', '--pdk_name', default = "45nm", type = str,
    help = 'Type of operation to perform: {32nm, 45nm, 7nm}.')

args = parser.parse_args()


design  = "encrypt_1block_128" 
os.environ['UUT']					    =	str(design)
os.environ['PDK']                       =   str(args.pdk_name) #from here to Makefile

sys.stdout = open('log_power.txt', 'w')
## STA/Tool Constraints     
top_dir = os.path.dirname(os.path.realpath(__file__))


## Power Analysis   

## SAIF File Generation
subprocess.run(['make', '-f', 'Makefile', 'saif-vcs'], check=True)

## Power Computation
clock_period = 8
 #Frequency you want to calculate power
os.environ['CLOCK']                = str(clock_period) #from here to Makefile
subprocess.run(['make', '-f', 'Makefile', 'power-pt'], check=True)

#LogFile Close
sys.stdout.close()


 ##  Save Synthesize Results 