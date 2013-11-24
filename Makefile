# Files
SRC=geometry.ml boundingBox.ml events.ml
OBJ=$(SRC:.ml=.cmo)
EXEC=Pewpew

# Compiles
CAMLC=ocamlfind ocamlc


# Rules
all : $(EXEC)
	@echo Compiling the executable \"$(EXEC)\"...
	@if test -f $(EXEC) ; then echo Success!; else echo Something went wrong...; fi

$(EXEC) : $(OBJ)
	@$(CAMLC) -o $@ $^


$(OBJ) : $(SRC)
	@echo Compiling sources...
	@$(CAMLC) -package sdl -c $?

clean :
	@echo Cleaning...
	@rm -f *.cmo *.cmi $(EXEC)
	@echo Done.

info : 
	@echo "Sources : `ls -x *.ml`"
	@echo "Objects : `ls -x *.cmo`" 
	@echo "Exec    : $(EXEC)"

.PHONY : all clean info
