class gpio_wr_vseq extends gpio_base_vseq;

`uvm_object_utils(gpio_wr_vseq)

function new(string name = "gpio_wr_vseq");
  super.new(name);
endfunction

task body;
  wb_conf_r_seq conf_output_seq = wb_conf_r_seq::type_id::create("conf_output_seq");
  wb_write_input_seq write_number = wb_write_input_seq::type_id::create("write_number");
  
  conf_output_seq.rm=rm;
  write_number.rm=rm;
  
  
  conf_output_seq.start(seqr);
  write_number.start(gpio_sequencer);
  
endtask: body

endclass: gpio_wr_vseq