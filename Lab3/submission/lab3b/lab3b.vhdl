LIBRARY ieee;
USE ieee.std_logic_1164.all;
library work;
use work.Basicstructure.all;

ENTITY lab3b IS
PORT ( 
         x_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         S1  :  IN   STD_LOGIC;
         S0 : In std_logic;
         output : out std_logic_vector(7 downto 0);
         carry_out : out std_logic;
         X : out std_logic_vector(2 downto 0)
);
END lab3b;

ARCHITECTURE structural OF lab3b IS
signal temp,output1,output2,temp1 : std_logic_vector(7 downto 0);
signal carry_out1,carry_out2,zf,tempo:std_logic;

begin
temp1 <= (not y_in);
inst1: CLA port map(x_in => x_in, y_in => y_in, carry_in => '0', sum => output1, carry_out => carry_out1);
inst2: CLA port map(x_in => x_in, y_in => temp1, carry_in => '1', sum => output2, carry_out => carry_out2);

process(x_in,y_in,S1,S0,temp,output1,output2,carry_out1,carry_out2,zf)

begin

if S0 = '0' and S1 = '0' then
output<=output1;
temp<=output1;
carry_out<=carry_out1;
tempo<=carry_out1;

elsif S0 = '1' and S1 = '0' then
output<=output2;
temp<=output2;
carry_out<=carry_out2;
tempo<=carry_out2;

elsif S0 = '0' and S1 = '1' then
output <= x_in and y_in;
temp <= x_in and y_in;
carry_out <= '0';
tempo <= '0';

else
output <= x_in xor y_in;
temp <= x_in xor y_in; 
carry_out <= '0';
tempo <= '0';

end if;

if temp(7 downto 0) = "00000000" then
zf <= '1';
else
zf <= '0';
end if;

if zf = '1' then
X <= "010";
elsif tempo = '1' then
X <= "100";
else
X <= "001";
end if;

end process;


end structural;
