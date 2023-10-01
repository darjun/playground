CC=gcc
CFLAGS=-I/usr/local/include -c -fPIC
LDFLAGS=-L/usr/local/lib -llua -lm -ldl

all: dir.so lxp

dir.o: dir.c
	$(CC) $(CFLAGS) dir.c -o dir.o

dir.so: dir.o
	$(CC) dir.o -shared -o dir.so $(LDFLAGS)

lxp.o: lxp.c
	$(CC) $(CFLAGS) lxp.c -o lxp.o

lxp.so: lxp.o
	$(CC) lxp.o -shared -o lxp.so $(LDFLAGS)
