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