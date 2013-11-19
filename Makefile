CC=ocamlc
CFLAGS= -c
EXEC=Pewpew
SRC=$(wildcard *.ml)
HDRS=$(SRC: .ml=.mli)

all : $(EXEC)

$(EXEC) : $(SRC)