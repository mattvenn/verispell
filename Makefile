# SPDX-FileCopyrightText: © 2021 Uri Shaked <uri@wokwi.com>
# SPDX-License-Identifier: MIT

all: test_spell

test_execute:
	iverilog -g2012 -I src -o execute_tb.out test/execute_tb.v src/execute.v
	./execute_tb.out
	gtkwave execute_tb.vcd test/execute_tb.gtkw

test_mem_dff:
	iverilog -g2012 -I src -o mem_dff_tb.out test/mem_dff_tb.v src/mem_dff.v
	./mem_dff_tb.out
	gtkwave mem_dff_tb.vcd test/mem_dff_tb.gtkw

test_spell:
	iverilog -g2012 -I src -s spell -s dump -o spell_test.out src/spell.v src/mem_dff.v src/execute.v test/dump_spell.v
	MODULE=test.test_spell vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus ./spell_test.out
	gtkwave spell_test.vcd test/spell_test.gtkw

format:
	verible-verilog-format --inplace src/*.v test/*.v
