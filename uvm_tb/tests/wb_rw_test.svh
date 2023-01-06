class wb_rw_test extends wb_test_base;
  
  `uvm_component_utils(wb_rw_test)

  function new(string name = "wb_rw_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  
  virtual task run_phase(uvm_phase phase);
    gpio_rw_vseq vseq= gpio_rw_vseq::type_id::create("vseq");
     
    init_vseq(vseq);
    
     phase.raise_objection(this);
		
    vseq.start(null);
	
	 phase.drop_objection(this);
	endtask
endclass