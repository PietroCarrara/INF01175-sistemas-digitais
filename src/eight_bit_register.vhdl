library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_register is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    write_enabled : in  std_logic;
    input         : in  std_logic_vector(7 downto 0);
    output        : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behav of eight_bit_register is
begin
  process (clk, reset)
  begin
    if reset = '1' then
      output <= "00000000";
    elsif rising_edge(clk) and write_enabled = '1' then
      output <= input;
    end if;
  end process;
end architecture;