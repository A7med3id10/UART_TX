library verilog;
use verilog.vl_types.all;
entity UART_TX_TOP is
    port(
        P_DATA          : in     vl_logic_vector(7 downto 0);
        DATA_VALID      : in     vl_logic;
        PAR_EN          : in     vl_logic;
        PAR_TYP         : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        TX_OUT          : out    vl_logic;
        BUSY            : out    vl_logic
    );
end UART_TX_TOP;
