library verilog;
use verilog.vl_types.all;
entity registerfile is
    port(
        data_out_1      : out    vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        clock_debug     : in     vl_logic;
        reset           : in     vl_logic;
        WriteEnable     : in     vl_logic;
        read_address_1  : in     vl_logic_vector(4 downto 0);
        read_address_2  : in     vl_logic_vector(4 downto 0);
        read_address_debug: in     vl_logic_vector(4 downto 0);
        write_address   : in     vl_logic_vector(4 downto 0);
        write_data_in   : in     vl_logic_vector(31 downto 0);
        data_out_2      : out    vl_logic_vector(31 downto 0);
        data_out_debug  : out    vl_logic_vector(31 downto 0)
    );
end registerfile;
