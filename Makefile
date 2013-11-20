# Compiler
OCAMLC=ocamlc
OCAMLDEP=ocamldep
OCAMLFLAGS= -c
INCLUDES=                 # all relevant -I options here
OCAMLFLAGS=$(INCLUDES)    # add other options for ocamlc here
OCAMLOPTFLAGS=$(INCLUDES) # add other options for ocamlopt here

# Files
EXEC=Pewpew
SRC=$(wildcard *.ml)
OBJ=$(SRC: .ml=.cmo)
HDRS=$(SRC: .ml=.mli)


# Rules
all : $(EXEC)
	@echo Compiling the executable...
	@if test -f $(EXEC); then echo Success!; else echo Something went wrong...; fi	

$(EXEC) : $(OBJ)
	$(OCAMLC) -o $(EXEC) $(OCAMLFLAGS) $(OBJ)

$(OBJ) : $(SRC)
	$(OCAMLC) -c $(SRC)

%.mli : %.ml
	$(OCAMLC) -i $< > $@

clean : 
	@echo Cleaning...
	@rm -f $(EXEC) .depend
	@rm -f *.cm[iox]
	@rm -f *.mli
	@echo Done.

# Common rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx

.mli.ml:
	$(OCAMLC) -i $@ > $<

.ml.cmo:
	$(OCAMLC) $(OCAMLFLAGS) -c $<

.mli.cmi:
	$(OCAMLC) $(OCAMLFLAGS) -c $<

.ml.cmx:
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -c $<

# Dependencies
.depend:
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml > .depend

include .depend

.PHONY : all clean