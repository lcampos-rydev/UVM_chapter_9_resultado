class gpio_env #(ADR_W = 8, DAT_W = 32, TAG_W = 1)extends uvm_env;

  `uvm_component_utils(gpio_env#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))
  
  typedef wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_wishbone_b3_sequence_item;
  typedef wishbone_b3_master_agent #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_wishbone_b3_master_agent;
  //typedef wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_wishbone_b3_if;
  typedef scoreboard #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_scoreboard;
  typedef wishbone_b3_reg_adapter #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W) ) td_wishbone_b3_reg_adapter;
  
  typedef gpio_agent #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_gpio_agent;
  
  function new(string name="enviroment", uvm_component parent=null); // se crea la function como uvm con padres nulos
	   super.new(name,parent);
  endfunction
  
  wishbone_b3_master_cfg cfg;
  gpio_env_config m_cfg;
  virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) sigs;
  virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) vif;
  
  
  td_wishbone_b3_master_agent wb_agent;
  td_wishbone_b3_reg_adapter wb_adapter;
  uvm_reg_predictor #(td_wishbone_b3_sequence_item) wb_predictor;
  
  td_gpio_agent gp_agent;
  
  td_scoreboard scb;
  
  virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cfg = wishbone_b3_master_cfg::type_id::create("cfg", this);
    cfg.is_active=1;
    
    if(!uvm_config_db #(gpio_env_config)::get(this, "", "gpio_env_config", m_cfg)) begin
       `uvm_error("build_phase", "Unable to get uart_env_config from uvm_config_db")
      end
    
    if(!uvm_config_db#(virtual wishbone_b3_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "td_wishbone_b3_if",sigs))
      `uvm_fatal("env", "No se obtuvo vif") 
    
    if(!uvm_config_db#(virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))::get(this,"", "gpio_if",vif))
      `uvm_fatal("env", "No se obtuvo gpio_vif") 
    
    
    wb_agent = td_wishbone_b3_master_agent::type_id::create("wb_agent", this); 
    wb_agent.sigs=sigs;
    wb_agent.cfg=cfg;
    wb_adapter=td_wishbone_b3_reg_adapter::type_id::create("wb_adapter", this); 
    wb_predictor=uvm_reg_predictor#(td_wishbone_b3_sequence_item)::type_id::create("wb_predictor", this);
    
    gp_agent = td_gpio_agent::type_id::create("gp_agent", this);
    gp_agent.sigs=sigs;
    gp_agent.vif=vif;
    scb = td_scoreboard::type_id::create("scb", this); 

	endfunction
  
  
    virtual function void connect_phase(uvm_phase phase);
      
      wb_agent.analysis_port.connect(scb.item_collected_export_wb);
      gp_agent.gpio_m0.gpio_port.connect(scb.item_collected_export_gp);
      m_cfg.rm.map.set_sequencer(wb_agent.seqr, wb_adapter);
      wb_predictor.map = m_cfg.rm.map;
      wb_predictor.adapter = wb_adapter;
      wb_agent.analysis_port.connect(wb_predictor.bus_in);
	endfunction
  
  
endclass
  
  