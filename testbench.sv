
`include "wishbone_b3_package.sv"
`include "gpio_agent_pkg.svh"
`include "gpio_test_pkg.svh"
module gpio_tb;
  import uvm_pkg::*;
  
  
  
  parameter ADR_W = 8;
  parameter DAT_W = 32;
  parameter TAG_W = 1;
  
  bit clk=0;
  always #20 clk = ~clk;
  
  wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) vif (.clk(clk));
  
  gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) gpio_vif (.clk(clk));
 
  gpio_top dut (
                 .wb_clk_i(clk), 
                 .wb_rst_i(vif.rst_i), 
                 .wb_cyc_i(vif.cyc), 
                 .wb_adr_i(vif.adr), 
                 .wb_dat_o(vif.dat_i), 
                 .wb_sel_i(vif.sel), 
                 .wb_we_i(vif.we), 
                 .wb_stb_i(vif.stb),
                 .wb_dat_i(vif.dat_o), 
                 .wb_ack_o(vif.ack), 
                 .wb_err_o(vif.err) ,
                 .clk_pad_i(clk), 
                 
                 .ext_pad_i(gpio_vif.in_pad_i), 
                 .ext_pad_o(gpio_vif.out_pad_o), 
                 .ext_padoe_o(gpio_vif.oen_padoen_o));

  
  
  
  initial begin
    uvm_config_db #(virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::set (null, "uvm_test_top","td_wishbone_b3_if", vif); 
    uvm_config_db #(virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::set (null, "uvm_test_top","gpio_if", gpio_vif); 
  
	  vif.dat_o=0;
      vif.adr=0;
      vif.cyc=0;
      vif.sel=0;
      vif.stb=0;
      vif.we=0;
	  run_test(); 
  end
  
  initial begin
  $dumpfile("dump.vcd");
    $dumpvars();
  #10000 
  $finish;
  end

endmodule