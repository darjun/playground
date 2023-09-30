CC=gcc
CFLAGS=-I/usr/local/include -c -fPIC
LDFLAGS=-L/usr/local/lib -llua -lm -ldl

all: tuple.so counter.so ex.so

tuple.o: tuple.c
	$(CC) $(CFLAGS) tuple.c -o tuple.o

tuple.so: tuple.o
	$(CC) tuple.o -shared -o tuple.so $(LDFLAGS)

counter.o: counter.c
	$(CC) $(CFLAGS) counter.c -o counter.o

counter.so: counter.o
	$(CC) counter.o -shared -o counter.so $(LDFLAGS)

ex.o: ex/ex.c
	$(CC) $(CFLAGS) ex/ex.c -o ex.o

ex.so: ex.o
	$(CC) ex.o -shared -o ex.so $(LDFLAGS)
