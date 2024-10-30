

PRG = hello
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

$(BUILD)/$(PRG): $(SRC)/$(PRG).c $(ASMOBJS)
	sdcc -mz80 --code-loc 0x0138 --data-loc 0 --no-std-crt0 \
		$(ASMOBJS) \
		$(SRC)/$(PRG).c \
		-o $(BUILD)/$(PRG)

main: $(BUILD)/$(PRG) 

format: format-c format-asm

format-c: $(CFILES)
	for f in $(CFILES) ; do \
		clang-format -i $$f ; \
	done

format-asm: $(ASMFILES)
	for f in $(ASMFILES) ; do \
		cat $$f \
		| sed 's/;;/\/\//g' \
		| asmfmt \
		| sed 's/\/\//;;/g' \
		| sed 's/^\t/  /g'\
		> $$f.tmp ; \
		mv -f $$f.tmp $$f ; \
	done

clean:
	rm -fR $(BUILD)

