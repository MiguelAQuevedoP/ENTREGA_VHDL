library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	
	port
	( reset, clock, writen: in std_logic;
					
			address, data_in : in std_logic_vector(7 downto 0);
			port_in_00, port_in_01, port_in_02, port_in_03,
			port_in_04, port_in_05, port_in_06, port_in_07 : in std_logic_vector(7 downto 0);
			
			port_out_00, port_out_01, port_out_02, port_out_03,
			port_out_04, port_out_05, port_out_06, port_out_07 : out std_logic_vector(7 downto 0);
			
			data_out : out std_logic_vector(7 downto 0)
			

);
		
end memory;


architecture behavioral of memory is

	component rom_128x8_sync is
		port ( address : in std_logic_vector(7 downto 0);
				 clock : in std_logic;
				 data_out : out std_logic_vector(7 downto 0));
				 
	end component;
	
	component rw_96x8_sync is
		port( address, data_in : in std_logic_vector(7 downto 0);
				writen, clock : in std_logic;
				data_out : out std_logic_vector(7 downto 0));
				
	end component;
	
	component output_ports is
		port( address, data_in : in std_logic_vector(7 downto 0);
				writen, reset, clock : in std_logic;
				
				port_out_00, port_out_01, port_out_02, port_out_03,
				port_out_04, port_out_05, port_out_06, port_out_07 : out std_logic_vector(7 downto 0));
	
	end component;
	
	
	signal rom_data_out, rw_data_out : std_logic_vector(7 downto 0);
	
begin

	rom : rom_128x8_sync port map (address, clock, rom_data_out);
	ram : rw_96x8_sync port map (address, data_in, writen, clock, rw_data_out);
	ports_out : output_ports port map(address, data_in, writen, reset, clock,port_out_00, port_out_01, port_out_02, port_out_03,
											port_out_04, port_out_05, port_out_06, port_out_07);
	
	
		MUX1 : process (  address, rom_data_out, rw_data_out,
								port_in_00, port_in_01, port_in_02, port_in_03,
								port_in_04, port_in_05, port_in_06, port_in_07)
		begin
				if ( (to_integer(unsigned(address)) >= 0) and
						(to_integer(unsigned(address)) <= 127)) then
					data_out <= rom_data_out;
					
				elsif ( (to_integer(unsigned(address)) >= 128) and
						(to_integer(unsigned(address)) <= 223)) then
					data_out <= rw_data_out;
					
					
				elsif (address = x"F0") then data_out <= port_in_00;
				elsif (address = x"F1") then data_out <= port_in_01;
				elsif (address = x"F2") then data_out <= port_in_02;
				elsif (address = x"F3") then data_out <= port_in_03;
				elsif (address = x"F4") then data_out <= port_in_04;
				elsif (address = x"F5") then data_out <= port_in_05;
				elsif (address = x"F6") then data_out <= port_in_06;
				elsif (address = x"F7") then data_out <= port_in_07;

				
				else data_out <= x"00";
				
				end if;
		end process;
		
end behavioral;