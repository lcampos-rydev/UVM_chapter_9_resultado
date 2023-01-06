



class gpio_seq_item #(ADR_W = 32, DAT_W = 64, TAG_W = 1) extends uvm_sequence_item;
  
  rand bit [DAT_W-1:0] data;
  bit [DAT_W-1:0] data_o;
  bit rw;
  
  `uvm_object_utils_begin(gpio_seq_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)));
    `uvm_field_int(data,  UVM_ALL_ON)
    `uvm_field_int(rw,  UVM_ALL_ON)
  `uvm_field_int(data_o,  UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "gpio_seq_item");
	super.new(name);
  endfunction

  function string convert2string();

  convert2string = $sformatf(
    "data = 0x%H, rw =%0bs, data_o =0x%H",
     data, rw, data_o);

  endfunction

  
endclass