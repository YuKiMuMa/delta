library verilog;
use verilog.vl_types.all;
entity delta_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        X_Di_IN         : in     vl_logic;
        X_Pu_IN         : in     vl_logic;
        Y_Di_IN         : in     vl_logic;
        Y_Pu_IN         : in     vl_logic;
        Z_Di_IN         : in     vl_logic;
        Z_Pu_IN         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end delta_vlg_sample_tst;
