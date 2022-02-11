##Switches
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports d]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports c]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports b]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports a]
## LEDs
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports f0]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports f1]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports f2]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports f3]
##Timing Constraints
set_max_delay -from [get_ports {a b c d}] -to [get_ports {f0 f1 f2 f3}] 9.000
## LOC Constraints
set_property BEL D6LUT [get_cells f0_OBUF_inst_i_1]
set_property LOC SLICE_X12Y67 [get_cells f0_OBUF_inst_i_1]
set_property BEL D5LUT [get_cells f2_OBUF_inst_i_1]
set_property BEL D6LUT [get_cells f3_OBUF_inst_i_1]
set_property LOC SLICE_X12Y66 [get_cells f2_OBUF_inst_i_1]
set_property LOC SLICE_X12Y66 [get_cells f3_OBUF_inst_i_1]
set_property BEL D6LUT [get_cells exor0/lut]
set_property LOC SLICE_X13Y67 [get_cells exor0/lut]
set_property BEL D6LUT [get_cells exor0/lut_i_1]
set_property LOC SLICE_X14Y64 [get_cells exor0/lut_i_1]
set_property BEL C6LUT [get_cells exor0/lut_i_2]
set_property LOC SLICE_X14Y64 [get_cells exor0/lut_i_2]
