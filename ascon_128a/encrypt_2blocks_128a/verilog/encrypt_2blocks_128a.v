`timescale 1ns / 1ps
//!
//! **PROJECT:**             Lightweight Ascon
//!
//! **LANGUAGE:**            Verilog
//!
//! **FILE:**                encrypt_2blocks_128a
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
module encrypt_2blocks_128a(SK, N, A, P, clk, reset, C, T
    );
	 
    input [127:0] SK, N;
    input [127:0] A;
    input [127:0] P;
	 input  clk, reset;
	 
    output reg [127:0] C;
    output reg [127:0] T;
	 
	 wire [63:0] IV;
	 wire [63:0] s11, s12, s13, s14, s15;
	 reg [63:0] s21, s22, s23, s24, s25;
	 reg [63:0] s31, s32, s33, s34, s35;
	 reg [63:0] s41, s42, s43, s44, s45;

	 reg  [63:0] i0, i1, i2, i3, i4;
	 reg  [7:0] a;
	 wire [63:0] o0, o1, o2, o3, o4;
	 wire [63:0] s0, s1, s2, s3, s4;
	 reg  [4:0] count;
	 reg [63:0] t21, t22;
	 
	 reg [63:0] r10, r11, r12, r13, r14;

	assign IV = 64'h80800c0800000000;
	assign {s11, s12, s13, s14, s15} = {IV, SK, N};
	
	permutation_2 p1 (i0, i1, i2, i3, i4, a,
           o0, o1, o2, o3, o4);
			  
			  assign s0 = o0;
			  assign s1 = o1;
			  assign s2 = o2;
			  assign s3 = o3;
			  assign s4 = o4;
			  
			  
			  always @(posedge clk)
begin
if (reset)
begin
count <= 0;
i0<=64'd0;
i1<=64'd0;
i2<=64'd0;
i3<=64'd0;
i4<=64'd0;
a <= 8'hff;
end

else begin

                if (count== 1)
                begin
                i0 <= s11;
                i1 <= s12;
                i2 <= s13;
                i3 <= s14;
                i4 <= s15;
                a <= 8'hff;
                end
                if (count == 2)
                begin
                i0 <= s0;
                i1 <= s1;
                i2 <= s2;
                i3 <= s3;
                i4 <= s4;
                a <= 8'he1;
                end
                if (count == 3)
                begin
                i0<=s0;
                i1<=s1;
                i2<=s2;
                i3<=s3;
                i4<=s4;
                a <= 8'hc3;
                end
                if (count == 4)
                begin
                i0 <= s0;
                i1 <= s1;
                i2 <= s2;
                i3 <= s3;
                i4 <= s4;
                a <= 8'ha5;
                end
                if (count == 5)
                begin
                i0<=s0;
                i1<=s1;
                i2<=s2;
                i3<=s3;
                i4<=s4;
                a <= 8'h87;
                end
                if (count == 6)
                begin
                i0 <= s0;
                i1 <= s1;
                i2 <= s2;
                i3 <= s3;
                i4 <= s4;
                a <= 8'h69;
                end
					 
					 if (count == 7)

begin
{s21, s22, s23, s24, s25} <= {s0, s1, s2, s3, s4} ^ {192'b00, SK};
end

if (count == 8)
begin
t21 = s21 ^ A[63:0];
t22 = s22 ^ A[127:64];
end
                        if (count == 9)
                        begin
                        i0<=t21;
                        i1<=t22;
                        i2<=s23;
                        i3<=s24;
                        i4<=s25;
                        a <= 8'hc3;
                        end
                        if (count == 10)
                        begin
                        i0 <= s0;
                        i1 <= s1;
                        i2 <= s2;
                        i3 <= s3;
                        i4 <= s4;
                        a <= 8'ha5;
                        end
                        if (count == 11)
                        begin
                        i0 <= s0;
                        i1 <= s1;
                        i2 <= s2;
                        i3 <= s3;
                        i4 <= s4;
                        a <= 8'h87;
                        end
								if (count == 12)
                        begin
                        i0 <= s0;
                        i1 <= s1;
                        i2 <= s2;
                        i3 <= s3;
                        i4 <= s4;
                        a <= 8'h69;
                        end

if (count == 13)
begin
{s31, s32, s33, s34, s35} <= {s0, s1, s2, s3, s4} ^ {319'h0, 1'h1};
end

if (count == 14)
begin
C = {s31, s32} ^ P;
end

                                    if (count == 15)
                                    begin
                                    i0<=C[63:0];
                                    i1<=C[127:64];
                                    i2<=s33;
                                    i3<=s34;
                                    i4<=s35;
                                    a <= 8'hc3;
                                    end
                                    if (count == 16)
                                    begin
                                    i0 <= s0;
                                    i1 <= s1;
                                    i2 <= s2;
                                    i3 <= s3;
                                    i4 <= s4;
                                    a <= 8'ha5;
                                    end
                                    if (count == 17)
                                    begin
                                    i0 <= s0;
                                    i1 <= s1;
                                    i2 <= s2;
                                    i3 <= s3;
                                    i4 <= s4;
                                    a <= 8'h87;
                                    end
												if (count == 18)
                                    begin
                                    i0 <= s0;
                                    i1 <= s1;
                                    i2 <= s2;
                                    i3 <= s3;
                                    i4 <= s4;
                                    a <= 8'h69;
                                    end

if (count == 19)
begin
{s41, s42, s43, s44, s45} <= {s0, s1, s2, s3, s4} ^ {128'h0, SK, 164'h0};
end

                            if (count == 20)
                            begin
                            i0<=s41;
                            i1<=s42;
                            i2<=s43;
                            i3<=s44;
                            i4<=s45;
                            a <= 8'hff;
                            end
                            if (count == 21)
                            begin
                            i0 <= s0;
                            i1 <= s1;
                            i2 <= s2;
                            i3 <= s3;
                            i4 <= s4;
                            a <= 8'he1;
                            end
                            if (count == 22)
                            begin
                            i0<=s0;
                            i1<=s1;
                            i2<=s2;
                            i3<=s3;
                            i4<=s4;
                            a <= 8'hc3;
                            end
                            if (count == 23)
                            begin
                            i0 <= s0;
                            i1 <= s1;
                            i2 <= s2;
                            i3 <= s3;
                            i4 <= s4;
                            a <= 8'ha5;
                            end
                            if (count == 24)
                            begin
                            i0 <= s0;
                            i1 <= s1;
                            i2 <= s2;
                            i3 <= s3;
                            i4 <= s4;
                            a <= 8'h87;
                            end
                            if (count == 25)
                            begin
                            i0 <= s0;
                            i1 <= s1;
                            i2 <= s2;
                            i3 <= s3;
                            i4 <= s4;
                            a <= 8'h69;
                            end


if (count == 26)
begin
T <= {s3, s4} ^ SK;
count <= 0;
end

else 

count <= count+1;

end
end
endmodule

///////////////////////////////////////////////////////////////////

module permutation_2(
           is0, is1, is2, is3, is4, aa,
           rd21, rd22, rd23, rd24, rd25
		   );
		   

input [63:0] is0, is1, is2, is3, is4;
input [7:0] aa;

wire [63:0] add1, add2;

wire [63:0] rs11, rs12, rs13, rs14, rs15;
wire [63:0] rd11, rd12, rd13, rd14, rd15;

wire [63:0] rs21, rs22, rs23, rs24, rs25;
output [63:0] rd21, rd22, rd23, rd24, rd25;

//Round 1

assign add1 = is2 ^ (aa-8'h0f);
substitution_single ss1 (is0, is1, add1, is3, is4, rs11, rs12, rs13, rs14, rs15);
diffusion_single d1 (rs11, rs12, rs13, rs14, rs15, rd11, rd12, rd13, rd14, rd15);

//Round 2

assign add2 = rd13 ^ (aa-8'h1e);
substitution_single ss2 (rd11, rd12, add2, rd14, rd15, rs21, rs22, rs23, rs24, rs25);
diffusion_single d2 (rs21, rs22, rs23, rs24, rs25, rd21, rd22, rd23, rd24, rd25);

endmodule

/////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////

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
