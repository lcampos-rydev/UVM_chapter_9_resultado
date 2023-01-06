class wb_write_input_seq extends wb_base_seq;

  `uvm_object_utils(wb_write_input_seq)
  rand bit [DAT_W-1:0] data;
  function new(string name = "wb_write_input_seq");
  super.new(name);
endfunction

task body;
  super.body();

 
  //write a number to see at outputs
  for(int i=0; i<3; i++)begin
     gpio_seq_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) rsp_item=gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("rsp_item");
    gpio_seq_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))item=gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))::type_id::create("item");
    start_item(item);
    item.rw=1;
    finish_item(item);
    this.randomize;
    rm.OUT.write(status, data, .parent(this));
    get_response(rsp_item);
  end


endtask

endclass: wb_write_input_seq