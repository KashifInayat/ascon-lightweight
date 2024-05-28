#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27
import re
import os
import sys
import math
import logging
import shutil


def variable(work, word, parameter, index):
    with open(work+"/final_reports/"+parameter+".txt") as f:
        for line in f:
            if re.search(word,line):
                splits = line.strip().split(" ")
                x=splits[len(splits)-index:]

    f.close()
    value = x[0]
    return value

# modules and path 
top_dir     = os.path.dirname(os.path.realpath(__file__))
design  = "encrypt_1block_128"
work_synth=top_dir+"/work_dc" 

#CollectionStarted
#CP
total_time=variable(work_synth, "clock(\s+)CLK(\s+)", "delay",1)
required_time=variable(work_synth, "data(\s+)required(\s+)time", "delay",1)
setup_time=round(round(float(required_time),2)-round(float(total_time),2),2) 
#print(str(total_time)+" = "+str(required_time)+" - "+str(setup_time))

#Area
total_area=variable(work_synth, "Total(\s+)area:", "area",1)
total_cell_area=variable(work_synth, "Total(\s+)cell(\s+)area:", "area",1)
seq_area=variable(work_synth, "Noncombinational(\s+)area:", "area",1)
com_area=variable(work_synth, "Combinational(\s+)area:", "area",1)
intercon_area=variable(work_synth, "Net(\s+)Interconnect(\s+)area:", "area",1)
#print(str(total_area)+" = "+str(total_cell_area)+" + "+str(intercon_area)+" = "+str(seq_area)+" + "+str(com_area))

#Power
total_power = variable(work_synth, "Total(\s+)Power", "power",3)
seq_power = variable(work_synth, "sequential(\s+)(\s+)(\s+)", "power",2)
com_power = variable(work_synth, "combinational(\s+)(\s+)(\s+)", "power",3)
#print(str(total_power)+" = "+str(seq_power)+" + "+str(com_power))


#PDP & ADP
pdp=round(float(total_power)*1000,2)*float(total_time)
adp=round(float(total_time)*round((float(total_cell_area)),0))

#print(pdp)
#print(adp)

# Write Collected Results
modified_l = open("synthesis_result"+design+".txt", "w")
modified_l.write("##########################################################################\n")
modified_l.write("Synthesis Result for "+design+"\n")
modified_l.write("Units: Area (um^2), delay(ns), power(W), PDP (mW.ns), ADP (um^2.ns)\n")
modified_l.write("##########################################################################\n\n\n\n\n")

modified_l.write('%-40s %15s\n' % ("Delay+Setup", str(total_time)))

if(total_area=='undefined'):
    modified_l.write('%-40s %15s\n' % ("Total Area", str(total_area)))
    modified_l.write('%-40s %15s\n' % ("Net Interconnect area", str(total_area)))
else:
    modified_l.write('%-40s %15s\n' % ("Total Area", str(round(float(total_area)))))
    modified_l.write('%-40s %15s\n' % ("Net Interconnect area", str(round(float(intercon_area)))))
modified_l.write('%-40s %15s\n' % ("Cell Area", str(round(float(total_cell_area)))))
modified_l.write('%-40s %15s\n' % ("Noncombinational area", str(round(float(seq_area)))))
modified_l.write('%-40s %15s\n' % ("Combinational area",str(round(float(com_area)))))
modified_l.write('%-40s %15s\n' % ("Power", str(total_power)))
modified_l.write('%-40s %15s\n' % ("Combinational Power", str(com_power)))
modified_l.write('%-40s %15s\n' % ("Sequential Power", str(seq_power)))
modified_l.write('%-40s %15s\n' % ("PDP", str(round(float(pdp),2))))
modified_l.write('%-40s %15s\n' % ("ADP", str(round(float(adp),2))))
modified_l.close()

print("All results are summarized here:"+top_dir +"/synthesis_result"+design+".txt")
# shutil.move("./Synthesis_Result.txt", "./15dc"+str(dirct)+"cp")