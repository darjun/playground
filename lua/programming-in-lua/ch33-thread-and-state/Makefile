CC=gcc
CFLAGS=-I/usr/local/include -c -fPIC
LDFLAGS=-L/usr/local/lib -llua -lm -ldl -lpthread

all: lproc.so

lproc.o: lproc.c
	$(CC) $(CFLAGS) lproc.c -o lproc.o

lproc.so: lproc.o
	$(CC) lproc.o -shared -o lproc.so $(LDFLAGS)
