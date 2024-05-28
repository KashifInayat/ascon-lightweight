
#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27

#################
#       PDKs    #   
#################
set synthetic_library dw_foundation.sldb
if {$::env(PDK) eq "14nm"} {
set stdcell_dir /home/nas163/kashif/synopsysPDK/SAED14nm_PDK_12142021/SAED14nm_EDK/lib/stdcell_hvt/db_nldm
set liberty_dir /home/nas163/kashif/synopsysPDK/SAED14nm_PDK_12142021/SAED14nm_EDK/lib/io_std/db_nldm
set link_library "*  $stdcell_dir/saed14hvt_ss0p72v125c.db     $liberty_dir/saed14io_fc_ss0p72v125c_1p62v.db    $synthetic_library  "
set target_library "  $stdcell_dir/saed14hvt_ss0p72v125c.db     $liberty_dir/saed14io_fc_ss0p72v125c_1p62v.db  "
} elseif {$::env(PDK) eq "32nm"} {
set liberty_dir /soc/vlsi/PDK/SAED32_EDK/references/orca/dc/models
set stdcell_dir /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/db_nldm
set link_library "*  $stdcell_dir/saed32hvt_ss0p95v125c.db    $liberty_dir/saed32io_ss0p95v125c_2p25v.db    $synthetic_library  "
set target_library "  $stdcell_dir/saed32hvt_ss0p95v125c.db    $liberty_dir/saed32io_ss0p95v125c_2p25v.db  "
} elseif {$::env(PDK) eq "45nm"} {
set LIB_SYNTH_COMPLETE /soc/vlsi/PDK/FreePDK45/osu_soc/lib/files
set link_library "* $LIB_SYNTH_COMPLETE/gscl45nm.db     $synthetic_library"
set target_library "  $LIB_SYNTH_COMPLETE/gscl45nm.db   "
} elseif {$::env(PDK) eq "130nm"} {
set LIB_SYNTH_COMPLETE /soc/vlsi/PDK/skywater-pdk/vendor/synopsys/PlaceRoute/sky130_fd_sc_hd/db_nldm
set link_library "* $LIB_SYNTH_COMPLETE/sky130_fd_sc_hd__tt_025C_1v80.db    $synthetic_library  "
set target_library "  $LIB_SYNTH_COMPLETE/sky130_fd_sc_hd__tt_025C_1v80.db  "
} else {
    puts "Please specify PDK correctly: e.g, 14nm, 32nm, 45nm or 130nm"
}
