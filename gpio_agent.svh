class gpio_agent#(ADR_W = 32, DAT_W = 64, TAG_W = 1) extends uvm_agent; 

  `uvm_component_utils(gpio_agent#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))) 

	function new(string name="agent", uvm_component parent=null); 
	   super.new(name, parent);
	endfunction
        
        	
    gpio_driver#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) gpio_d0; 
    gpio_monitor#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) gpio_m0; 
    uvm_sequencer #(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))) gpio_sequencer;
    
    virtual wishbone_b3_if #(.DAT_W(DAT_W), .ADR_W(ADR_W), .TAG_W(TAG_W))  sigs;
    virtual gpio_if #(.DAT_W(DAT_W), .ADR_W(ADR_W), .TAG_W(TAG_W)) vif;

	virtual function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
       
       if(!uvm_config_db#(virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "td_wishbone_b3_if",sigs))
         `uvm_fatal("Gpio_agent", "No se obtuvo vif") 
       
       if(!uvm_config_db#(virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "gpio_if",vif))
         `uvm_fatal("Gpio_agent", "No se obtuvo gpio_vif")
         
	   gpio_sequencer=uvm_sequencer #(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::type_id::create("s0", this); 
	   gpio_d0=gpio_driver#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("d0", this);
       gpio_d0.vif=vif;
       gpio_d0.sigs=sigs;
	   gpio_m0=gpio_monitor#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("m0", this);
       gpio_m0.vif=vif;
       gpio_m0.sigs=sigs;
      
       
	endfunction

	virtual function void connect_phase(uvm_phase phase); 
	  super.connect_phase(phase); 
	  gpio_d0.seq_item_port.connect(gpio_sequencer.seq_item_export); 
	endfunction

endclass