`uvm_analysis_imp_decl(_wb) 
`uvm_analysis_imp_decl(_gp)


class scoreboard #(ADR_W = 8, DAT_W = 32, TAG_W = 1) extends uvm_scoreboard;  

  `uvm_component_utils(scoreboard#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))

  
  int num_trac;
  int error=0;
  gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) pkt_qu_gp[$];
  wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) pkt_qu_wb[$]; 
  
  gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) gp_aux;
  wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) wb_aux;
  
  uvm_analysis_imp_gp #(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)),scoreboard) item_collected_export_gp;
  uvm_analysis_imp_wb #(wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)),scoreboard) item_collected_export_wb;

  function new (string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export_gp = new("item_collected_export_gp", this);
    item_collected_export_wb = new("item_collected_export_wb", this);
  endfunction

  virtual function void write_gp(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) pkt_m);    
    pkt_qu_gp.push_back(pkt_m);
  endfunction 
  
  virtual function void write_wb(wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) pkt_s);

    pkt_qu_wb.push_back(pkt_s);
  endfunction


  
  virtual function void report_phase (uvm_phase phase);
    num_trac=pkt_qu_gp.size();

    
    for(int i=0; i<num_trac; i++)begin
      gp_aux=pkt_qu_gp.pop_front();
      wb_aux=pkt_qu_wb.pop_front();
      
      if(gp_aux.data_o!=wb_aux.data)begin
        error++;
      end
    end
    
    if(error>0)begin
      `uvm_info("SCB", "* UVM TEST FAILED *", UVM_LOW)
    end else begin
      `uvm_info("SCB", "* UVM TEST PASSED *", UVM_LOW)
    end
  endfunction
          
endclass 