
class gpio_driver #(ADR_W = 32, DAT_W = 64, TAG_W = 1)extends uvm_driver #(gpio_seq_item #(ADR_W, DAT_W, TAG_W));

  `uvm_component_utils(gpio_driver#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))

  function new(string name = "gpio_driver", uvm_component parent = null);
  super.new(name, parent);
  endfunction

  virtual gpio_if #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) vif;
  virtual wishbone_b3_if #(.DAT_W(DAT_W), .ADR_W(ADR_W), .TAG_W(TAG_W))  sigs;
  
  uvm_event ev;
  
  virtual function void build_phase(uvm_phase phase); 
       super.build_phase(phase); 
	   
  endfunction
    
         
  virtual task run_phase(uvm_phase phase); 
	  super.run_phase(phase);
      
      
      forever begin 
      gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) item = gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("item"); 
        gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) rsp_item = gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("item"); 
       ev = uvm_event_pool::get_global("ev_ab");
       
        seq_item_port.get(item);
        ev.trigger();
        if(item.rw)begin //Lectura
          if(sigs.ack===1'b1)begin
            @(negedge sigs.m_drv_cb.ack);
          end
          wait((sigs.m_drv_cb.ack === 1'b1) && (sigs.we === 1'b1));
          @(negedge sigs.m_drv_cb.ack);
          
          item.data_o=vif.out_pad_o;
          //`uvm_info(get_name(),  $sformatf("%s",item.sprint() ), UVM_LOW )
        end else begin //escritura
          
          vif.in_pad_i<=item.data;
          
          //wait((sigs.m_drv_cb.ack === 1'b1) && (sigs.we === 1'b0));
          //@(negedge sigs.m_drv_cb.ack);
          //`uvm_info(get_name(),  $sformatf("%s",item.sprint() ), UVM_LOW )
        end
        $cast(rsp_item,item.clone());
        rsp_item.set_id_info(item);
        seq_item_port.put(rsp_item);     
      end
  endtask
endclass