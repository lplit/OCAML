module Circle = struct 
  open Geometry;;
  type t = {
    r:float ; 
    v:float ;
    cen:Point.t }

  let create r v cen = {
    r=r;
    v=v;
    cen=cen }

  let move v circle = {
    cen = Point.move v circle.cen ; 
    r = circle.r ; 
    v = circle.v }

  let collide cira cirb = 
    let rs = cira.r +. cirb.r in 
    let p1 = cira.cen in 
    let p2 = cirb.cen in 
    
    rs >= Point.distance p1 p2 then 
;;
 
  let collide_with_any_of p plist =
    List.exists (collide p) plist;;
  
end

(* 
==========================================================================

What's the difference between {} in functions and just defining it usually
{} = constructors?
How to open/reference a module?

compiler output: 
ocamlc -c geometry.ml boundingBox.ml 
File "boundingBox.ml", line 14, characters 10-20:
Error: Unbound module Point

En compilant separement geometry d'abord puis boindingBox, j'arrive a compiler, mais le linking fail quand j'essaye de creer l'executable.
Je dois ajouter open Geometry au debut du bindingBox, sinon il compile pas (erreur ^), une fois compile le compilateur link pas, crache "Error: Error while linking boundingBox.cmo:
Reference to undefined global `Geometry' "



jeremie.salvucci@lip6.fr

*)
