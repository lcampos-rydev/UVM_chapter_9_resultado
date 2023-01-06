class wb_test_input extends wb_test_base;
  
  `uvm_component_utils(wb_test_input)

  function new(string name = "wb_test_input", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  
  virtual task run_phase(uvm_phase phase);
    wb_conf_w_seq seq= wb_conf_w_seq::type_id::create("seq");
     
     seq.rm=rm;
    
     phase.raise_objection(this);
		
      seq.start(m_env.wb_agent.seqr);
	
	 phase.drop_objection(this);
	endtask
endclass