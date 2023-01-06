class gpio_base_vseq #(ADR_W = 8, DAT_W = 32, TAG_W = 1) extends uvm_sequence #(wishbone_b3_sequence_item #(ADR_W, DAT_W, TAG_W));

  `uvm_object_utils(wb_base_seq#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)))

  typedef wishbone_b3_sequence_item #(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W)) td_wishbone_b3_sequence_item;
  typedef uvm_sequencer             #(td_wishbone_b3_sequence_item)                td_wishbone_b3_master_sequencer;
  
  td_wishbone_b3_master_sequencer seqr;
  uvm_sequencer #(gpio_seq_item#(.ADR_W(ADR_W), .DAT_W(DAT_W), .TAG_W(TAG_W))) gpio_sequencer;
  gpio_reg_block rm;

  function new(string name = "gpio_base_vseq");
    super.new(name);
  endfunction

endclass: gpio_base_vseq