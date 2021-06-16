onerror {quit -f}
vlib work
vlog -work work delta.vo
vlog -work work delta.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.delta_vlg_vec_tst
vcd file -direction delta.msim.vcd
vcd add -internal delta_vlg_vec_tst/*
vcd add -internal delta_vlg_vec_tst/i1/*
add wave /*
run -all
