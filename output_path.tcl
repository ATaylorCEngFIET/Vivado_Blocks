
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axis_subset_converter:*\
xilinx.com:ip:clk_wiz:*\
xilinx.com:ip:ila:*\
digilentinc.com:ip:rgb2dvi:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:v_axi4s_vid_out:*\
xilinx.com:ip:v_tc:*\
xilinx.com:ip:xlconstant:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: output_block
proc create_hier_cell_output_block { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_output_block() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_LITE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS

  create_bd_intf_pin -mode Master -vlnv digilentinc.com:interface:tmds_rtl:1.0 TMDS_0


  # Create pins
  create_bd_pin -dir I -type clk AXIS_Lite_and_Stream_Clk
  create_bd_pin -dir I -type rst aresetn_axis
  create_bd_pin -dir I -type clk clk_100MHz
  create_bd_pin -dir I -type rst resetn

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {3} \
   CONFIG.S_TDATA_NUM_BYTES {3} \
   CONFIG.TDATA_REMAP {tdata[15:8],tdata[23:16],tdata[7:0]} \
 ] $axis_subset_converter_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {251.929} \
   CONFIG.CLKOUT1_PHASE_ERROR {245.344} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {74.25} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {37.125} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.500} \
   CONFIG.MMCM_DIVCLK_DIVIDE {2} \
   CONFIG.RESET_PORT {resetn} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_0

  # Create instance: ila_1, and set properties
  set ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila ila_1 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {6} \
   CONFIG.C_PROBE4_WIDTH {13} \
   CONFIG.C_PROBE5_WIDTH {32} \
 ] $ila_1

  # Create instance: rgb2dvi_0, and set properties
  set rgb2dvi_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2dvi rgb2dvi_0 ]
  set_property -dict [ list \
   CONFIG.kRstActiveHigh {false} \
 ] $rgb2dvi_0

  # Create instance: rst_ps8_0_100M1, and set properties
  set rst_ps8_0_100M1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_ps8_0_100M1 ]

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out v_axi4s_vid_out_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {12} \
   CONFIG.C_HAS_ASYNC_CLK {1} \
   CONFIG.C_NATIVE_COMPONENT_WIDTH {8} \
   CONFIG.C_S_AXIS_VIDEO_DATA_WIDTH {8} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
  set_property -dict [ list \
   CONFIG.GEN_F0_VBLANK_HEND {640} \
   CONFIG.GEN_F0_VBLANK_HSTART {640} \
   CONFIG.GEN_F0_VSYNC_HEND {695} \
   CONFIG.GEN_F0_VSYNC_HSTART {640} \
   CONFIG.GEN_F1_VBLANK_HEND {640} \
   CONFIG.GEN_F1_VBLANK_HSTART {640} \
   CONFIG.GEN_F1_VSYNC_HEND {695} \
   CONFIG.GEN_F1_VSYNC_HSTART {695} \
   CONFIG.enable_detection {false} \
   CONFIG.enable_generation {true} \
 ] $v_tc_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins TMDS_0] [get_bd_intf_pins rgb2dvi_0/TMDS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins AXI_LITE] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins AXIS_Lite_and_Stream_Clk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn_axis] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins rgb2dvi_0/aRst_n] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_tc_0/resetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net clk_1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins ila_1/clk] [get_bd_pins rgb2dvi_0/PixelClk] [get_bd_pins rst_ps8_0_100M1/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net clk_in1_1 [get_bd_pins clk_100MHz] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_ps8_0_100M1/dcm_locked]
  connect_bd_net -net resetn_1 [get_bd_pins resetn] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins rst_ps8_0_100M1/ext_reset_in]
  connect_bd_net -net rst_ps8_0_100M1_peripheral_reset [get_bd_pins rst_ps8_0_100M1/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
  connect_bd_net -net v_axi4s_vid_out_0_fifo_read_level [get_bd_pins ila_1/probe4] [get_bd_pins v_axi4s_vid_out_0/fifo_read_level]
  connect_bd_net -net v_axi4s_vid_out_0_locked [get_bd_pins ila_1/probe1] [get_bd_pins v_axi4s_vid_out_0/locked]
  connect_bd_net -net v_axi4s_vid_out_0_overflow [get_bd_pins ila_1/probe2] [get_bd_pins v_axi4s_vid_out_0/overflow]
  connect_bd_net -net v_axi4s_vid_out_0_status [get_bd_pins ila_1/probe5] [get_bd_pins v_axi4s_vid_out_0/status]
  connect_bd_net -net v_axi4s_vid_out_0_underflow [get_bd_pins ila_1/probe3] [get_bd_pins v_axi4s_vid_out_0/underflow]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video [get_bd_pins rgb2dvi_0/vid_pVDE] [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_pins rgb2dvi_0/vid_pData] [get_bd_pins v_axi4s_vid_out_0/vid_data]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_pins rgb2dvi_0/vid_pHSync] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_pins rgb2dvi_0/vid_pVSync] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins ila_1/probe0] [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net vid_io_out_ce_1 [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/s_axi_aclken] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


proc available_tcl_procs { } {
   puts "##################################################################"
   puts "# Available Tcl procedures to recreate hierarchical blocks:"
   puts "#"
   puts "#    create_hier_cell_output_block parentCell nameHier"
   puts "#"
   puts "##################################################################"
}

available_tcl_procs
