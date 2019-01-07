proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -id {Labtools 27-2149}  -string {{ERROR: [Labtools 27-2149] File C:/Users/cssjh/LocalDocuments/Xilinx/Projects/pat_testharness/pat_testharness.runs/impl_1/design_1_wrapper.bit not found. Check file name and file permissions.}}  -suppress 
set_msg_config  -id {filemgmt 20-1741}  -string {{CRITICAL WARNING: [filemgmt 20-1741] File 'slave_attachment.vhd' is used by one or more modules, but with different contents, and may lead to unpredictable results:
* design_1_axi_gpio_0_0 (c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_axi_gpio_0_0/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd)
* design_1_axi_gpio_1_0 (c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_axi_gpio_1_0/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd)
* design_1_axi_gpio_1_1 (c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_axi_gpio_1_1/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd)
* design_1_axi_gpio_1_2 (c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_axi_gpio_1_2/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd)
* design_1_axi_gpio_1_3 (c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_axi_gpio_1_3/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd)
Please reset and regenerate these modules to resolve the differences, or synthesize them independently.}}  -suppress 
set_msg_config  -id {Synth 8-2537}  -string {{ERROR: [Synth 8-2537] port pwm_gpio_1 is not defined [C:/Xilinx/Projects/pat_testharness-pwm/pat_testharness-pwm.srcs/sources_1/imports/hdl/design_1_wrapper.v:92]}}  -suppress 
set_msg_config  -id {Synth 8-2537}  -string {{ERROR: [Synth 8-2537] port pwm_gpio_2 is not defined [C:/Xilinx/Projects/pat_testharness-pwm/pat_testharness-pwm.srcs/sources_1/imports/hdl/design_1_wrapper.v:93]}}  -suppress 
set_msg_config  -id {Synth 8-2537}  -string {{ERROR: [Synth 8-2537] port pwm_high is not defined [C:/Xilinx/Projects/pat_testharness-pwm/pat_testharness-pwm.srcs/sources_1/imports/hdl/design_1_wrapper.v:94]}}  -suppress 
set_msg_config  -id {Synth 8-2537}  -string {{ERROR: [Synth 8-2537] port pwm_low is not defined [C:/Xilinx/Projects/pat_testharness-pwm/pat_testharness-pwm.srcs/sources_1/imports/hdl/design_1_wrapper.v:97]}}  -suppress 
set_msg_config  -id {Common 17-69}  -string {{ERROR: [Common 17-69] Command failed: Synthesis failed - please see the console or run log file for details}}  -suppress 
set_msg_config  -id {Coretcl 2-1279}  -string {{CRITICAL WARNING: [Coretcl 2-1279] The upgrade of IP instance 'design_1_util_ds_buf_0_3' has identified issues that may require user intervention. Please review the upgrade log 'c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_util_ds_buf_0_3/design_1_util_ds_buf_0_3.upgrade_log', and verify that the upgraded IP is correctly configured.}}  -suppress 
set_msg_config  -id {IP_Flow 19-3298}  -string {{CRITICAL WARNING: [IP_Flow 19-3298] Detected external port differences while upgrading IP 'design_1_util_ds_buf_0_0'. These changes may impact your design.}}  -suppress 
set_msg_config  -id {IP_Flow 19-3298}  -string {{CRITICAL WARNING: [IP_Flow 19-3298] Detected external port differences while upgrading IP 'design_1_util_ds_buf_0_3'. These changes may impact your design.}}  -suppress 
set_msg_config  -id {Coretcl 2-1279}  -string {{CRITICAL WARNING: [Coretcl 2-1279] The upgrade of IP instance 'design_1_util_ds_buf_0_0' has identified issues that may require user intervention. Please review the upgrade log 'c:/Xilinx/Projects/git-pat_testharness/src/design_1/ip/design_1_util_ds_buf_0_0/design_1_util_ds_buf_0_0.upgrade_log', and verify that the upgraded IP is correctly configured.}}  -suppress 

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.2 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.cache/wt [current_project]
  set_property parent.project_path C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.xpr [current_project]
  set_property ip_repo_paths {
  c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.cache/ip
  C:/Xilinx/Projects/pat_testharness-testsocket.xpr/pat_testharness-testsocket/pat_testharness-testsocket.ipdefs/ip_clock_selector
  C:/Xilinx/Projects/pat_testharness-testsocket.xpr/pat_testharness-testsocket/pat_testharness-testsocket.ipdefs/ip_clock_measure
} [current_project]
  set_property ip_output_repo c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.cache/ip [current_project]
  add_files -quiet C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.runs/synth_1/design_1_wrapper.dcp
  read_xdc -ref design_1_processing_system7_0_0 -cells inst c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_0_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_0_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_rst_processing_system7_0_100M_0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref design_1_rst_processing_system7_0_100M_0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_iic_0_0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_iic_0_0/design_1_axi_iic_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_iic_0_0/design_1_axi_iic_0_0_board.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_modes_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_modes_0_1/design_1_axi_gpio_modes_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_modes_0_1/design_1_axi_gpio_modes_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_modes_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_modes_0_1/design_1_axi_gpio_modes_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_modes_0_1/design_1_axi_gpio_modes_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_dac_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_dac_0_1/design_1_axi_gpio_dac_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_dac_0_1/design_1_axi_gpio_dac_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_dac_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_dac_0_1/design_1_axi_gpio_dac_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_dac_0_1/design_1_axi_gpio_dac_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_abpins_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_abpins_0_1/design_1_axi_gpio_abpins_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_abpins_0_1/design_1_axi_gpio_abpins_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_abpins_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_abpins_0_1/design_1_axi_gpio_abpins_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_abpins_0_1/design_1_axi_gpio_abpins_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_pwm_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_pwm_0_1/design_1_axi_gpio_pwm_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_pwm_0_1/design_1_axi_gpio_pwm_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_pwm_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_pwm_0_1/design_1_axi_gpio_pwm_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_pwm_0_1/design_1_axi_gpio_pwm_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_gpio_clock_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_clock_0_1/design_1_axi_gpio_clock_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_clock_0_1/design_1_axi_gpio_clock_0_board.xdc]
  read_xdc -ref design_1_axi_gpio_clock_0 -cells U0 c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_clock_0_1/design_1_axi_gpio_clock_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_clock_0_1/design_1_axi_gpio_clock_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_clk_pat_0 -cells inst c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0_board.xdc]
  read_xdc -ref design_1_clk_pat_0 -cells inst c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0.xdc]
  read_xdc C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/constrs_1/imports/constraints/pat_testharness-constraints-fmc.xdc
  read_xdc -ref design_1_clk_pat_0 -cells inst c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0_late.xdc
  set_property processing_order LATE [get_files c:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.srcs/sources_1/bd/design_1/ip/design_1_clk_pat_0_1/design_1_clk_pat_0_late.xdc]
  link_design -top design_1_wrapper -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force design_1_wrapper_opt.dcp
  catch {report_drc -file design_1_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force design_1_wrapper_placed.dcp
  catch { report_io -file design_1_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file design_1_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file design_1_wrapper_utilization_placed.rpt -pb design_1_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file design_1_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force design_1_wrapper_routed.dcp
  catch { report_drc -file design_1_wrapper_drc_routed.rpt -pb design_1_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file design_1_wrapper_timing_summary_routed.rpt -rpx design_1_wrapper_timing_summary_routed.rpx }
  catch { report_power -file design_1_wrapper_power_routed.rpt -pb design_1_wrapper_power_summary_routed.pb }
  catch { report_route_status -file design_1_wrapper_route_status.rpt -pb design_1_wrapper_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force design_1_wrapper.bit 
  if { [file exists C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.runs/synth_1/design_1_wrapper.hwdef] } {
    catch { write_sysdef -hwdef C:/Xilinx/Projects/June/pat_testharness_fmc/pat_testharness_fmc.runs/synth_1/design_1_wrapper.hwdef -bitfile design_1_wrapper.bit -meminfo design_1_wrapper.mmi -file design_1_wrapper.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

