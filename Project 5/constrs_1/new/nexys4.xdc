#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
##Switches
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { x }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
## LEDs
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { z }]; #IO_L18P_T2_A24_15 Sch=led[0]
##Buttons
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L9P_T1_DQS_14 Sch=btnc

### FSM3
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
##Switches
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { x }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
## LEDs
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { z }]; #IO_L18P_T2_A24_15 Sch=led[0]
##Buttons
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L9P_T1_DQS_14 Sch=btnc
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L4N_T0_D05_14 Sch=btnu