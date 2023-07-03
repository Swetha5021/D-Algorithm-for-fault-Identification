library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circuit_Fault_Detection_TB is
end Circuit_Fault_Detection_TB;

architecture Behavioral of Circuit_Fault_Detection_TB is
    -- Declare the signals for testbench
    signal A_tb, B_tb, C_tb, D_tb: std_logic;
    signal Z_tb: std_logic;
    
    -- Instantiate the design entity
    component Circuit_Fault_Detection
        port (
            A, B, C, D: in std_logic;
            Z: out std_logic
        );
    end component;

begin
    -- Instantiate the design entity
    UUT: Circuit_Fault_Detection
        port map (
            A => A_tb,
            B => B_tb,
            C => C_tb,
            D => D_tb,
            Z => Z_tb
        );

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Apply test vectors
        A_tb <= '0'; B_tb <= '0'; C_tb <= '0'; D_tb <= '0'; wait for 1 ns;
        A_tb <= '0'; B_tb <= '0'; C_tb <= '0'; D_tb <= '1'; wait for 1 ns;
        A_tb <= '0'; B_tb <= '0'; C_tb <= '1'; D_tb <= '0'; wait for 1 ns;
        A_tb <= '0'; B_tb <= '0'; C_tb <= '1'; D_tb <= '1'; wait for 1 ns;
        -- Add more test vectors as needed
        
        -- Stop simulation
        wait;
    end process stimulus_proc;
    
end Behavioral;