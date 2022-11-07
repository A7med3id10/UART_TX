library verilog;
use verilog.vl_types.all;
entity TX_parity is
    port(
        P_DATA          : in     vl_logic_vector(7 downto 0);
        DATA_VALID      : in     vl_logic;
        PAR_EN          : in     vl_logic;
        PAR_TYP         : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        PAR_BIT         : out    vl_logic
    );
end TX_parity;
