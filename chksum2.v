`timescale 1us / 1ns
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


module chksum2(chksum,chksum32,clk,reset,ih1,ih2,ih3,ih4,ih5,ih6,m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10);

input [31:0] ih1,ih2,ih3,ih4,ih5,ih6;
input clk;
input  reset;
output reg [15:0] chksum;
output reg[15:0]m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10;
output reg [31:0] chksum32=0;

always @(posedge clk  )
if (reset)
begin
m0[15:0] = 16'b0;
 m1[15:0] = 16'b0;
m2[15:0] = 16'b0;

 m3[15:0] = 16'b0;

 m4[15:0] = 16'b0;

m5[15:0] = 16'b0;

m6[15:0] = 16'b0;

 m7[15:0] = 16'b0;

m8[15:0] = 16'b0;

m9[15:0] = 16'b0;

 m10[15:0]  = 16'b0;
end
else

begin

m0[15:0] <= ih1[31:16];
 m1[15:0] <= ih1[15:0];
m2[15:0] <= ih2[31:16];

 m3[15:0]<= ih2[15:0];

 m4[15:0] <= ih3[31:16];

m5[15:0] <= ih4[31:16];

m6[15:0] <= ih4[15:0];

 m7[15:0] <= ih5[31:16];

m8[15:0] <= ih5[15:0];

m9[15:0] <= ih6[31:16];

 m10[15:0] <= ih6[15:0];

end
parameter s0=0;
parameter s1=1;
parameter s2=2;
parameter s3=3;
parameter s4=4;
parameter s5=5;
parameter s6=6;

reg [2:0] state;


always @(posedge clk)
if (reset)
chksum=0;

else
begin

case(state)

s0: begin 
      chksum32 = m0+m1;
      if(chksum32 & 32'hffff0000)
      begin
      chksum32 = chksum32 + 1;
      chksum=chksum32;
      end
      else
      chksum32 = chksum32;
    state = s1;
    end

s1: begin 
          chksum32 = chksum32+m2+m3;
          if(chksum32 & 32'hffff0000)
                begin
                chksum32 = chksum32 + 1;
                chksum=chksum32;
                end
          
          else
          chksum32 = chksum32;
        state = s2;
        end 
        
s2: begin 
              chksum32 = chksum32+m4;
              if(chksum32 & 32'hffff0000)
                    begin
                    chksum32 = chksum32 + 1;
                    chksum=chksum32;
                    end
              else
              chksum32 = chksum32;
            state = s3;
            end
            
s3: begin 
                  chksum32 = chksum32+m5+m6;
                  if(chksum32 & 32'hffff0000)
                        begin
                        chksum32 = chksum32 + 1;
                        chksum=chksum32;
                        end
                  else
                  chksum32 = chksum32;
                state = s4;
                end            
       
        
s4: begin 
                      chksum32 = chksum32+m7+m8;
                      if(chksum32 & 32'hffff0000)
                            begin
                            chksum32 = chksum32 + 1;
                            chksum=chksum32;
                            end
                      else
                      chksum32 = chksum32;
                    state = s5;
                    end        
s5: begin 

                          chksum32 = chksum32+m9+m10;
                         if(chksum32 & 32'hffff0000)
                                begin
                                chksum32 = chksum32 + 1;
                                chksum=chksum32;
                                end
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
end
endmodule
