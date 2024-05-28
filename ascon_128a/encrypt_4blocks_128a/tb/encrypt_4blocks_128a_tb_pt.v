`timescale 1ns / 1ps
//!
//! **PROJECT:**             Lightweight Ascon
//!
//! **LANGUAGE:**            Verilog
//!
//! **FILE:**                encrypt_4blocks_128a_tb
//!
//! **AUTHOR(S):**
//!
//!   - Kashif Inayat      - kashif.inayat@inu.ac.kr
//!   - SafiUllah Khan     - safi.jadoon@live.com
//!
//! **CONTRIBUTORS:**
//!
//!   - Fahad Bin Muslim   - fahadbinmuslim@gmail.com
//!
//! **REVISION:**
//!   * 0.0.1 - Initial release. 2024-05-27
//!
//!
//! | Doc | Schematic | TB | ASRT |Params. Val.| Synthesis test| Unify Interface| Functional Model |
//! |-----|-----------|----|------|------------|---------------|----------------|------------------|
//! |  ✔  |     ✔     |  ✔ |   ✔  |     ✔      |       ✔       |        ✔       |         ✔        |
module encrypt_4blocks_128a_tb();    
    parameter ht=  `hcp;
    reg CLK;
    reg RST;
    reg [127:0] SK, N;
    reg [127:0] A;
    reg [127:0] P;
    wire [127:0] C;
    wire [127:0] T;
  
 // wire [127:0] s11, s12, s13, s14, s15;
//    module permutation12(
//           S_in,
//           S_out
//		   );
    top uut(.CLK(CLK), .RST(RST), .SK(SK), .N(N), .A(A), .P(P), .C(C), .T(T));
                      
    integer fd;
    initial begin
    CLK=0;
    RST=0;
    SK=0;
    N=0;
    A= 0;
    P=0;
    #1 
    RST=1'b1;
    #10
    RST=1'b0;
    #5
    fd=$fopen("../../sample/inputs_float128a.txt", "r");
    
    end


    always @(CLK)
    #(ht) CLK<=~CLK;
    integer i;
    always @ * begin
    for(i=0;i<9999;i=i+1) begin
        #(90*ht)
        $fscanf(fd, "%x %x %x %x", SK, N, A, P);
        $display("SK=%x, N=%x, A=%x, P=%x, C=%x, T=%x\n", SK, N, A, P, C, T);
    end
    //$finish;
    end



endmodule