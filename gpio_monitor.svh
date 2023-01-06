class gpio_monitor #(ADR_W = 32, DAT_W = 64, TAG_W = 1)extends uvm_monitor;

  `uvm_component_utils(gpio_monitor#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))

  function new(string name = "gpio_monitor", uvm_component parent = null);
  super.new(name, parent);
  endfunction

  virtual gpio_if#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) vif;
  virtual wishbone_b3_if #(.DAT_W(DAT_W), .ADR_W(ADR_W), .TAG_W(TAG_W))  sigs;
  
  uvm_event ev;
  uvm_analysis_port #(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))) gpio_port;
  
  virtual function void build_phase(uvm_phase phase); 
       super.build_phase(phase); 
    gpio_port =new("gpio_port", this);
  endfunction
    
         
  virtual task run_phase(uvm_phase phase); 
	  super.run_phase(phase);
      
    
      forever begin 
      
        gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) item = gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("item");  
        ev = uvm_event_pool::get_global("ev_ab");
        
        ev.wait_trigger;
        
        if(vif.oen_padoen_o===32'hffffffff)begin //Lectura
          if(sigs.ack===1'b1)begin
            @(negedge sigs.m_drv_cb.ack);
          end
          wait((sigs.m_drv_cb.ack === 1'b1) && (sigs.we === 1'b1));
          @(negedge sigs.m_drv_cb.ack);
          
          item.data_o=vif.out_pad_o;
          `uvm_info(get_name(),  $sformatf("%s",item.sprint() ), UVM_LOW )
        end 
        if(vif.oen_padoen_o===32'h0)begin 
          #80
          item.data_o=vif.in_pad_i;
          //wait((sigs.m_drv_cb.ack === 1'b1) && (sigs.we === 1'b0));
          //@(negedge sigs.m_drv_cb.ack);
          `uvm_info(get_name(),  $sformatf("%s",item.sprint() ), UVM_LOW )
        end
        
        gpio_port.write(item);
      end
      
  endtask
endclass