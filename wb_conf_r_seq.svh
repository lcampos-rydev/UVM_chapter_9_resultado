

class wb_conf_r_seq extends wb_base_seq;

  `uvm_object_utils(wb_conf_r_seq)

  function new(string name = "wb_conf_r_seq");
   super.new(name);
  endfunction

task body;
  super.body();
  $display("WRITE");
  // write configuration
  rm.OE.write(status, 32'hffffffff, .parent(this));
  rm.INTE.write(status, 32'h0, .parent(this));

  
  $display("READ");
  // read configuration
  rm.OE.read(status, data, .parent(this));
  rm.INTE.read(status, data, .parent(this));
  `uvm_info("Config_seq","Termina la configuracion de ALL OUTPUTS",UVM_LOW)
  
endtask

endclass: wb_conf_r_seq