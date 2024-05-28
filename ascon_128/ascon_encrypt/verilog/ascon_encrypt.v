`timescale 1ns / 1ps
//!
//! **PROJECT:**             Lightweight Ascon
//!
//! **LANGUAGE:**            Verilog
//!
//! **FILE:**                ascon_encrypt
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
  
module ascon_encrypt(SK, N, A, P, C, T

    );
    
    input [127:0] SK, N;
    input [63:0] A;
    input [63:0] P;
    output [63:0] C;
    output [127:0] T;
    
    wire [63:0] s21, s22, s23, s24, s25;
    wire [63:0] s31, s32, s33, s34, s35;
    wire [63:0] s41, s42, s43, s44, s45;
    
   initialization i1 (SK, N, s21, s22, s23, s24, s25);
   
   associated a1 (A, s21, s22, s23, s24, s25, s31, s32, s33, s34, s35);
   
   plaintext pp1 (P, C, s31, s32, s33, s34, s35, s41, s42, s43, s44, s45);
   
   finalization f1 (SK, s41, s42, s43, s44, s45, T);
  
endmodule 
///////////////////////////////////////////////////////////////////

module initialization (SK, N, s31, s32, s33, s34, s35);

input [127:0] SK;
input [127:0] N;

output [63:0] s31, s32, s33, s34, s35;

wire [63:0] IV;
wire [63:0] s11, s12, s13, s14, s15;
wire [63:0] s21, s22, s23, s24, s25;

assign IV = 64'h80400c0600000000;
assign {s11, s12, s13, s14, s15} = {IV, SK, N};

permutation_12 P1 (s11, s12, s13, s14, s15, s21, s22, s23, s24, s25);

assign {s31, s32, s33, s34, s35} = {s21, s22, s23, s24, s25} ^ {192'b00, SK};

endmodule
//////////////////////////////////////////////////////////////////////////////////////

module permutation_12(
                            is0, is1, is2, is3, is4,
                             rd121, rd122, rd123, rd124, rd125
		                );

input [63:0] is0, is1, is2, is3, is4;

wire [63:0] add1, add2, add3, add4, add5, add6, add7, add8, add9, add10, add11, add12;

wire [63:0] rs11, rs12, rs13, rs14, rs15;
wire [63:0] rd11, rd12, rd13, rd14, rd15;

wire [63:0] rs21, rs22, rs23, rs24, rs25;
wire [63:0] rd21, rd22, rd23, rd24, rd25;

wire [63:0] rs31, rs32, rs33, rs34, rs35;
wire [63:0] rd31, rd32, rd33, rd34, rd35;

wire [63:0] rs41, rs42, rs43, rs44, rs45;
wire [63:0] rd41, rd42, rd43, rd44, rd45;

wire [63:0] rs51, rs52, rs53, rs54, rs55;
wire [63:0] rd51, rd52, rd53, rd54, rd55;

wire [63:0] rs61, rs62, rs63, rs64, rs65;
wire [63:0] rd61, rd62, rd63, rd64, rd65;

wire [63:0] rs71, rs72, rs73, rs74, rs75;
wire [63:0] rd71, rd72, rd73, rd74, rd75;

wire [63:0] rs81, rs82, rs83, rs84, rs85;
wire [63:0] rd81, rd82, rd83, rd84, rd85;

wire [63:0] rs91, rs92, rs93, rs94, rs95;
wire [63:0] rd91, rd92, rd93, rd94, rd95;

wire [63:0] rs101, rs102, rs103, rs104, rs105;
wire [63:0] rd101, rd102, rd103, rd104, rd105;

wire [63:0] rs111, rs112, rs113, rs114, rs115;
wire [63:0] rd111, rd112, rd113, rd114, rd115;

wire [63:0] rs121, rs122, rs123, rs124, rs125;
output [63:0] rd121, rd122, rd123, rd124, rd125;


//Round 1
assign add1 = is2 ^ 64'h00000000000000f0;
substitution_single s1 (is0, is1, add1, is3, is4, rs11, rs12, rs13, rs14, rs15);
diffusion_single d1 (rs11, rs12, rs13, rs14, rs15, rd11, rd12, rd13, rd14, rd15);

//Round 2
assign add2 = rd13 ^ 64'h00000000000000e1;
substitution_single s2 (rd11, rd12, add2, rd14, rd15, rs21, rs22, rs23, rs24, rs25);
diffusion_single d2 (rs21, rs22, rs23, rs24, rs25, rd21, rd22, rd23, rd24, rd25);

//Round 3
assign add3 = rd23 ^ 64'h00000000000000d2;
substitution_single s3 (rd21, rd22, add3, rd24, rd25, rs31, rs32, rs33, rs34, rs35);
diffusion_single d3 (rs31, rs32, rs33, rs34, rs35, rd31, rd32, rd33, rd34, rd35);

//Round 4
assign add4 = rd33 ^ 64'h00000000000000c3;
substitution_single s4 (rd31, rd32, add4, rd34, rd35, rs41, rs42, rs43, rs44, rs45);
diffusion_single d4 (rs41, rs42, rs43, rs44, rs45, rd41, rd42, rd43, rd44, rd45);

//Round 5
assign add5 = rd43 ^ 64'h00000000000000b4;
substitution_single s5 (rd41, rd42, add5, rd44, rd45, rs51, rs52, rs53, rs54, rs55);
diffusion_single d5 (rs51, rs52, rs53, rs54, rs55, rd51, rd52, rd53, rd54, rd55);

//Round 6
assign add6 = rd53 ^ 64'h00000000000000a5;
substitution_single s6 (rd51, rd52, add6, rd54, rd55, rs61, rs62, rs63, rs64, rs65);
diffusion_single d6 (rs61, rs62, rs63, rs64, rs65, rd61, rd62, rd63, rd64, rd65);

//Round 7
assign add7 = rd63 ^ 64'h0000000000000096;
substitution_single s7 (rd61, rd62, add7, rd64, rd65, rs71, rs72, rs73, rs74, rs75);
diffusion_single d7 (rs71, rs72, rs73, rs74, rs75, rd71, rd72, rd73, rd74, rd75);

//Round 8
assign add8 = rd73 ^ 64'h0000000000000087;
substitution_single s8 (rd71, rd72, add8, rd74, rd75, rs81, rs82, rs83, rs84, rs85);
diffusion_single d8 (rs81, rs82, rs83, rs84, rs85, rd81, rd82, rd83, rd84, rd85);

//Round 9
assign add9 = rd83 ^ 64'h0000000000000078;
substitution_single s9 (rd81, rd82, add9, rd84, rd85, rs91, rs92, rs93, rs94, rs95);
diffusion_single d9 (rs91, rs92, rs93, rs94, rs95, rd91, rd92, rd93, rd94, rd95);

//Round 10
assign add10 = rd93 ^ 64'h0000000000000069;
substitution_single s10 (rd91, rd92, add10, rd94, rd95, rs101, rs102, rs103, rs104, rs105);
diffusion_single d10 (rs101, rs102, rs103, rs104, rs105, rd101, rd102, rd103, rd104, rd105);

//Round 11
assign add11 = rd103 ^ 64'h000000000000005a;
substitution_single s11 (rd101, rd102, add11, rd104, rd105, rs111, rs112, rs113, rs114, rs115);
diffusion_single d11 (rs111, rs112, rs113, rs114, rs115, rd111, rd112, rd113, rd114, rd115);

//Round 12
assign add12 = rd113 ^ 64'h000000000000004b;
substitution_single s12 (rd111, rd112, add12, rd114, rd115, rs121, rs122, rs123, rs124, rs125);
diffusion_single d12 (rs121, rs122, rs123, rs124, rs125, rd121, rd122, rd123, rd124, rd125);


endmodule




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module substitution_single(is0, is1, is2, is3, is4, sub3_s0, sub3_s1, sub3_s2, sub3_s3, sub3_s4
    );
    
    input [63:0] is0, is1, is2, is3, is4;
    output [63:0] sub3_s0, sub3_s1, sub3_s2, sub3_s3, sub3_s4;
    
    //--------- Substitution_1
wire [63:0] sub1_s [0:4];

assign sub1_s[0] = is0 ^ is4;
assign sub1_s[1] = is1;
assign sub1_s[2] = is1 ^ is2;
assign sub1_s[3] = is3;
assign sub1_s[4] = is3 ^ is4;


//--------- Substitution_2
wire [63:0] Tval [0:4];
assign Tval[0] = (sub1_s[0] ^ 64'hffffffffffffffff) & sub1_s[1];
assign Tval[1] = (sub1_s[1] ^ 64'hffffffffffffffff) & sub1_s[2];
assign Tval[2] = (sub1_s[2] ^ 64'hffffffffffffffff) & sub1_s[3];
assign Tval[3] = (sub1_s[3] ^ 64'hffffffffffffffff) & sub1_s[4];
assign Tval[4] = (sub1_s[4] ^ 64'hffffffffffffffff) & sub1_s[0];

wire [63:0] sub2_s [0:4];
assign sub2_s[0] = Tval[1] ^ sub1_s[0];
assign sub2_s[1] = Tval[2] ^ sub1_s[1];
assign sub2_s[2] = Tval[3] ^ sub1_s[2];
assign sub2_s[3] = Tval[4] ^ sub1_s[3];
assign sub2_s[4] = Tval[0] ^ sub1_s[4];

//--------- Substitution_3

assign sub3_s0 = sub2_s[0] ^ sub2_s[4];
assign sub3_s1 = sub2_s[1] ^ sub2_s[0];
assign sub3_s2 = sub2_s[2] ^ 64'hFFFFFFFFFFFFFFFF;
assign sub3_s3 = sub2_s[3] ^ sub2_s[2];
assign sub3_s4 = sub2_s[4];
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////

module diffusion_single(sub3_s0, sub3_s1, sub3_s2, sub3_s3, sub3_s4, ose0, ose1, ose2, ose3, ose4

    );
    
    input [63:0] sub3_s0, sub3_s1, sub3_s2, sub3_s3, sub3_s4;
    output [63:0] ose0, ose1, ose2, ose3, ose4; 
    
    
assign ose0 = sub3_s0 ^ ( {sub3_s0[18:0],sub3_s0[63:19]} ^ {sub3_s0[27:0],sub3_s0[63:28]} );
assign ose1 = sub3_s1 ^ ( {sub3_s1[60:0],sub3_s1[63:61]} ^ {sub3_s1[38:0],sub3_s1[63:39]} );
assign ose2 = sub3_s2 ^ ( {sub3_s2[0000],sub3_s2[63:01]} ^ {sub3_s2[05:0],sub3_s2[63:06]} );
assign ose3 = sub3_s3 ^ ( {sub3_s3[09:0],sub3_s3[63:10]} ^ {sub3_s3[16:0],sub3_s3[63:17]} );
assign ose4 = sub3_s4 ^ ( {sub3_s4[06:0],sub3_s4[63:07]} ^ {sub3_s4[40:0],sub3_s4[63:41]} );
endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////



module associated(A, s11, s12, s13, s14, s15, s41, s42, s43, s44, s45
  );
  
  input [63:0] A;
  input [63:0] s11, s12, s13, s14, s15;
  output [63:0] s41, s42, s43, s44, s45;
  
  wire [63:0] s21;
  wire [63:0] s31, s32, s33, s34, s35;
  
  assign s21 = s11 ^ A;
  permutation_6 p1 (s21, s12, s13, s14, s15, s31, s32, s33, s34, s35);
  
  assign {s41, s42, s43, s44, s45} = {s31, s32, s33, s34, s35} ^ {319'h0, 1'h1};
   
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////

module permutation_6(
                                is0, is1, is2, is3, is4,
                                rd61, rd62, rd63, rd64, rd65
		                );

input [63:0] is0, is1, is2, is3, is4;

wire [63:0] add1, add2, add3, add4, add5, add6;

wire [63:0] rs11, rs12, rs13, rs14, rs15;
wire [63:0] rd11, rd12, rd13, rd14, rd15;

wire [63:0] rs21, rs22, rs23, rs24, rs25;
wire [63:0] rd21, rd22, rd23, rd24, rd25;

wire [63:0] rs31, rs32, rs33, rs34, rs35;
wire [63:0] rd31, rd32, rd33, rd34, rd35;

wire [63:0] rs41, rs42, rs43, rs44, rs45;
wire [63:0] rd41, rd42, rd43, rd44, rd45;

wire [63:0] rs51, rs52, rs53, rs54, rs55;
wire [63:0] rd51, rd52, rd53, rd54, rd55;

wire [63:0] rs61, rs62, rs63, rs64, rs65;
output [63:0] rd61, rd62, rd63, rd64, rd65;


//Round 1
assign add1 = is2 ^ 64'h0000000000000096;
substitution_single s1 (is0, is1, add1, is3, is4, rs11, rs12, rs13, rs14, rs15);
diffusion_single d1 (rs11, rs12, rs13, rs14, rs15, rd11, rd12, rd13, rd14, rd15);

//Round 2
assign add2 = rd13 ^ 64'h0000000000000087;
substitution_single s2 (rd11, rd12, add2, rd14, rd15, rs21, rs22, rs23, rs24, rs25);
diffusion_single d2 (rs21, rs22, rs23, rs24, rs25, rd21, rd22, rd23, rd24, rd25);

//Round 3
assign add3 = rd23 ^ 64'h0000000000000078;
substitution_single s3 (rd21, rd22, add3, rd24, rd25, rs31, rs32, rs33, rs34, rs35);
diffusion_single d3 (rs31, rs32, rs33, rs34, rs35, rd31, rd32, rd33, rd34, rd35);

//Round 4
assign add4 = rd33 ^ 64'h0000000000000069;
substitution_single s4 (rd31, rd32, add4, rd34, rd35, rs41, rs42, rs43, rs44, rs45);
diffusion_single d4 (rs41, rs42, rs43, rs44, rs45, rd41, rd42, rd43, rd44, rd45);

//Round 5
assign add5 = rd43 ^ 64'h000000000000005a;
substitution_single s5 (rd41, rd42, add5, rd44, rd45, rs51, rs52, rs53, rs54, rs55);
diffusion_single d5 (rs51, rs52, rs53, rs54, rs55, rd51, rd52, rd53, rd54, rd55);

//Round 6
assign add6 = rd53 ^ 64'h000000000000004b;
substitution_single s6 (rd51, rd52, add6, rd54, rd55, rs61, rs62, rs63, rs64, rs65);
diffusion_single d6 (rs61, rs62, rs63, rs64, rs65, rd61, rd62, rd63, rd64, rd65);

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module plaintext(p1, c1, s11, s12, s13, s14, s15, s21, s22, s23, s24, s25 
 );
       
   input [63:0] p1;
   input [63:0] s11, s12, s13, s14, s15;
   output [63:0] c1;
   
//   wire [63:0] s21, s22, s23, s24, s25;
 //  wire [63:0] s31, s32, s33, s34, s35;
   output [63:0] s21, s22, s23, s24, s25;
   
   assign c1 = s11 ^ p1;
   permutation_6 p61 (c1, s12, s13, s14, s15, s21, s22, s23, s24, s25);
   
  // assign c2 = s21 ^ p2;
   //permutation_6 p62 (c2, s22, s23, s24, s25, s31, s32, s33, s34, s35);
   
   //assign c3 = s31 ^ p3;
   //assign {s41, s42, s43, s44, s45} = {c3, s32, s33, s34, s35};   
    
endmodule

///////////////////////////////////////////////////////////////////////////////////////////

module finalization (SK, s11, s12, s13, s14, s15, T);
    
    input [127:0] SK;
    input [63:0] s11, s12, s13, s14, s15;
    output [127:0] T;
    
    wire [63:0] s21, s22, s23, s24, s25;
    wire [63:0] s31, s32, s33, s34, s35;
    
    assign {s21, s22, s23, s24, s25} = {s11, s12, s13, s14, s15} ^ {64'h0, SK, 128'h0};
    
    permutation_12 p1 (s21, s22, s23, s24, s25, s31, s32, s33, s34, s35);
    
    assign T = {s34, s35} ^ SK;    
    
endmodule