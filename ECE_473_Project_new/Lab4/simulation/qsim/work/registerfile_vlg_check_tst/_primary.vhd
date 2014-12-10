library verilog;
use verilog.vl_types.all;
entity registerfile_vlg_check_tst is
    port(
        data_out_1      : in     vl_logic_vector(31 downto 0);
        data_out_2      : in     vl_logic_vector(31 downto 0);
        data_out_debug  : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end registerfile_vlg_check_tst;
