CC = gcc
CFLAGS = -Wall -g

doc: doc.o client.o

client: client.o doc.h

doc.o: doc.c doc.h

clean:
	rm -f *.o doc docs.txt

	
