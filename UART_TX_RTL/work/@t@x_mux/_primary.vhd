library verilog;
use verilog.vl_types.all;
entity TX_mux is
    port(
        MUX_SEL         : in     vl_logic_vector(1 downto 0);
        \Busy\          : in     vl_logic;
        START_BIT       : in     vl_logic;
        SER_DATA        : in     vl_logic;
        PAR_BIT         : in     vl_logic;
        STOP_BIT        : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        TX_OUT          : out    vl_logic;
        \BUSY\          : out    vl_logic
    );
end TX_mux;
