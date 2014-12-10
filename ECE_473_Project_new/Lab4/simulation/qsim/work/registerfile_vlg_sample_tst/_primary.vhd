library verilog;
use verilog.vl_types.all;
entity registerfile_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        clock_debug     : in     vl_logic;
        read_address_1  : in     vl_logic_vector(4 downto 0);
        read_address_2  : in     vl_logic_vector(4 downto 0);
        read_address_debug: in     vl_logic_vector(4 downto 0);
        reset           : in     vl_logic;
        write_address   : in     vl_logic_vector(4 downto 0);
        write_data_in   : in     vl_logic_vector(31 downto 0);
        WriteEnable     : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end registerfile_vlg_sample_tst;
