# ascon-lightweight" 
This repo is for our article submitted for publication, all designs and scripts are inlcuded in this repo. 

#Structure
```
./
├── ascon_128
│   ├── ascon_encrypt
│   │   ├── tb
│   │   │   ├── ascon_encrypt_tb_pt.v
│   │   │   └── ascon_encrypt_tb.v
│   │   └── verilog
│   │       ├── ascon_encrypt.v
│   │       └── top.v
│   ├── common
│   │   ├── collect_all.py
│   │   ├── Makefile
│   │   ├── run_power.py
│   │   ├── run_synthesis.py
│   │   └── scripts
│   │       ├── dc
│   │       │   └── dcopt.tcl
│   │       └── pt
│   │           ├── gate_level_sim.tcl
│   │           └── power_vector.ptcl
│   ├── encrypt_1block_128
│   │   ├── tb
│   │   │   ├── encrypt_1block_128_tb_pt.v
│   │   │   └── encrypt_1block_128_tb.v
│   │   └── verilog
│   │       ├── encrypt_1block_128.v
│   │       └── top.v
│   ├── encrypt_2blocks_128
│   │   ├── tb
│   │   │   ├── encrypt_2blocks_128_tb_pt.v
│   │   │   └── encrypt_2blocks_128_tb.v
│   │   └── verilog
│   │       ├── encrypt_2blocks_128.v
│   │       └── top.v
│   ├── encrypt_3blocks_128
│   │   ├── tb
│   │   │   ├── encrypt_3blocks_128_tb_pt.v
│   │   │   └── encrypt_3blocks_128_tb.v
│   │   └── verilog
│   │       ├── encrypt_3blocks_128.v
│   │       └── top.v
│   ├── encrypt_6blocks_128
│   │   ├── tb
│   │   │   ├── encrypt_6blocks_128_tb_pt.v
│   │   │   └── encrypt_6blocks_128_tb.v
│   │   └── verilog
│   │       ├── encrypt_6blocks_128.v
│   │       └── top.v
│   ├── lib_file
│   │   ├── lib_container_pt.tcl
│   │   └── lib_container.tcl
│   ├── run_all.sh
│   └── sample
│       ├── inputs_float128a.txt
│       └── inputs_float128.txt
├── README.md

```


22 directories, 34 files
