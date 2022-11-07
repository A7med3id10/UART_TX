library verilog;
use verilog.vl_types.all;
entity TX_serializer is
    port(
        P_DATA          : in     vl_logic_vector(7 downto 0);
        DATA_VALID      : in     vl_logic;
        Busy            : in     vl_logic;
        SER_EN          : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        SER_DONE        : out    vl_logic;
        SER_DATA        : out    vl_logic
    );
end TX_serializer;
