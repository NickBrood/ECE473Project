library verilog;
use verilog.vl_types.all;
entity simpleregister_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0);
        rst             : in     vl_logic;
        wrt             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end simpleregister_vlg_sample_tst;
