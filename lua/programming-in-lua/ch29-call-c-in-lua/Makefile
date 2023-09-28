CC=gcc
CFLAGS=-I/usr/local/include -c -fPIC
LDFLAGS=-L/usr/local/lib -llua -lm -ldl

all: mylib.so ex.so

mylib.o: mylib.c
	$(CC) $(CFLAGS) mylib.c -o mylib.o

mylib.so: mylib.o
	$(CC) mylib.o -shared -o mylib.so

ex.o: ex/ex.c
	$(CC) $(CFLAGS) ex/ex.c -o ex.o

ex.so: ex.o
	$(CC) ex.o -shared -o ex.so
