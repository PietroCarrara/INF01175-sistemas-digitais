library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_register is
  port (
    clk           : in  std_ulogic;
    reset         : in  std_ulogic;
    set_value     : in  std_ulogic;
    shift_left    : in  std_ulogic;
    shift_right   : in  std_ulogic;
    input         : in  std_ulogic_vector(7 downto 0);
    output        : out std_ulogic_vector(7 downto 0)
  );
end entity;

architecture behav of eight_bit_register is
  signal memory : std_ulogic_vector(7 downto 0);
begin
  process (clk, reset)
  begin
    if reset = '1' then
      memory <= "00000000";
    elsif rising_edge(clk) then
      if set_value = '1' then
        memory <= input;
      elsif shift_left = '1' then
        memory <= memory(6 downto 0) & '0';
      elsif shift_right = '1' then
        memory <= '0' & memory(7 downto 1);
      end if;
    end if;
  end process;

  output <= memory;
end architecture;