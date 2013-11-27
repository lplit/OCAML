# Files
SRC=geometry.ml boundingBox.ml events.ml graphics.ml game.ml
OBJ=$(SRC:.ml=.cmo)
EXEC=Pewpew

# Compilers
CAMLC=ocamlfind ocamlc
PKG=sdl,sdl.sdlimage,sdl.sdlttf

# Rules
all : $(EXEC)
	@echo Compiling the executable \"$(EXEC)\"...
	@if test -f $(EXEC) ; then echo Success!; else echo Something went wrong...; fi

$(EXEC) : $(OBJ)
	@echo Linking...
	$(CAMLC) -package $(PKG) -linkpkg -o $@ $^

$(OBJ) : $(SRC)
	@echo Compiling sources...
	$(CAMLC) -package $(PKG) -c $?

graphics.cmi : graphics.mli
	$(CAMLC) -package $(PKG) -c $<

graphics.mli : graphics.ml
	$(OCAMLC) -i graphics.mli

clean :
	@echo Cleaning...
	@rm -f $(OBJ) $(EXEC)
	@echo Done.

info : 
	@echo "Sources : $(SRC)"
	@echo "Objects : $(OBJ)" 
	@echo "Exec    : $(EXEC)"

.PHONY : all clean info


# ocamlfind ocamlc -c geometry.ml
# ocamlfind ocamlc -c boundingBox.ml
# ocamlfind ocamlc -package sdl -c events.ml
# ocamlfind ocamlc -package sdl -c graphics.mli
# ocamlfind ocamlc -package sdl,sdl.sdlimage,sdl.sdlttf -c graphics.ml
# ocamlfind ocamlc -package sdl -c game.ml
# ocamlfind ocamlc -package sdl,sdl.sdlimage,sdl.sdlttf -linkpkg -o Pewpew geometry.cmo boundingBox.cmo events.cmo graphics.cmo game.cmo