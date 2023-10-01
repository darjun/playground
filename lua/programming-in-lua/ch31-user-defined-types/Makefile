CC=gcc
CFLAGS=-I/usr/local/include -c -fPIC
LDFLAGS=-L/usr/local/lib -llua -lm -ldl

all: array.so array-2.so ex.so

array.o: array.c
	$(CC) $(CFLAGS) array.c -o array.o

array.so: array.o
	$(CC) array.o -shared -o array.so $(LDFLAGS)

array2.o: array2.c
	$(CC) $(CFLAGS) array2.c -o array2.o

array-2.so: array2.o
	$(CC) array2.o -shared -o array-2.so $(LDFLAGS)

ex.o: ex/ex.c
	$(CC) $(CFLAGS) ex/ex.c -o ex.o

ex.so: ex.o
	$(CC) ex.o -shared -o ex.so $(LDFLAGS)
