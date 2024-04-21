library ieee;
use ieee.std_logic_1164.all;


entity eight_bit_register_test is end;

architecture testbench of eight_bit_register_test is
  constant period : time      := 10 ns;
  signal finished : bit       := '0';
  signal clk      : std_logic := '0';
  component eight_bit_register is
    port (
      clk           : in  std_logic;
      reset         : in  std_logic;
      write_enabled : in  std_logic;
      input         : in  std_logic_vector(7 downto 0);
      output        : out std_logic_vector(7 downto 0)
    );
  end component;
begin
  clk <= not clk after period/2 when finished /= '1' else '0';

  process
  begin
    finished <= '1';
    wait;
  end process;
end architecture;