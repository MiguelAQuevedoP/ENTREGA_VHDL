library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_test is
	port( reset, clock, writen : in std_logic;
			address, data_in: in std_logic_vector(7 downto 0);
			port_in_00, port_in_01, port_in_02, port_in_03,
			port_in_04, port_in_05, port_in_06, port_in_07: in std_logic_vector(7 downto 0);
			
			port_out_00, port_out_01, port_out_02, port_out_03,
			port_out_04, port_out_05, port_out_06, port_out_07: out std_logic_vector(7 downto 0);
			data_out : out std_logic_vector (7 downto 0);
			HEX00, HEX01 : out std_logic_vector(6 downto 0));
end entity;

architecture behavioral of memory_test is
	
	signal port_data_out : std_logic_vector(7 downto 0);
	signal SW0 : std_logic_vector(3 downto 0) := port_data_out(3 downto 0);
	signal SW1 : std_logic_vector(3 downto 0) := port_data_out(7 downto 4);

	
	component memory
	port	( reset, clock, writen: in std_logic;
					
			address, data_in : in std_logic_vector(7 downto 0);
			port_in_00, port_in_01, port_in_02, port_in_03,
			port_in_04, port_in_05, port_in_06, port_in_07 : in std_logic_vector(7 downto 0);
			
			port_out_00, port_out_01, port_out_02, port_out_03,
			port_out_04, port_out_05, port_out_06, port_out_07 : out std_logic_vector(7 downto 0);
			
			data_out : out std_logic_vector(7 downto 0));
	end component;
	
	component deco7segV3
	port(-- Input ports
			SW : in std_logic_vector(3 downto 0);
		-- Output ports
			HEX : out std_logic_vector (6 downto 0));
	end component;
	
	begin
	
		
		U0: memory port map(reset, clock, writen, address, data_in, port_in_00, port_in_01, port_in_02, port_in_03,
									port_in_04, port_in_05, port_in_06, port_in_07,port_out_00, port_out_01, port_out_02, port_out_03,
									port_out_04, port_out_05, port_out_06, port_out_07, port_data_out);
		
		display0 : deco7segV3 port map(SW0, HEX00);
		display1 : deco7segV3 port map(SW1, HEX01);
		
	end behavioral;