# Hello World

Simple CPC program, copied from http://www.cpcmania.com/Docs/Programming/Introduction_to_programming_in_SDCC_Compiling_and_testing_a_Hello_World.htm

## Setup

Download dependencies for compiling:

```sh
brew install sdcc
```

## Compile

```sh
sdasz80 -o crt0.s
sdasz80 -o putchar.s
sdcc -mz80 --code-loc 0x0138 --data-loc 0 --no-std-crt0 crt0.rel putchar.rel hello.c
```
