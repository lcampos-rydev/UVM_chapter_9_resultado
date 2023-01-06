

class wb_test_base extends uvm_test;
  
  parameter ADR_W = 8;
  parameter DAT_W = 32;
  parameter TAG_W = 1;
  
  `uvm_component_utils(wb_test_base)

  function new(string name = "wb_test_base", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  gpio_env #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) m_env;
  gpio_env_config m_env_cfg;
  gpio_reg_block rm;
  
  //typedef wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_wishbone_b3_if;
 
  virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) sigs;
  virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) vif;
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    m_env = gpio_env#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("m_env", this);
    m_env_cfg = gpio_env_config::type_id::create("m_env_cfg");
    rm = gpio_reg_block::type_id::create("rm");
    rm.build();
    m_env_cfg.rm = rm;
    
    if(!uvm_config_db#(virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "td_wishbone_b3_if",sigs))
	    `uvm_fatal("TEST", "No se obtuvo vif") 
    uvm_config_db#(virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::set(this,"m_env*", "td_wishbone_b3_if",sigs);
    
    if(!uvm_config_db#(virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "gpio_if",vif))
	    `uvm_fatal("TEST", "No se obtuvo vif") 
    uvm_config_db#(virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::set(this,"m_env*", "gpio_if",vif);
    
    uvm_config_db #(gpio_env_config)::set(this, "m_env*", "gpio_env_config", m_env_cfg);
  endfunction

    
  
  function void init_vseq(gpio_base_vseq seq);
    seq.seqr = m_env.wb_agent.seqr;
    seq.gpio_sequencer=m_env.gp_agent.gpio_sequencer;
    seq.rm = rm;
  endfunction: init_vseq
  
endclass