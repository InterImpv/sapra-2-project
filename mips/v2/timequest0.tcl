create_timing_netlist -post_map -model slow -zero_ic_delays
read_sdc
update_timing_netlist
report_clocks -panel_name "Clocks Summary"
report_ucp -panel_name "Unconstrained Paths"
report_sdc -ignored -panel_name "Ignored Constraints"
report_sdc -panel_name "SDC Assignments"
