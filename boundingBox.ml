module Circle = struct 

  type t = {
    r:float ; 
    v:float ;
    cen:Geometry.Point.t }

  let create r v cen = {
    r=r;
    v=v;
    cen=cen; }

  let move v circle = {
    cen = Point.move v cen ; 
    r = circle.r ; 
    v = circle.v
  }
    
  let collide cira cirb = {
    (Point.distc cira.cen cirb.cen) <= (cira.r +. cirb.r) *. (cira.r +. cirb.r)
  }
    
  let collide_with_any_of p plist = {

  }
    
 }

    
end 


(* http://ocamlsdl.sourceforge.net/doc/html/Sdlkey.html *)

(* variable globale dans events let keys = (liste de couples definie a la main (touche sdlkey, bool ref))
(* Deux evenments only - pressed and unpressed 

ocamlfind ocamlc -package sdl -c events.ml
ocamlfind compiler -package list_of_packages -c file_to_compile.ml
