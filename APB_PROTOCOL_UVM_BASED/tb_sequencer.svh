//class tb_sequencer#(parameter ..) extends uvm_sequencer#(trans1#(parameter variable));
class tb_sequencer extends uvm_sequencer#(trans1);
    
    //`uvm_component_param_utils(tb_sequencer#(parameter vaariable)) 
    `uvm_component_utils(tb_sequencer) 

    //constructor
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass
