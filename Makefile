SRC=geometry.ml boundingBox.ml events.ml
OBJ=$(SRC:.ml=.cmo)
EXEC=Pewpew

CAMLC=ocamlfind ocamlc

all : $(EXEC)
	@echo Compiling the executable \"$(EXEC)\"...
	@if test -f $(EXEC) ; then echo Success!; else echo Something went wrong...; fi

$(EXEC) : $(OBJ)
	@$(CAMLC) -o $@ $^

$(OBJ) : $(SRC)
	@echo Compiling sources... 
	@$(CAMLC) -c $?

clean :
	@echo Cleaning...
	@rm -f *.cmo *.cmi $(EXEC)
	@echo Done.

info : 
	@echo "Sources : $(SRC)"
	@echo "Objects : $(OBJ)" 
	@echo "Exec    : $(EXEC)"

.PHONY : all clean info
