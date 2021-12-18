create_clock -name clk_3_85mhz -period 260 [get_nets {div_clk|one_hot_cnt[0]}]
create_clock -name clk_2mhz -period 500 [get_nets {div_clk2|one_hot_cnt[0]}]


set_input_delay -clock {clk_3_85mhz} -max 10 [get_ports {KEY[0]}]
set_input_delay -clock {clk_3_85mhz} -min 2 [get_ports {KEY[0]}]
set_output_delay -clock {clk_3_85mhz} -max 10 [get_ports {GPIO_1[0]}]
set_output_delay -clock {clk_3_85mhz} -min 2 [get_ports {GPIO_1[0]}]
set_output_delay -clock {clk_3_85mhz} -max 10 [get_ports {GPIO_1[1] GPIO_1[2]}]
set_output_delay -clock {clk_3_85mhz} -min 2 [get_ports {GPIO_1[1] GPIO_1[2]}]

#set_input_delay -clock {clk_3_85mhz} -max 50 [get_ports {KEY[0]}]
#set_input_delay -clock {clk_3_85mhz} -min 25 [get_ports {KEY[0]}]
#set_output_delay -clock {clk_3_85mhz} -max 50 [get_ports {GPIO_1[0]}]
#set_output_delay -clock {clk_3_85mhz} -min 25 [get_ports {GPIO_1[0]}]
#set_output_delay -clock {clk_3_85mhz} -max 75 [get_ports {GPIO_1[1] GPIO_1[2]}]
#set_output_delay -clock {clk_3_85mhz} -min 25 [get_ports {GPIO_1[1] GPIO_1[2]}]

