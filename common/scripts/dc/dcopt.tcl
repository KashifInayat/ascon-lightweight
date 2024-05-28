#Designer: Kashif Inayat, INU South Korea (www.kashifinayat.github.io)
# run this file with: dc_shell-xg-t -f dcopt.tcl | tee dcopt.out

#Search_Path should be the main directory of your design
set search_path [list . ../]

#Libraries can be define through seperate tcl file
source $::env(TOP_DIR)/../lib_file/lib_container.tcl

#We are reading all verilog files at once by just defining top module name


set DESIGN $::env(TOP_MODULE)

###############################
## Load Design and Elaborate ##
###############################
puts ""
puts ""
puts "===================="
puts "HDL READ"
puts "===================="


analyze -format sverilog -vcs " -f $::env(RTL_FILE_LIST)"


puts ""
puts ""
puts "===================="
puts "ELABORATE"
puts "===================="
elaborate ${DESIGN}



puts ""
puts ""
puts "===================="
puts "LINK"
puts "===================="

link

if {[link] ==0} {
    puts "Error encountered at linking stage. Stopping dc script."
    exit 1
}


check_error
if { [check_error]==1} {
    puts "Error encountered. Stopping dc script."
    exit 1
}



#These are directories for reports/constraints etc
set reports_dir reports
set final_reports_dir final_reports
set constraints_dir const

if { ! [ file exists $constraints_dir ] } { 
         file mkdir $constraints_dir 
} 
if { ! [ file exists $reports_dir ] } { 
         file mkdir $reports_dir 
} 
if { ! [ file exists $final_reports_dir ] } { 
         file mkdir $final_reports_dir 
} 
if { ! [ file exists designs] } { 
         file mkdir designs
} 


#uniquify

# set the constraint 
create_clock CLK -period $cp
# set the constraint for paths starting from primary inputs
set_input_delay 0 -clock CLK [all_inputs]
remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
set_output_delay 0 -clock CLK [all_outputs]

#############
## Compile ##
#############
puts ""
puts ""
puts "===================="
puts "COMPILE"
puts "===================="


set compile_disable_hierarchical_inverter_opt true
compile_ultra -gate_clock -no_autoungroup 

# -retime 
#optimize_registers

#redirect change_names { change_names -rules verilog -hierarchy -verbose }
write_file -f verilog -hier -output designs/postdc_netlist.v

report_qor > $reports_dir/qor_report.txt
report_constraint -all_violators > $reports_dir/violator_report.txt
report_register -level_sensitive > $reports_dir/latch_report.txt
report_clock_gating > $reports_dir/clock_gating.txt
report_timing -max_paths 10 > $reports_dir/synth_timing.rpt
report_area
report_timing
report_power -hier > $reports_dir/power.txt

# Dump out the constraints in an SDC file
write_sdc const/design.sdc -version 1.9

write_file -f ddc -hier -output designs/postdc_netlist.ddc

#report_timing
report_timing > $final_reports_dir/delay.txt
current_design $::env(UUT)
report_area
report_area > $final_reports_dir/area.txt
report_area -hier > $final_reports_dir/ab.txt
report_register > $final_reports_dir/abreg.txt

exit
#remove_design
