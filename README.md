# ascon-lightweight" 
This repo is for our article submitted for publication, all designs and scripts are inlcuded in this repo. 

```
.
├── ascon_128
│   ├── ascon_encrypt
│   │   ├── tb
│   │   │   ├── ascon_encrypt_tb_pt.v
│   │   │   └── ascon_encrypt_tb.v
│   │   └── verilog
│   │       ├── ascon_encrypt.v
│   │       └── top.v
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
│   └── encrypt_6blocks_128
│       ├── tb
│       │   ├── encrypt_6blocks_128_tb_pt.v
│       │   └── encrypt_6blocks_128_tb.v
│       └── verilog
│           ├── encrypt_6blocks_128.v
│           └── top.v
├── ascon_128a
│   ├── ascon_encrypt128a
│   │   ├── tb
│   │   │   ├── ascon_encrypt128a_tb_pt.v
│   │   │   └── ascon_encrypt128a_tb.v
│   │   └── verilog
│   │       ├── ascon_encrypt128a.v
│   │       └── top.v
│   ├── encrypt_1block_128a
│   │   ├── tb
│   │   │   ├── encrypt_1block_128a_tb_pt.v
│   │   │   └── encrypt_1block_128a_tb.v
│   │   └── verilog
│   │       ├── encrypt_1block_128a.v
│   │       └── top.v
│   ├── encrypt_2blocks_128a
│   │   ├── tb
│   │   │   ├── encrypt_2blocks_128a_tb_pt.v
│   │   │   └── encrypt_2blocks_128a_tb.v
│   │   └── verilog
│   │       ├── encrypt_2blocks_128a.v
│   │       └── top.v
│   └── encrypt_4blocks_128a
│       ├── tb
│       │   ├── encrypt_4blocks_128a_tb_pt.v
│       │   └── encrypt_4blocks_128a_tb.v
│       └── verilog
│           ├── encrypt_4blocks_128a.v
│           └── top.v
├── common
│   ├── collect_all.py
│   ├── Makefile
│   ├── run_power.py
│   ├── run_synthesis.py
│   └── scripts
│       ├── dc
│       │   └── dcopt.tcl
│       └── pt
│           ├── gate_level_sim.tcl
│           └── power_vector.ptcl
├── lib_file
│   ├── lib_container_pt.tcl
│   └── lib_container.tcl
├── README.md
├── run_all.sh
└── sample
    ├── inputs_float128a.txt
    └── inputs_float128.txt

35 directories, 49 files
```
# Contact

Kashif Inayat      - kashif.inayat@inu.ac.kr
SafiUllah Khan     - safi.jadoon@live.com
Fahad Bin Muslim   - fahadbinmuslim@gmail.com