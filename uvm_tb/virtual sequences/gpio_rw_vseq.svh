class gpio_rw_vseq extends gpio_base_vseq;

  `uvm_object_utils(gpio_rw_vseq)

  function new(string name = "gpio_rw_vseq");
    super.new(name);
  endfunction

task body;
  wb_conf_w_seq conf_input_seq = wb_conf_w_seq::type_id::create("conf_input_seq");
  wb_read_input_seq read_number = wb_read_input_seq::type_id::create("read_number");
  
  conf_input_seq.rm=rm;
  read_number.rm=rm;
  
  
  conf_input_seq.start(seqr);
  read_number.start(gpio_sequencer);
  
endtask: body

endclass: gpio_rw_vseq