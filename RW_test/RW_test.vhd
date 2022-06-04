library ieee;
use ieee.std_logic_1164.all;
use ieee. numeric_std.all;

entity RW_test is

	port (CLOCK, writen : in std_logic;
			address, data_in : in std_logic_vector(7 downto 0);
			HEX00, HEX01, HEX02, HEX03 : out std_logic_vector(6 downto 0)
			);
			
end entity;


architecture behavioral of RW_test is
	signal ram_data_out : std_logic_vector(7 downto 0);
	signal SW0 : std_logic_vector(3 downto 0) := ram_data_out(3 downto 0);
	signal SW1 : std_logic_vector(3 downto 0) := ram_data_out(7 downto 4);
	signal SW2 : std_logic_vector(3 downto 0) := address(3 downto 0);
	signal SW3 : std_logic_vector(3 downto 0) := address(7 downto 4);
	
	component rw_96x8_sync
	port	(clock, writen    : in std_logic;
			 address  : in std_logic_vector(7 downto 0);
			 data_in  : in std_logic_vector(7 downto 0);
			 data_out : out std_logic_vector(7 downto 0));
	end component;
	
	component deco7segV3
	port(-- Input ports
			SW : in std_logic_vector(3 downto 0);
		  -- Output ports
			HEX : out std_logic_vector (6 downto 0));
	end component;
	
begin

		ram : rw_96x8_sync port map(CLOCK, writen, address, data_in, ram_data_out);
		display0 : deco7segV3 port map(SW0, HEX00);
		display1 : deco7segV3 port map(SW1, HEX01);
		display2 : deco7segV3 port map(SW2, HEX02);
		display3 : deco7segV3 port map(SW3, HEX03);
		
end behavioral;
