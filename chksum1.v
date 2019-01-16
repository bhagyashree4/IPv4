`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2019 06:57:26 PM
// Design Name: 
// Module Name: chksum1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module chksum1(chksum,clk,ih1,ih2,ih3,ih4,ih5,ih6);

input [31:0] ih1,ih2,ih3,ih4,ih5,ih6;
input clk;
output reg [15:0] chksum;

reg [31:0] chksum32;
wire [15:0] m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10;

assign mo = ih1[31:16];
assign m1 = ih1[15:0];
assign m2 = ih2[31:16];
assign m3 = ih2[15:0];
assign m4 = ih3[31:16];
assign m5 = ih4[31:16];
assign m6 = ih4[15:0];
assign m7 = ih5[31:16];
assign m8 = ih5[15:0];
assign m9 = ih6[31:16];
assign m10 = ih6[15:0];

parameter s0=0;
parameter s1=1;
parameter s2=2;
parameter s3=3;
parameter s4=4;
parameter s5=5;
parameter s6=6;

reg state;

always @(posedge clk)

case(state)

s0: begin 
      chksum32 = m0+m1;
      if(chksum32 & 32'hffff0000)
      chksum32 = chksum32 + 1;
      else
      chksum32 = chksum32;
    state = s1;
    end

s1: begin 
          chksum32 = chksum32+m2+m3;
          if(chksum32 & 32'hffff0000)
          chksum32 = chksum32 + 1;
          else
          chksum32 = chksum32;
        state = s2;
        end
        
s2: begin 
              chksum32 = chksum32+m4;
              if(chksum32 & 32'hffff0000)
              chksum32 = chksum32 + 1;
              else
              chksum32 = chksum32;
            state = s3;
            end
            
s3: begin 
                  chksum32 = chksum32+m5+m6;
                  if(chksum32 & 32'hffff0000)
                  chksum32 = chksum32 + 1;
                  else
                  chksum32 = chksum32;
                state = s4;
                end            
       
        
s4: begin 
                      chksum32 = chksum32+m7+m8;
                      if(chksum32 & 32'hffff0000)
                      chksum32 = chksum32 + 1;
                      else
                      chksum32 = chksum32;
                    state = s5;
                    end        
s5: begin 

                          chksum32 = chksum32+m9+m10;
                          if(chksum32 & 32'hffff0000)
                          chksum32 = chksum32 + 1;
                          else
                          chksum32 = chksum32;
                        state = s6;
                        end
s6: begin 
                              chksum = chksum32;
                              chksum = ~chksum;
                            end                                
        
default: state = s0;
endcase
endmodule
