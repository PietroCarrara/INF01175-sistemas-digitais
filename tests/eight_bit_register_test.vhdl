library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_register_test is end;

architecture testbench of eight_bit_register_test is
  constant period      :  time      := 10 ns;
  signal finished      :  bit       := '0';
  signal clk           :  std_ulogic := '0';
  component eight_bit_register is
    port (
      clk           : in  std_ulogic;
      reset         : in  std_ulogic;
      set_value     : in  std_ulogic;
      shift_left    : in  std_ulogic;
      shift_right   : in  std_ulogic;
      input         : in  std_ulogic_vector(7 downto 0);
      output        : out std_ulogic_vector(7 downto 0)
    );
  end component;
  signal reset         :  std_ulogic := '0';
  signal set_value     :  std_ulogic := '0';
  signal shift_left    :  std_ulogic := '0';
  signal shift_right   :  std_ulogic := '0';
  signal input         :  std_ulogic_vector(7 downto 0);
  signal output        :  std_ulogic_vector(7 downto 0);
begin
  clk <= not clk after period/2 when finished /= '1' else '0';

  dut: eight_bit_register
    port map (clk, reset, set_value, shift_left, shift_right, input, output);

  process
  begin
    set_value <= '1';
    input <= "10100100";
    wait for period;
    set_value <= '0';
    assert output = "10100100"
      report "set value didn't work"
      severity error;

    reset <= '1';
    wait for period;
    reset <= '0';
    assert output = "00000000"
      report "reset didn't work"
      severity error;


    set_value <= '1';
    input <= "11100010";
    wait for period;
    set_value <= '0';
    assert output = "11100010"
      report "set value didn't work"
      severity failure;

    shift_left <= '1';
    wait for period;
    shift_left <= '0';
    assert output = "11000100"
      report "shift left didn't work"
      severity error;

    shift_right <= '1';
    wait for period;
    shift_right <= '0';
    assert output = "01100010"
      report "shift right didn't work"
      severity error;

    finished <= '1';
    wait;
  end process;
end architecture;