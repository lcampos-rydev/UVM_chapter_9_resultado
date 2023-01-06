


class wb_base_seq #(ADR_W = 8, DAT_W = 32, TAG_W = 1) extends uvm_sequence #(wishbone_b3_sequence_item #(ADR_W, DAT_W, TAG_W),gpio_seq_item #(ADR_W, DAT_W, TAG_W));
  `uvm_object_utils(wb_base_seq#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))

  // To get the register model
  gpio_env_config cfg;
  gpio_reg_block rm;

  // Register model variables:
  uvm_status_e status;
  bit [31:0] data;

  function new(string name = "wb_base_seq");
    super.new(name);
  endfunction

  task body;

    //if(!uvm_config_db #(gpio_env_config)::get(seqr, "", "gpio_env_config", cfg)) begin
      //`uvm_error("body", "Unable to find uart_env_config in uvm_config_db")
    //end
    //rm = cfg.rm;
  endtask: body

endclass