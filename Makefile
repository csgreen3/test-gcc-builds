include makefile.conf

###############################################################################
# Default Settings
PROJECT=e2c
.PHONY: clean
.DEFAULT_GOAL := $(PROJECT).bin
PROC_DIR=proc/$(PROCESSOR)
TERMINAL=gnome-terminal
OBJDUMP_FILE=output.txt
DEFINES=-D__STARTUP_CLEAR_BSS -D__START=main
CORE=CM$(CORTEX_M)
###############################################################################


###############################################################################
# Cross Compiler Settings
TOOLCHAIN=arm-none-eabi-
CFLAGS=$(ARCH_FLAGS) $(DEFINES) $(CPU_DEFINES) $(INCLUDES) -Wall -ffunction-sections -fdata-sections -fno-builtin
# -Os -flto -nostdlib -lnosys

# Linker Settings
LFLAGS=--specs=nosys.specs -Wl,--gc-sections -Wl,-Map=$(PROJECT).map -Tlink.ld
###############################################################################


###############################################################################
# Global Objects
OBJECTS += main.o 

# Conditional Objects
OBJECTS += start.o

###############################################################################


###############################################################################
# Source Rules
%.o: %.S
	$(TOOLCHAIN)gcc $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(TOOLCHAIN)gcc $(CFLAGS) -c -o $@ $<

$(PROJECT).elf: $(OBJECTS)
	$(TOOLCHAIN)gcc $(LFLAGS) $^ $(CFLAGS) -o $@

$(PROJECT).bin: $(PROJECT).elf
	$(TOOLCHAIN)objcopy -O binary $< $@

# Project Rules
$(OBJECTS): | $(CPUDIR)

$(OBJDUMP_FILE): $(PROJECT).bin
	$(TOOLCHAIN)objdump -D $(PROJECT).elf > $(OBJDUMP_FILE)

$(CPUDIR):
	ln -s ../$(PROC_DIR) $@

clean: 
	rm -f *.bin *.map *.elf $(CPUDIR) output.txt
	find . -name '*.o' -delete

install: $(PROJECT).bin
	./$(PROC_DIR)/install.sh

debug: $(PROJECT).bin
	./$(PROC_DIR)/debug.sh

dump: $(OBJDUMP_FILE)
	$(TERMINAL) -e "vim $(OBJDUMP_FILE)"

%_config:
	@echo $@
###############################################################################

