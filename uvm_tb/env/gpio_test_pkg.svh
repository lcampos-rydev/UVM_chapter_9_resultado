`include "gpio_if.sv"
`include "wishbone_b3_if.sv"
`include "gpio_reg_pkg.sv"

package gpio_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
 
  
  import gpio_reg_pkg::*;
  import wishbone_b3_package::*;
  import gpio_agent_pkg::*;
  `include "gpio_env_config.svh"
  `include "scoreboard.svh"
  `include "gpio_env.svh"
  `include "wb_base_seq.svh"
  `include "wb_conf_w_seq.svh"
  `include "wb_conf_r_seq.svh"
  `include "wb_write_input_seq.svh"
  `include "wb_read_input_seq.svh"
  `include "gpio_base_vseq.svh"
  `include "gpio_wr_vseq.svh"
  `include "gpio_rw_vseq.svh"
  `include "wb_test_base.svh"
  `include "wb_test_input.svh"
  `include "wb_test_output.svh"
  `include "wb_wr_test.svh"
  `include "wb_rw_test.svh"
  

endpackage