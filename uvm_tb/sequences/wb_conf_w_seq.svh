

class wb_conf_w_seq extends wb_base_seq;

`uvm_object_utils(wb_conf_w_seq)

function new(string name = "wb_conf_w_seq");
  super.new(name);
endfunction

task body;
  super.body();
  $display("WRITE");
  // write configuration
  rm.OE.write(status, 32'h0, .parent(this));
  rm.CTRL.write(status, 2'h0, .parent(this));
  rm.INTE.write(status, 32'h0, .parent(this));
  rm.ECLK.write(status, 32'h0, .parent(this));
  rm.NEC.write(status, 32'h0, .parent(this));
  
  $display("READ");
  // read configuration
  rm.OE.read(status, data, .parent(this));
  rm.CTRL.read(status, data, .parent(this));
  rm.INTE.read(status, data, .parent(this));
  rm.ECLK.read(status, data, .parent(this));
  rm.NEC.read(status, data, .parent(this));
  `uvm_info("Config_seq","Termina la configuracion de ALL INPUTS",UVM_LOW)
endtask

endclass: wb_conf_w_seq