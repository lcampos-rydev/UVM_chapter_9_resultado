package gpio_reg_pkg;
  

 import uvm_pkg::*;
`include "uvm_macros.svh"


//RGPIO_IN register
class rgpio_in extends uvm_reg;
  `uvm_object_utils(rgpio_in)

  rand uvm_reg_field data;

  function new(string name = "rgpio_in");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RO", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_in



//RGPIO_OUT register
class rgpio_out extends uvm_reg;
  `uvm_object_utils(rgpio_out)

  rand uvm_reg_field data;

  function new(string name = "rgpio_out");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_out



//RGPIO_OE register
class rgpio_oe extends uvm_reg;
  `uvm_object_utils(rgpio_oe)

  rand uvm_reg_field data;

  function new(string name = "rgpio_oe");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_oe


//RGPIO_INTE register
class rgpio_inte extends uvm_reg;
  `uvm_object_utils(rgpio_inte)

  rand uvm_reg_field data;

  function new(string name = "rgpio_inte");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_inte


//RGPIO_PTRIG register
class rgpio_ptrig extends uvm_reg;
  `uvm_object_utils(rgpio_ptrig)

  rand uvm_reg_field data;

  function new(string name = "rgpio_ptrig");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_ptrig

//RGPIO_AUX register
class rgpio_aux extends uvm_reg;
  `uvm_object_utils(rgpio_aux)

  rand uvm_reg_field data;

  function new(string name = "rgpio_aux");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_aux


//RGPIO_CTRL register
class rgpio_ctrl extends uvm_reg;
  `uvm_object_utils(rgpio_ctrl)

  rand uvm_reg_field INTE;
  rand uvm_reg_field INTS;

  function new(string name = "rgpio_ctrl");
    super.new(name, 2, UVM_NO_COVERAGE);
  endfunction

  function void build();
    INTE = uvm_reg_field::type_id::create("INTE");
    INTE.configure(this, 1, 0, "RW", 0, 8'h0, 0, 1, 0);
    
    
    INTS = uvm_reg_field::type_id::create("INTS");
    INTS.configure(this, 1, 1, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_ctrl

//RGPIO_INTS register
class rgpio_ints extends uvm_reg;
  `uvm_object_utils(rgpio_ints)

  rand uvm_reg_field data;

  function new(string name = "rgpio_ints");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_ints


//RGPIO_ECLK register
class rgpio_eclk extends uvm_reg;
  `uvm_object_utils(rgpio_eclk)

  rand uvm_reg_field data;

  function new(string name = "rgpio_eclk");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_eclk



//RGPIO_NEC register
class rgpio_nec extends uvm_reg;
  `uvm_object_utils(rgpio_nec)

  rand uvm_reg_field data;

  function new(string name = "rgpio_nec");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 32, 0, "RW", 0, 8'h0, 0, 1, 0);
  endfunction: build
endclass: rgpio_nec


class gpio_reg_block extends uvm_reg_block;
  
  `uvm_object_utils(gpio_reg_block)
    
  rgpio_in IN;
  rand rgpio_out OUT;
  rand rgpio_oe OE;
  rand rgpio_inte INTE;
  rand rgpio_ptrig PTRIG;
  rand rgpio_aux AUX;
  rand rgpio_ctrl CTRL;
  rand rgpio_ints INTS;
  rand rgpio_eclk ECLK;
  rand rgpio_nec NEC;
  
  
  uvm_reg_map map;
  
  function new(string name = "gpio_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    IN = rgpio_in::type_id::create("IN");
    IN.build();
    IN.configure(this);
    
    OUT = rgpio_out::type_id::create("OUT");
    OUT.build();
    OUT.configure(this);
    
    OE = rgpio_oe::type_id::create("OE");
    OE.build();
    OE.configure(this);
    
    PTRIG = rgpio_ptrig::type_id::create("PTRIG");
    PTRIG.build();
    PTRIG.configure(this);
    
    INTE = rgpio_inte::type_id::create("INTE");
    INTE.build();
    INTE.configure(this);
    
    AUX = rgpio_aux::type_id::create("AUX");
    AUX.build();
    AUX.configure(this);
    
    CTRL = rgpio_ctrl::type_id::create("CTRL");
    CTRL.build();
    CTRL.configure(this);
    
    INTS = rgpio_ints::type_id::create("INTS");
    INTS.build();
    INTS.configure(this);
    
    ECLK = rgpio_eclk::type_id::create("ECLK");
    ECLK.build();
    ECLK.configure(this);
    
    NEC = rgpio_nec::type_id::create("NEC");
    NEC.build();
    NEC.configure(this);
    
    
    
    map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN);
    
    map.add_reg(IN, 8'h00, "RO");
    map.add_reg(OUT, 8'h04, "RW");
    map.add_reg(OE, 8'h08, "RW");
    map.add_reg(INTE, 8'h0c, "RW");
    map.add_reg(PTRIG, 8'h10, "RW");
    map.add_reg(AUX, 8'h14, "RW");
    map.add_reg(CTRL, 8'h18, "RW");
    map.add_reg(INTS, 8'h1c, "RW");
    map.add_reg(ECLK, 8'h20, "RW");
    map.add_reg(NEC, 8'h24, "RW");
    lock_model();
    
  endfunction
  
  
  
endclass: gpio_reg_block


endpackage: gpio_reg_pkg