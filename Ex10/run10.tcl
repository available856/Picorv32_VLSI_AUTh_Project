set_db init_lib_search_path /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/
set_db script_search_path /home/n/nikolaoac/Desktop/Scripts/
set_db init_hdl_search_path /home/n/nikolaoac/Desktop/HDL/
set_db library ./timing/slow_vdd1v0_basicCells.lib
set_db lef_library {./lef/gsclib045_tech.lef ./lef/gsclib045_macro.lef }
read_qrc ./qrc/qx/gpdk045.tch
set_db design_power_effort high
set_db opt_leakage_to_dynamic_ratio 0.0
read_hdl picorv32.v
set_db lp_insert_clock_gating true
elaborate "picorv32"
check_design -all > /home/n/nikolaoac/Desktop/Check/Check_Design
create_clock [get_ports clk] -name clk -period 5 -waveform {0 2.5}
set_clock_latency -source 0.25 [get_clocks clk]
set_clock_uncertainty -setup 0.015 [get_clocks clk]
set_clock_uncertainty -hold 0.01 [get_clocks clk]
set_clock_transition 0.05 [get_clocks clk]
set_output_delay -max 0.75 -clock clk -network_latency_included [all_outputs]
set_output_delay -min 0.25 -clock clk -network_latency_included [all_outputs]
set_load 0.4 -max [all_outputs]
set_load 0.05 -min [all_outputs]
set_input_delay -max 0.75 -clock clk -network_latency_included [all_inputs]
set_input_delay -min 0.25 -clock clk -network_latency_included [all_inputs]
set_driving_cell -max -lib_cell BUFX4 [all_inputs]
set_driving_cell -min -lib_cell BUFX8 [all_inputs]
read_sdc Constraints10.sdc
check_timing_intent > /home/n/nikolaoac/Desktop/Check/Check_Time_Intent
set_db / .use_scan_seqs_for_non_dft false
syn_generic
syn_map
syn_opt
report_area > /home/n/nikolaoac/Desktop/Reports/Ex10_1/Area
report_power > /home/n/nikolaoac/Desktop/Reports/Ex10_1s/Power
report_gates > /home/n/nikolaoac/Desktop/Reports/Ex10_1/Gates
report_timing > /home/n/nikolaoac/Desktop/Reports/Ex10_1/Timing
report_qor > /home/n/nikolaoac/Desktop/Reports/Ex10_1/QoR
report_clock_gating > /home/n/nikolaoac/Desktop/Reports/Ex10_1/Clock_Gating
write_hdl > home/n/nikolaoac/Desktop/Exports_Ex10/design.v
write_sdc > home/n/nikolaoac/Desktop/Exports_Ex10/constraints.sdc
write_script > home/n/nikolaoac/Desktop/Exports_Ex10/constraints.g
write_design -innovus picorv32
