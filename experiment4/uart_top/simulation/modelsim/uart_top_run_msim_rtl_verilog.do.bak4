transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/verilog/study/experiment4/uart_top {G:/verilog/study/experiment4/uart_top/uart_top.v}
vlog -vlog01compat -work work +incdir+G:/verilog/study/experiment4/uart_top {G:/verilog/study/experiment4/uart_top/uart_tx.v}
vlog -vlog01compat -work work +incdir+G:/verilog/study/experiment4/uart_top {G:/verilog/study/experiment4/uart_top/uart_rx.v}

vlog -vlog01compat -work work +incdir+G:/verilog/study/experiment4/uart_top/simulation/modelsim {G:/verilog/study/experiment4/uart_top/simulation/modelsim/uart_top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_top_tb

add wave *
view structure
view signals
run -all
