library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circuit_Fault_Detection is
    port (
        A, B, C, D: in std_logic;
        Z: out std_logic
    );
end Circuit_Fault_Detection;

architecture Behavioral of Circuit_Fault_Detection is
    signal net_e, net_f, net_g: std_logic;

begin
    -- Circuit implementation
    net_e <= A and B;
    net_f <= C or D;
    net_g <= not net_f;
    Z <= net_g xor net_e;

end Behavioral;
