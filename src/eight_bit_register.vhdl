library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_register is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    set_value     : in  std_logic;
    shift_left    : in  std_logic;
    shift_right   : in  std_logic;
    input         : in  std_logic_vector(7 downto 0);
    output        : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behav of eight_bit_register is
  signal memory : std_logic_vector(7 downto 0);
begin
  process (clk, reset)
  begin
    if reset = '1' then
      memory <= "00000000";
    elsif rising_edge(clk) and set_value = '1' then
      memory <= input;
    elsif rising_edge(clk) and shift_left = '1' then
      memory <= memory(6 downto 0) & '0';
    elsif rising_edge(clk) and shift_right = '1' then
      memory <= '0' & memory(7 downto 1);
    end if;
  end process;

  output <= memory;
end architecture;