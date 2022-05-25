transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/verilog/study/count {G:/verilog/study/count/count4.v}

vlog -vlog01compat -work work +incdir+G:/verilog/study/count/simulation/modelsim {G:/verilog/study/count/simulation/modelsim/count4.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  count4_vlg_tst

add wave *
view structure
view signals
run 3 us
