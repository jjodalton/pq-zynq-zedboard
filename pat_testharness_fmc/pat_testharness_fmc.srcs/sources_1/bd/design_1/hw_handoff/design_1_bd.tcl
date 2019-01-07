
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:1.2 [current_project]


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set gpio_dac [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_dac ]
  set gpio_modes [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_modes ]
  set gpio_pwm_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_pwm_1 ]
  set gpio_pwm_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_pwm_2 ]
  set gpio_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_rtl ]
  set iic_axi [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_axi ]

  # Create ports
  set apins_N [ create_bd_port -dir O -from 7 -to 0 apins_N ]
  set apins_P [ create_bd_port -dir O -from 7 -to 0 apins_P ]
  set bin_N [ create_bd_port -dir I -from 0 -to 7 bin_N ]
  set bin_P [ create_bd_port -dir I -from 0 -to 7 bin_P ]
  set bpins [ create_bd_port -dir O -from 3 -to 0 bpins ]
  set clkReturn_N [ create_bd_port -dir I clkReturn_N ]
  set clkReturn_P [ create_bd_port -dir I clkReturn_P ]
  set clk_pat [ create_bd_port -dir O clk_pat ]
  set clk_pat_locked [ create_bd_port -dir O clk_pat_locked ]
  set pwm_clk [ create_bd_port -dir O -type clk pwm_clk ]
  set pwm_high [ create_bd_port -dir I -from 0 -to 0 pwm_high ]
  set pwm_high_N [ create_bd_port -dir O -from 0 -to 0 pwm_high_N ]
  set pwm_high_P [ create_bd_port -dir O -from 0 -to 0 pwm_high_P ]
  set pwm_low [ create_bd_port -dir I -from 0 -to 0 pwm_low ]
  set pwm_low_N [ create_bd_port -dir O -from 0 -to 0 pwm_low_N ]
  set pwm_low_P [ create_bd_port -dir O -from 0 -to 0 pwm_low_P ]
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set_property -dict [ list CONFIG.FREQ_HZ {100000000} CONFIG.PHASE {0.000}  ] $sys_clock

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_GPIO_WIDTH {16} CONFIG.GPIO_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_0

  # Create instance: axi_gpio_abpins, and set properties
  set axi_gpio_abpins [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_abpins ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_INPUTS_2 {1} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO2_WIDTH {8} CONFIG.C_GPIO_WIDTH {12} CONFIG.C_INTERRUPT_PRESENT {1} CONFIG.C_IS_DUAL {1} CONFIG.GPIO2_BOARD_INTERFACE {Custom} CONFIG.GPIO_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_abpins

  # Create instance: axi_gpio_clock, and set properties
  set axi_gpio_clock [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_clock ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS_2 {1} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_DOUT_DEFAULT {0x00000000} CONFIG.C_GPIO2_WIDTH {20} CONFIG.C_GPIO_WIDTH {4} CONFIG.C_INTERRUPT_PRESENT {0} CONFIG.C_IS_DUAL {1}  ] $axi_gpio_clock

  # Create instance: axi_gpio_dac, and set properties
  set axi_gpio_dac [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_dac ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_DOUT_DEFAULT {0x00000400} CONFIG.C_GPIO_WIDTH {11} CONFIG.GPIO_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_dac

  # Create instance: axi_gpio_modes, and set properties
  set axi_gpio_modes [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_modes ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {5} CONFIG.GPIO_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_modes

  # Create instance: axi_gpio_pwm, and set properties
  set axi_gpio_pwm [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_pwm ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_ALL_OUTPUTS_2 {1} CONFIG.C_DOUT_DEFAULT {0xff00ff00} CONFIG.C_DOUT_DEFAULT_2 {0x0f0f0e0F} CONFIG.C_GPIO2_WIDTH {20} CONFIG.C_GPIO_WIDTH {30} CONFIG.C_IS_DUAL {1}  ] $axi_gpio_pwm

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]

  # Create instance: clk_pat, and set properties
  set clk_pat [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_pat ]
  set_property -dict [ list CONFIG.CLKOUT1_DRIVES {BUFGCE} CONFIG.CLKOUT1_JITTER {174.686} CONFIG.CLKOUT1_PHASE_ERROR {92.672} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {20} CONFIG.CLKOUT2_DRIVES {BUFGCE} CONFIG.CLKOUT2_JITTER {123.670} CONFIG.CLKOUT2_PHASE_ERROR {92.672} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {100} CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_JITTER {97.082} CONFIG.CLKOUT3_PHASE_ERROR {98.575} CONFIG.CLKOUT3_USED {false} CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.NUM_OUT_CLKS {2} CONFIG.USE_BOARD_FLOW {true} CONFIG.USE_DYN_PHASE_SHIFT {false} CONFIG.USE_DYN_RECONFIG {true} CONFIG.USE_PHASE_ALIGNMENT {false} CONFIG.USE_SAFE_CLOCK_STARTUP {true}  ] $clk_pat

  # Create instance: clock_measure_0, and set properties
  set clock_measure_0 [ create_bd_cell -type ip -vlnv simon.cs.bris.ac.uk:user:clock_measure:1.0 clock_measure_0 ]

  # Create instance: clock_select_0, and set properties
  set clock_select_0 [ create_bd_cell -type ip -vlnv ac.uk:user:clock_select:1.0 clock_select_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} CONFIG.PCW_I2C0_I2C0_IO {MIO 14 .. 15} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_MIO_10_PULLUP {enabled} CONFIG.PCW_MIO_11_PULLUP {enabled} CONFIG.PCW_MIO_12_PULLUP {enabled} CONFIG.PCW_MIO_13_PULLUP {enabled} CONFIG.PCW_MIO_14_PULLUP {enabled} CONFIG.PCW_MIO_15_PULLUP {enabled} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} CONFIG.PCW_SPI1_SPI1_IO {MIO 10 .. 15} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.preset {ZedBoard*}  ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list CONFIG.NUM_MI {8}  ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: util_ds_buf_apins, and set properties
  set util_ds_buf_apins [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.0 util_ds_buf_apins ]
  set_property -dict [ list CONFIG.C_BUF_TYPE {OBUFDS} CONFIG.C_SIZE {8}  ] $util_ds_buf_apins

  # Create instance: util_ds_buf_bin, and set properties
  set util_ds_buf_bin [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.0 util_ds_buf_bin ]
  set_property -dict [ list CONFIG.C_SIZE {8}  ] $util_ds_buf_bin

  # Create instance: util_ds_buf_clkReturn, and set properties
  set util_ds_buf_clkReturn [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.0 util_ds_buf_clkReturn ]

  # Create instance: util_ds_buf_pwm_high, and set properties
  set util_ds_buf_pwm_high [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.0 util_ds_buf_pwm_high ]
  set_property -dict [ list CONFIG.C_BUF_TYPE {OBUFDS}  ] $util_ds_buf_pwm_high

  # Create instance: util_ds_buf_pwm_low, and set properties
  set util_ds_buf_pwm_low [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.0 util_ds_buf_pwm_low ]
  set_property -dict [ list CONFIG.C_BUF_TYPE {OBUFDS}  ] $util_ds_buf_pwm_low

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list CONFIG.DIN_FROM {7} CONFIG.DIN_TO {0} CONFIG.DIN_WIDTH {12}  ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list CONFIG.DIN_FROM {11} CONFIG.DIN_TO {8} CONFIG.DIN_WIDTH {12}  ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list CONFIG.DIN_WIDTH {4}  ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list CONFIG.DIN_FROM {1} CONFIG.DIN_TO {1} CONFIG.DIN_WIDTH {4}  ] $xlslice_3

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list CONFIG.DIN_FROM {2} CONFIG.DIN_TO {2} CONFIG.DIN_WIDTH {4}  ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list CONFIG.DIN_FROM {3} CONFIG.DIN_TO {3} CONFIG.DIN_WIDTH {4}  ] $xlslice_5

  # Create interface connections
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports gpio_rtl] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_dac_GPIO [get_bd_intf_ports gpio_dac] [get_bd_intf_pins axi_gpio_dac/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_modes_GPIO [get_bd_intf_ports gpio_modes] [get_bd_intf_pins axi_gpio_modes/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_pwm_GPIO [get_bd_intf_ports gpio_pwm_1] [get_bd_intf_pins axi_gpio_pwm/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_pwm_GPIO2 [get_bd_intf_ports gpio_pwm_2] [get_bd_intf_pins axi_gpio_pwm/GPIO2]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports iic_axi] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_gpio_abpins/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_gpio_modes/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins clk_pat/s_axi_lite] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins axi_gpio_dac/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_gpio_pwm/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_gpio_clock/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M07_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M07_AXI]

  # Create port connections
  connect_bd_net -net IBUF_DS_N_1 [get_bd_ports bin_N] [get_bd_pins util_ds_buf_bin/IBUF_DS_N]
  connect_bd_net -net IBUF_DS_P_1 [get_bd_ports bin_P] [get_bd_pins util_ds_buf_bin/IBUF_DS_P]
  connect_bd_net -net axi_gpio_abpins_gpio_io_o [get_bd_pins axi_gpio_abpins/gpio_io_o] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net axi_gpio_abpins_ip2intc_irpt [get_bd_pins axi_gpio_abpins/ip2intc_irpt] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net axi_gpio_clock_gpio_io_o [get_bd_pins axi_gpio_clock/gpio_io_o] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_5/Din]
  connect_bd_net -net clkReturn_N_1 [get_bd_ports clkReturn_N] [get_bd_pins util_ds_buf_clkReturn/IBUF_DS_N]
  connect_bd_net -net clkReturn_P_1 [get_bd_ports clkReturn_P] [get_bd_pins util_ds_buf_clkReturn/IBUF_DS_P]
  connect_bd_net -net clk_pat_clk_out1 [get_bd_pins clk_pat/clk_out1] [get_bd_pins clock_select_0/vco_clock]
  connect_bd_net -net clk_pat_clk_out2 [get_bd_ports pwm_clk] [get_bd_pins clk_pat/clk_out2] [get_bd_pins clock_measure_0/clk_ref]
  connect_bd_net -net clk_pat_locked1 [get_bd_ports clk_pat_locked] [get_bd_pins clk_pat/locked] [get_bd_pins clock_select_0/reset_n]
  connect_bd_net -net clock_measure_0_measurement [get_bd_pins axi_gpio_clock/gpio2_io_i] [get_bd_pins clock_measure_0/measurement]
  connect_bd_net -net clock_select_0_clock_out [get_bd_ports clk_pat] [get_bd_pins clock_select_0/clock_out]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_abpins/s_axi_aclk] [get_bd_pins axi_gpio_clock/s_axi_aclk] [get_bd_pins axi_gpio_dac/s_axi_aclk] [get_bd_pins axi_gpio_modes/s_axi_aclk] [get_bd_pins axi_gpio_pwm/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins clk_pat/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net pwm_high_1 [get_bd_ports pwm_high] [get_bd_pins util_ds_buf_pwm_high/OBUF_IN]
  connect_bd_net -net pwm_low_1 [get_bd_ports pwm_low] [get_bd_pins util_ds_buf_pwm_low/OBUF_IN]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_abpins/s_axi_aresetn] [get_bd_pins axi_gpio_clock/s_axi_aresetn] [get_bd_pins axi_gpio_dac/s_axi_aresetn] [get_bd_pins axi_gpio_modes/s_axi_aresetn] [get_bd_pins axi_gpio_pwm/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins clk_pat/s_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_pat/clk_in1]
  connect_bd_net -net util_ds_buf_0_OBUF_DS_N [get_bd_ports apins_N] [get_bd_pins util_ds_buf_apins/OBUF_DS_N]
  connect_bd_net -net util_ds_buf_0_OBUF_DS_P [get_bd_ports apins_P] [get_bd_pins util_ds_buf_apins/OBUF_DS_P]
  connect_bd_net -net util_ds_buf_bin_IBUF_OUT [get_bd_pins axi_gpio_abpins/gpio2_io_i] [get_bd_pins util_ds_buf_bin/IBUF_OUT]
  connect_bd_net -net util_ds_buf_clkReturn_IBUF_OUT [get_bd_pins clock_measure_0/clk_measure] [get_bd_pins util_ds_buf_clkReturn/IBUF_OUT]
  connect_bd_net -net util_ds_buf_pwm_high_OBUF_DS_N [get_bd_ports pwm_high_N] [get_bd_pins util_ds_buf_pwm_high/OBUF_DS_N]
  connect_bd_net -net util_ds_buf_pwm_high_OBUF_DS_P [get_bd_ports pwm_high_P] [get_bd_pins util_ds_buf_pwm_high/OBUF_DS_P]
  connect_bd_net -net util_ds_buf_pwm_low_OBUF_DS_N [get_bd_ports pwm_low_N] [get_bd_pins util_ds_buf_pwm_low/OBUF_DS_N]
  connect_bd_net -net util_ds_buf_pwm_low_OBUF_DS_P [get_bd_ports pwm_low_P] [get_bd_pins util_ds_buf_pwm_low/OBUF_DS_P]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins util_ds_buf_apins/OBUF_IN] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_ports bpins] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins clock_select_0/manual_clock] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins clock_select_0/clock_select] [get_bd_pins xlslice_3/Dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins clock_measure_0/rst_n] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins clock_measure_0/enable] [get_bd_pins xlslice_5/Dout]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x41220000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41210000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_pwm/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41250000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_clock/S_AXI/Reg] SEG_axi_gpio_1_Reg1
  create_bd_addr_seg -range 0x10000 -offset 0x41240000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_abpins/S_AXI/Reg] SEG_axi_gpio_abpins_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_dac/S_AXI/Reg] SEG_axi_gpio_dac_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41230000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_modes/S_AXI/Reg] SEG_axi_gpio_modes_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs clk_pat/s_axi_lite/Reg] SEG_clk_pat_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


