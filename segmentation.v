 `timescale 1ns / 1ps



module segmentation(valid,invalid,clk,reset,ih1,ih2,ih3,ih4,ih5,ih6,version,ihl,type_of_svc,total_length,packet_identification,flags,fragment_offset,time_to_live,protocol ,header_chksum,source_ip_address,destination_ip_address,data);
input[31:0]ih1,ih2,ih3,ih4,ih5;

parameter N=31;
input [N:0]ih6;
input clk;
input reset;
output reg [N:0] data;
output reg [3:0] version,ihl;
output reg [2:0] flags;
output reg [12:0]fragment_offset;
output reg [15:0]total_length,packet_identification,header_chksum;

output reg [7:0]type_of_svc,time_to_live,protocol;
output reg valid,invalid;

output reg [31:0]source_ip_address,destination_ip_address;

always @(posedge clk  )
if (reset)
begin
 version[3:0] = 4'b0;
 ihl[3:0] = 4'b0;
  data[N:0]=0;
 flags[2:0] = 3'b0;
 
 type_of_svc[7:0] = 8'b0;
 time_to_live[7:0] = 8'b0;
 protocol[7:0] = 8'b0;
 fragment_offset[12:0] = 13'b0;
 total_length[15:0]=16'b0;
 packet_identification[15:0]=16'b0;
 header_chksum[15:0]=16'b0;
 valid=1'b0;
 invalid=1'b0;
 source_ip_address[31:0]=31'b0;
 destination_ip_address[31:0]=31'b0;
 
end
else

begin

version[3:0]     <= ih1[31:28];
ihl[3:0]         <= ih1[27:24];
type_of_svc[7:0] <=ih1[23:16];
total_length[7:0]<=ih1[15:0];
packet_identification[15:0]<=ih2[31:16];
flags[2:0]<=ih2[15:13];
fragment_offset[12:0] <=ih2[12:0];
time_to_live[7:0] <=ih3[31:24];
protocol[7:0] <=ih3[23:16]; 
header_chksum[15:0]<=ih3[15:0];
source_ip_address[31:0]<=ih4[31:0];
destination_ip_address[31:0]<=ih5[31:0];
data[N:0]<=ih6[N:0];





end

parameter s0=0;
parameter s1=1;
parameter s2=2;
parameter s3=3;
parameter s4=4;
parameter s5=5;
parameter s6=6;
parameter s7=7;
parameter s8=8;
parameter s9=9;
parameter s10=10;
parameter s11=11;
parameter s12=12;
parameter s13=13;



reg [4:0] state;

always @(posedge clk)
if (reset)
valid=0;

else
begin

case(state)

s0: begin 
      
      if(version === 4'b0100)
      begin
      state = s1;
       end
      else
        state = s13;
    
    end
s1: begin 
          
      if(ihl === 4'b0101)
      begin
      state = s2;
      end
      else
      state = s13;
        
       end


s2: begin 
                 
       if(type_of_svc === 8'b00000001)
       begin
       state = s3;
       end
       else
       state = s13;
       end

s3: begin 
                                      
          if(total_length === 16'b0000000000011000)
           begin
           state = s4;
           end
           else
           state = s13;
           end
s4: begin 
                                   
         if(packet_identification === 16'b0000000000000000)
            begin
            state = s5;
            end
            else
            state = s13; 
            end
s5: begin 
                                                            
    if(flags === 3'b010)
       begin
       state = s6;
       end
       else
      state = s13;
      end
s6: begin 
                                                                  
    if(fragment_offset === 13'b0000000000000)
     begin
     state = s7;
     end
     else
     state = s13;
      end         
s7: begin 
                                                                        
     if(time_to_live ===  8'b01111011)
     begin
     state = s8;
     end
     else
     state = s13;
     end         
s8: begin 
                                                                             
    if(protocol === 8'b00000110)
    begin
    state = s9;
    end
    else
    state = s13;
    end
s9: begin 
                                                                                 
        if(header_chksum === 16'b1111110011101101)
        begin
        state = s10;
        end
        else
        state = s13;
        end         
s10: begin 
                                                                                         
    if(source_ip_address === 32'b11000000000000000000000000000001)
     begin
     state = s11;
     end
     else
     state = s13;
     end         
s11: begin 
                                                                                              
         if(destination_ip_address === 32'b11000100000000000000000000000001)
          begin
          state = s12;
          end
          else
          state = s13;
          end         
s12: begin 
                                                                                                        
          if(data === 32'b11000100000000000000000000000111)
          begin
          valid=1;
          end
          else
          state = s13;
          end         
s13: begin 
          invalid=1;
                   
     end   
default:state=s0;               
    
           endcase

       end
endmodule
