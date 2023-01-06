


interface gpio_if #(DAT_W  = 32, ADR_W  = 8, TAG_W  = 1)(input bit clk);
  
  logic [DAT_W-1:0] in_pad_i;
  logic [DAT_W-1:0] out_pad_o;
  logic [DAT_W-1:0] oen_padoen_o;
  logic ext_clk_pad_i;  
  
endinterface