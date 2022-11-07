library verilog;
use verilog.vl_types.all;
entity TX_FSM is
    port(
        DATA_VALID      : in     vl_logic;
        PAR_EN          : in     vl_logic;
        SER_DONE        : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Busy            : out    vl_logic;
        MUX_SEL         : out    vl_logic_vector(1 downto 0);
        SER_EN          : out    vl_logic
    );
end TX_FSM;
