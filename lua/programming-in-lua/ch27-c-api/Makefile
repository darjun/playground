CC=gcc
CFLAGS=-I/usr/local/include
LDFLAGS=-L/usr/local/lib -llua -lm -ldl

all: standalone stack-dump 27.2

STANDALONE_OBJECTS=standalone.o
standalone: $(STANDALONE_OBJECTS)
	$(CC) $(CFLAGS) $(STANDALONE_OBJECTS) -o standalone $(LDFLAGS)

STACK_DUMP_OBJECTS=stack-dump.c
stack-dump: $(STACK_DUMP_OBJECTS)
	$(CC) $(CFLAGS) $(STACK_DUMP_OBJECTS) -o stack-dump $(LDFLAGS)

27_2_OBJECTS=ex/27.2-3.o
27.2: $(27_2_OBJECTS)
	$(CC) $(CFLAGS) $(27_2_OBJECTS) -o 27.2 $(LDFLAGS)