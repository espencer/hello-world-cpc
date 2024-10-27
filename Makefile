

SRC = src
BUILD = build

ASMFILES := $(wildcard src/*.s) 
ASMOBJS := $(subst $(SRC), $(BUILD), $(patsubst %.s, %.rel, $(ASMFILES)))
CFILES := $(wildcard src/*.c) 

all: main

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.rel: $(SRC)/%.s $(BUILD)
	sdasz80 -o $@ $<

asm: $(ASMOBJS)

main: asm
	sdcc -mz80 --code-loc 0x0138 --data-loc 0 --no-std-crt0 \
		$(ASMOBJS) \
		src/hello.c \
		-o build/hello

clean:
	rm -fR $(BUILD)

