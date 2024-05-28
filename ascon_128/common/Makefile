#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27
SCALE=1ns
TOP_DIR				?=	$(PWD)
RTL_FILE_LIST 		?= 	$(TOP_DIR)/flist.f
NTLST_LIST			?= 	$(TOP_DIR)/nflist.f
NTLST_DIR			?=	$(TOP_DIR)/work_dc
TOP_MODULE			?=	top
UUT					?=	ascon_encrypt
TIME_PERIOD 		?=	0.2
CLOCK				?= 	0.4
PDK					?=	45nm




###			vcs -full64 -notice -timescale=1ns/1ps -nc -l build.log -sverilog -f ./scripts/flist.f -LDFLAGS -Wl,--no-as-needed -debug_all -debug_access+all -kdb -lca -assert svaext

##vcs -full64 -notice -timescale=1ns/1ps -nc -l build.log -sverilog -f ../scripts/flist.f  +v2k -debug -gui -o  simv


EXPORT_VARIABLES ?= \
	TOP_DIR \
	RTL_FILE_LIST \
	NTLST_LIST \
	TOP_MODULE \
	UUT	\
	NTLST_DIR \
	PDK \


export $(EXPORT_VARIABLES)



pre-vcs:
	@echo "Pre-VCS Run"
	mkdir work_pre_vcs
	cd work_pre_vcs	&& vcs -full64 $(TOP_DIR)/tb/$(UUT)_tb.v -sverilog -f  $(RTL_FILE_LIST) -debug -o simv && ./simv
	cd ../

syn:
	@echo "Synthesis DC Run"
	rm -r work_dc
	mkdir work_dc
	cd work_dc && dc_shell-xg-t -f $(TOP_DIR)/scripts/dc/dcopt.tcl -x "set cp $(TIME_PERIOD)" | tee dcopt.out
	cd ../

post-vcs:
	@echo "Post Synthesis Verification"
	mkdir work_post_vcs
	cd work_post_vcs && vcs -full64 $(TOP_DIR)/tb/$(UUT)_tb.v -sverilog -f  $(NTLST_LIST) -debug -o simv && ./simv #-gui
	cd ../

saif-vcs:
	@echo "SAIF File Generation"
	mkdir work_pt
	cd work_pt && vcs -full64 $(TOP_DIR)/tb/$(UUT)_tb_pt.v -sverilog -f  $(NTLST_LIST) +v2k +define+hcp=$(CLOCK) -debug -o simv && ./simv -ucli -do $(TOP_DIR)/scripts/pt/gate_level_sim.tcl
	cd ../


power-pt:
	@echo "Power Computation"
	cd work_pt && pt_shell -f $(TOP_DIR)/scripts/pt/power_vector.ptcl | tee run_pt.out
	cd ../



clean:
			@echo "Cleaning up...."
			rm -rf work_*
# post-compile:
# 				@echo "Compiling RTL Design"
# 				mkdir work_post_vcs
# 				cd work_post_vcs
# 				cp ../verilog/tb/parameters.v ./
# 				vcs -full64 ../verilog/tb/t_mbm.v ../work_dc/designs/postdc_netlist.v /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v +v2k +incdir+./ +define+Multiplier +define+INPUT_FILE_NAMEX=\"../inputs/xbitwidth_8_n_10000.txt\"  +define+INPUT_FILE_NAMEY=\"../inputs/ybitwidth_8_n_10000.txt\" +define+WEIGHT_FILE_NAME=\"$2\" +define+WORLD_SIZE=$3 -debug -o simv
# 				./simv #-gui
# 				cd ../

# gen-saif:

# 				mkdir work_pt
# 				cd work_pt
# 				cp ../verilog/tb/parameters.v ./
# 				vcs -full64 ../verilog/tb/t_mbm_pt.v ../work_dc/designs/postdc_netlist.v /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v +v2k +incdir+./ +define+Multiplier +define+INPUT_FILE_NAMEX=\"../inputs/xbitwidth_8_n_10000.txt\"  +define+INPUT_FILE_NAMEY=\"../inputs/ybitwidth_8_n_10000.txt\" +define+WEIGHT_FILE_NAME=\"$2\" +define+WORLD_SIZE=$3 -debug -o simv
# 				./simv  -ucli -do ../scripts/pt/gate_level_sim.tcl
# 				 cd ../

# power-compile:
# 				mkdir work_pt
# 				cd work_pt
# 				cp ../verilog/tb/parameters.v ./
# 				pt_shell -f ../scripts/pt/power_vector.ptcl   | tee run_pt.out
# 				cd ../





# vivado-synth:
# 			@echo "Synthesizing Design"
# 			vivado -mode batch -nolog -nojournal -notrace -source ../scripts/xilinx/mt_xilinx_gen_project.tcl -tclargs $(X_PRJ_NAME) $(X_SYNTH_CFG)




#behav:
#			@echo "Compiling Behav Design"
#			vcs -full64 -notice -timescale=1ns/1ps -nc -l build.log -sverilog -f flist_behav.f -LDFLAGS -Wl,--no-as-needed -debug_all -debug_access -kdb -assert svaext +define+MEMTILE_USE_BEHAV

# file-list:
# 				@for i in $(FILES_NAME); do \
# 					echo $$i; \
# 				done


# pre-compile:
# 				@echo "Compiling RTL Design"
# 				rm -rf ${work}
# 				mkdir ${work}
# 				cd ${work} && cp ../packages/${t}${r}/${d}_${r}_pkg.sv . && vcs -full64 -notice -timescale=1ns/1ps -nc -l build.log -sverilog -f ../scripts/flist.f   -LDFLAGS -Wl,--no-as-needed -debug_all -debug_access+all -kdb -lca -assert svaext;
# 				cd ..
# pre-test:
# 			@echo "Running Test for RTL Design"
# 			cd ${work} &&	./simv;
# 			cd ..

# gui-pre-test:
# 			@echo "Running Test for RTL Design and Opening Verdi"
# 			cd work_pre_vcs &&	./simv -verdi;
# 			cd ..



# synth_mult:
# 				rm -rf ${work}
# 				mkdir ${work}
# 				cd ${work} && dc_shell-xg-t -f ../scripts/dc/${t}${r}/${d}/${d}_dcopt.tcl -x "set cp ${foo}; set w ${w}; set r ${r}; set t ${t}; set d ${d} " | tee dcopt_${d}.out;
# 				cd ../

# synth_PE:
# 				rm -rf ${work}
# 				mkdir ${work}
# 				cd ${work} && dc_shell-xg-t -f ../scripts/dc/${t}${r}/pe_dcopt.tcl -x "set cp ${foo};  set w ${w}; set r ${r}; set t ${t}; set d ${d} " | tee dcopt_${d}.out;
# 				cd ..

# synth_SA:
# 				rm -rf ${work}
# 				mkdir ${work}
# 				cd ${work} && dc_shell-xg-t -f ../scripts/dc/${t}${r}/sa_dcopt.tcl -x "set cp ${foo}; set lc ${loc}; set array_size ${sz}; set w ${w}; set r ${r}; set t ${t}; set d ${d}" | tee dcopt${loc}_sa.out;
# 				cd ..
