###########################
# Simple modelsim do file #
###########################

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog led_driver.v led_driver_tb.v

# Open testbench module for simulation

vsim work.led_driver_tb

# Add all testbench signals to waveform diagr_am

add wave /led_driver_tb/*

onbreak resume

# Run simulation
run -all

wave zoom full
