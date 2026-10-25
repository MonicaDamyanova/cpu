# Default testbench
TB ?= tb_cpu

# RTL sources (packages must come first)
PKG = rtl/cpu_defs.sv
RTL = $(PKG) $(filter-out $(PKG),$(wildcard rtl/*.sv))

# Testbench source
TB_FILE = testbench/$(TB).sv

# Build directory and executable
BUILD_DIR = build/$(TB)
BIN = $(BUILD_DIR)/V$(TB)

# Default target
all: run

# Compile
$(BIN): $(RTL) $(TB_FILE) Makefile
	verilator --binary --timing --trace-vcd \
		--top-module $(TB) \
		--Mdir $(BUILD_DIR) \
		$(RTL) $(TB_FILE)

# Run simulation
run: $(BIN)
	./$(BIN)

# Lint
lint:
	verilator --lint-only --timing \
		--top-module $(TB) \
		$(RTL) $(TB_FILE)

# Run an individual testbench
test_%:
	$(MAKE) run TB=tb_$*

# Discover all testbenches
TESTS = $(patsubst tb/tb_%.sv,%,$(wildcard tb/tb_*.sv))

# Run every testbench
test_all:
	@set -e; for test in $(TESTS); do \
		$(MAKE) run TB=tb_$$test; \
	done

# Clean generated files
clean:
	rm -rf build && mkdir build

.PHONY: all run lint test_all clean
