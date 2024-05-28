`timescale 1ns / 1ps
//!
//! **PROJECT:**             Lightweight Ascon
//!
//! **LANGUAGE:**            Verilog
//!
//! **FILE:**                top
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
module top(CLK, RST, SK, N, A, P, C, T);
    input CLK;
    input RST;
    input [127:0] SK, N;
    input [63:0] A;
    input [63:0] P;
    output reg [63:0] C;
    output reg [127:0] T;
    
    
    reg [127:0] SK_REG, N_REG;
    reg [63:0] A_REG;
    reg [63:0] P_REG;
    wire [63:0] C_WIRE;
    wire [127:0] T_WIRE;
    
    always@(posedge CLK)begin
    SK_REG  <= SK;
    N_REG   <= N;
    A_REG   <= A;
    P_REG   <= P;
    C       <= C_WIRE;
    T       <= T_WIRE;
    end  

    encrypt_6blocks_128 uut1(.SK(SK_REG), .N(N_REG), .A(A_REG), .P(P_REG), .clk(CLK), .reset(RST), .C(C_WIRE), .T(T_WIRE));
     
endmodule 