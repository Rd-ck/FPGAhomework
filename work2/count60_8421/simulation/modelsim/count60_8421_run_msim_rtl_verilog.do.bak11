transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/verilog/study/work2/count60_8421 {G:/verilog/study/work2/count60_8421/count60_8421.v}
vlog -vlog01compat -work work +incdir+G:/verilog/study/work2/count60_8421 {G:/verilog/study/work2/count60_8421/count8421.v}

vlog -vlog01compat -work work +incdir+G:/verilog/study/work2/count60_8421/simulation/modelsim {G:/verilog/study/work2/count60_8421/simulation/modelsim/count60_8421.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  count60_8421_vlg_tst

add wave *
view structure
view signals
run -all
