transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {adder8_8_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+G:/verilog/adder8/simulation/activehdl {G:/verilog/adder8/simulation/activehdl/adder8.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  adder8_vlg_tst

add wave *
view structure
view signals
run -all
