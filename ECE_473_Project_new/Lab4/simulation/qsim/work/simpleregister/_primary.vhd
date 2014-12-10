library verilog;
use verilog.vl_types.all;
entity simpleregister is
    port(
        \out\           : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        wrt             : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0)
    );
end simpleregister;
