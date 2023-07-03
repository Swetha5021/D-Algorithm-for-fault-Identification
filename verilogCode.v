--Swetha S_Girl Hackathon_Ideathon Round
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

    -- D-algorithm related signals and variables
    signal fault_detected: boolean := false;
    signal current_vector: std_logic_vector(3 downto 0) := (others => '0');
    signal fault_at: std_logic;
    signal fault_type: std_logic;

    -- Helper function to check if the fault is detected
    function fault_detected_check(fault_detected: boolean; fault_at, Z: std_logic) return boolean is
    begin
        if fault_type = '0' then
            return fault_detected and (fault_at = Z);
        else
            return fault_detected and (fault_at /= Z);
        end if;
    end function;

begin
    -- Circuit implementation
    net_e <= A and B;
    net_f <= C or D;
    net_g <= not net_f;
    Z <= net_g xor net_e;

    -- D-algorithm process
    D_algorithm_proc: process is
        variable vectors: std_logic_vector(15 downto 0) := "0000";
    begin
        -- Iterate through all possible input vectors
        for i in 0 to 15 loop
            current_vector <= std_logic_vector(to_unsigned(i, current_vector'length));
            fault_detected <= false;
            
            -- Apply current input vector
            A <= current_vector(3);
            B <= current_vector(2);
            C <= current_vector(1);
            D <= current_vector(0);
            
            -- Apply fault
            if current_vector = "0000" then
                fault_at <= '0';
                fault_type <= '0';
            elsif current_vector = "0001" then
                fault_at <= net_f;
                fault_type <= '0';
            else
                -- If you have more faults in the circuit, define them here
                fault_at <= '0';
                fault_type <= '0';
            end if;
            
            -- Simulate circuit for one clock cycle
            wait for 1 ns;
            
            -- Check if fault is detected
            fault_detected <= fault_detected_check(fault_detected, fault_at, Z);
            
            -- Store input vector if fault is detected
            if fault_detected then
                vectors(i) := '1';
            end if;
        end loop;
        
        -- Print input vector that detects the fault
        report "Input vector: " & vectors'IMAGE;
        
        -- Stop simulation
        wait;
    end process D_algorithm_proc;

end Behavioral;
