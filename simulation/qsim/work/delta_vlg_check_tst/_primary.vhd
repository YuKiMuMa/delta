library verilog;
use verilog.vl_types.all;
entity delta_vlg_check_tst is
    port(
        A_Di_OUT        : in     vl_logic;
        A_Pu_OUT        : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end delta_vlg_check_tst;
