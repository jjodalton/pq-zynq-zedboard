# Buttons
# Up
set_property PACKAGE_PIN T18 [get_ports {gpio_rtl_tri_io[0]}]
# Down
set_property PACKAGE_PIN R16 [get_ports {gpio_rtl_tri_io[1]}]
# Left
set_property PACKAGE_PIN N15 [get_ports {gpio_rtl_tri_io[2]}]
# Right
set_property PACKAGE_PIN R18 [get_ports {gpio_rtl_tri_io[3]}]
# Centre
set_property PACKAGE_PIN P16 [get_ports {gpio_rtl_tri_io[4]}]

set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[0]}]


# Slide switches 2-6
set_property PACKAGE_PIN H18 [get_ports {gpio_rtl_tri_io[5]}]
set_property PACKAGE_PIN H17 [get_ports {gpio_rtl_tri_io[6]}]

set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[5]}]



# LEDs
set_property PACKAGE_PIN T22 [get_ports {gpio_rtl_tri_io[8]}]
set_property PACKAGE_PIN T21 [get_ports {gpio_rtl_tri_io[9]}]
set_property PACKAGE_PIN U22 [get_ports {gpio_rtl_tri_io[10]}]
set_property PACKAGE_PIN U21 [get_ports {gpio_rtl_tri_io[11]}]
set_property PACKAGE_PIN V22 [get_ports {gpio_rtl_tri_io[12]}]
set_property PACKAGE_PIN W22 [get_ports {gpio_rtl_tri_io[13]}]
# last two LEDs re-purposed for clock locked indicators
#set_property PACKAGE_PIN U19 [get_ports {gpio_rtl_tri_io[14]}]
#set_property PACKAGE_PIN U14 [get_ports {gpio_rtl_tri_io[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_rtl_tri_io[5]}]

set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[8]}]


set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[15]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[14]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[13]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[12]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[11]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[10]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[9]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[8]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[7]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[6]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[5]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[4]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[3]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[2]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[1]}]
set_property PULLDOWN true [get_ports {gpio_rtl_tri_io[0]}]


# modes
set_property PACKAGE_PIN N20 [get_ports {gpio_modes_tri_o[0]}]
set_property PACKAGE_PIN J18 [get_ports {gpio_modes_tri_o[1]}]
set_property PACKAGE_PIN K18 [get_ports {gpio_modes_tri_o[2]}]
set_property PACKAGE_PIN R21 [get_ports {gpio_modes_tri_o[3]}]
set_property PACKAGE_PIN R20 [get_ports {gpio_modes_tri_o[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_modes_tri_o[*]}]
set_property PULLDOWN true [get_ports {gpio_modes_tri_o[4]}]
set_property PULLDOWN true [get_ports {gpio_modes_tri_o[3]}]
set_property PULLDOWN true [get_ports {gpio_modes_tri_o[2]}]
set_property PULLDOWN true [get_ports {gpio_modes_tri_o[1]}]
set_property PULLDOWN true [get_ports {gpio_modes_tri_o[0]}]





# b0-b3 output
set_property PACKAGE_PIN N17 [get_ports {bpins[3]}]
set_property PACKAGE_PIN N18 [get_ports {bpins[2]}]
set_property PACKAGE_PIN J22 [get_ports {bpins[1]}]
set_property PACKAGE_PIN J21 [get_ports {bpins[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {bpins[*]}]



# a0-a7
set_property PACKAGE_PIN C17 [get_ports {apins_P[0]}]
set_property PACKAGE_PIN D22 [get_ports {apins_P[1]}]
set_property PACKAGE_PIN G19 [get_ports {apins_P[2]}]
set_property PACKAGE_PIN G20 [get_ports {apins_P[3]}]
set_property PACKAGE_PIN G15 [get_ports {apins_P[4]}]
set_property PACKAGE_PIN A18 [get_ports {apins_P[5]}]
# a6 & a7 swapped, as per Harry's request.
set_property PACKAGE_PIN E19 [get_ports {apins_P[6]}]
set_property PACKAGE_PIN A16 [get_ports {apins_P[7]}]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports {apins_P[*]}]


# b pin returns
set_property IOSTANDARD LVDS_25 [get_ports {bin_N[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {bin_P[*]}]
set_property DIFF_TERM FALSE [get_ports {bin_P[0]}]
set_property DIFF_TERM FALSE [get_ports {bin_N[0]}]
set_property PACKAGE_PIN T16 [get_ports {bin_P[0]}]
set_property PACKAGE_PIN P20 [get_ports {bin_P[1]}]
set_property PACKAGE_PIN J20 [get_ports {bin_P[2]}]
set_property PACKAGE_PIN J16 [get_ports {bin_P[3]}]
set_property PACKAGE_PIN M19 [get_ports {bin_P[4]}]
set_property PACKAGE_PIN P17 [get_ports {bin_P[5]}]
set_property PACKAGE_PIN N22 [get_ports {bin_P[6]}]
set_property PACKAGE_PIN M21 [get_ports {bin_P[7]}]

# dac
set_property PACKAGE_PIN L21 [get_ports {gpio_dac_tri_o[0]}]
set_property PACKAGE_PIN L22 [get_ports {gpio_dac_tri_o[1]}]
set_property PACKAGE_PIN R19 [get_ports {gpio_dac_tri_o[2]}]
set_property PACKAGE_PIN T19 [get_ports {gpio_dac_tri_o[3]}]
set_property PACKAGE_PIN L17 [get_ports {gpio_dac_tri_o[4]}]
set_property PACKAGE_PIN M17 [get_ports {gpio_dac_tri_o[5]}]
set_property PACKAGE_PIN K19 [get_ports {gpio_dac_tri_o[6]}]
set_property PACKAGE_PIN K20 [get_ports {gpio_dac_tri_o[7]}]
set_property PACKAGE_PIN B20 [get_ports {gpio_dac_tri_o[8]}]
set_property PACKAGE_PIN B19 [get_ports {gpio_dac_tri_o[9]}]
set_property PACKAGE_PIN N19 [get_ports {gpio_dac_tri_o[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_dac_tri_o[*]}]
set_property DRIVE 4 [get_ports {gpio_dac_tri_o[*]}]

# clocks
set_property IOSTANDARD LVCMOS18 [get_ports clk_pat]
set_property SLEW FAST [get_ports clk_pat]
set_property DRIVE 16 [get_ports clk_pat]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports {pwm_low_P[0]}]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports {pwm_high_P[0]}]


# clock locked indicators
# LD7
set_property PACKAGE_PIN U14 [get_ports clk_pat_locked]


set_property IOSTANDARD LVCMOS33 [get_ports clk_pat_locked]
set_property PACKAGE_PIN W21 [get_ports {gpio_rtl_tri_io[15]}]
set_property PACKAGE_PIN W20 [get_ports {gpio_rtl_tri_io[14]}]
set_property PACKAGE_PIN H19 [get_ports {gpio_rtl_tri_io[7]}]



set_property PACKAGE_PIN Y9 [get_ports sys_clock]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clock]


set_property PACKAGE_PIN D21 [get_ports clk_pat]

set_property PACKAGE_PIN V7 [get_ports pwm_clk]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_clk]


set_property PACKAGE_PIN D20 [get_ports {pwm_low_P[0]}]

set_property PACKAGE_PIN F18 [get_ports {pwm_high_P[0]}]


set_property PACKAGE_PIN W11 [get_ports clkReturn_P]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports clkReturn_P]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports clkReturn_N]






# iic
set_property PACKAGE_PIN U6 [get_ports iic_axi_scl_io]
set_property PACKAGE_PIN U5 [get_ports iic_axi_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_axi_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_axi_sda_io]




