library verilog;
use verilog.vl_types.all;
entity delta is
    port(
        CLK             : in     vl_logic;
        X_Pu_IN         : in     vl_logic;
        X_Di_IN         : in     vl_logic;
        Y_Pu_IN         : in     vl_logic;
        Y_Di_IN         : in     vl_logic;
        Z_Pu_IN         : in     vl_logic;
        Z_Di_IN         : in     vl_logic;
        A_Pu_OUT        : out    vl_logic;
        A_Di_OUT        : out    vl_logic
    );
end delta;
