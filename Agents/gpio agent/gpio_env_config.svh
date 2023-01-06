class gpio_env_config extends uvm_object;

  `uvm_object_utils(gpio_env_config)

  gpio_reg_block rm;

  function new(string name = "gpio_env_config");
    super.new(name);
  endfunction

endclass
