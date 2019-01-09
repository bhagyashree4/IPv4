`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/03/2019 02:24:02 PM
// Design Name: 
// Module Name: dff
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


module dff(q, qbar,d,set,reset,clk);
     input d,set,reset,clk;
        output q,qbar;
    reg q;
    assign qbar=~q;
    always@ (posedge clk)
    begin
    if(reset==0)
    q<=0;
    else if (set==0)
    q<=1;
    else q<=d;
    end 
    endmodule
