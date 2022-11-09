`timescale 1ns/1ps
module UART_TX_TOP_tb();
 /* DUT Signals */
 reg       CLK_tb,RST_tb;
 reg [7:0] P_DATA_tb;
 reg       DATA_VALID_tb;
 reg       PAR_EN_tb,PAR_TYP_tb;
 wire      TX_OUT_tb, BUSY_tb;
 
 /* Internal Signals */
 reg [10:0] FRAME_PAR  ;
 reg [9:0]  FRAME_NPAR ;
 
 localparam CLK_Period = 5.0 ;  // f = 200 MHz
 localparam even = 0;
 localparam odd  = 1;
 integer i;
 
 /* Initial Block */
 initial
  begin
   $dumpfile("UART_TX_TOP.vcd");     
   $dumpvars;       
   
   initialize();
   
   reset();
   
   $display("TEST DATA WITH EVEN PARITY");
   data_even_parity(8'b1010_1001, 1); 
   wait(!BUSY_tb)
   if(FRAME_PAR==11'b0_1001_0101_1_1)   
    $display("DATA WITH EVEN PARITY PASSED");
   else
    $display("DATA WITH EVEN PARITY FAILED");
	
   $display("TEST DATA WITH ODD PARITY");
   data_odd_parity(8'b1010_1011, 1); 
   wait(!BUSY_tb)
   if(FRAME_PAR==11'b0_1101_0101_1_1)   
    $display("DATA WITH ODD PARITY PASSED");
   else
    $display("DATA WITH ODD PARITY FAILED");
   
   $display("TEST DATA WITH NO PARITY");
   data_no_parity(8'b1110_1001, 1); 
   wait(!BUSY_tb)
   if(FRAME_NPAR==10'b0_1001_0111_1)   
    $display("DATA WITH NO PARITY PASSED");
   else
    $display("DATA WITH NO PARITY FAILED");
   
   #10 $finish;
  end
  
  
 /* Tasks */
 task initialize;
  begin
   RST_tb = 1 ;
   CLK_tb = 0 ;
   P_DATA_tb = 0 ;
   DATA_VALID_tb = 0 ;
   PAR_EN_tb = 0 ;
   PAR_TYP_tb = 0 ;
   FRAME_PAR = 0;
   FRAME_NPAR = 0;
  end
 endtask
 
 task reset;
  begin
   #CLK_Period
   RST_tb = 0 ;
   #CLK_Period
   RST_tb = 1 ;
   #CLK_Period ;
  end
 endtask
 
 task data_even_parity;
  input [7:0] p_data;
  input       data_valid;
  begin
   P_DATA_tb = p_data ;
   DATA_VALID_tb = data_valid;
   PAR_EN_tb = 1;
   PAR_TYP_tb = even;
   #(2*CLK_Period)
   for (i=10 ; i>-1 ; i=i-1)
    begin
	 #CLK_Period
     FRAME_PAR[i] = TX_OUT_tb ;
    end
  end
 endtask
 
 task data_odd_parity;
  input [7:0] p_data;
  input       data_valid;
  begin
   P_DATA_tb = p_data ;
   DATA_VALID_tb = data_valid;
   PAR_EN_tb = 1;
   PAR_TYP_tb = odd;
   #(2*CLK_Period)
   for (i=10 ; i>-1 ; i=i-1)
    begin
	 #CLK_Period
     FRAME_PAR[i] = TX_OUT_tb ;
    end
  end
 endtask
 
 task data_no_parity;
  input [7:0] p_data;
  input       data_valid;
  begin
   P_DATA_tb = p_data ;
   DATA_VALID_tb = data_valid;
   PAR_EN_tb = 0;
   #(2*CLK_Period)
   for (i=9 ; i>-1 ; i=i-1)
    begin
	 #CLK_Period
     FRAME_NPAR[i] = TX_OUT_tb ;
    end
  end  
 endtask
 
 always #(CLK_Period/2) CLK_tb = ~ CLK_tb ; 
 
 UART_TX_TOP DUT (
 .P_DATA(P_DATA_tb),
 .DATA_VALID(DATA_VALID_tb),
 .PAR_EN(PAR_EN_tb),
 .PAR_TYP(PAR_TYP_tb),
 .CLK(CLK_tb),
 .RST(RST_tb),
 .TX_OUT(TX_OUT_tb), 
 .BUSY(BUSY_tb)
 );
  
endmodule
