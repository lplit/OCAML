module Vector = struct 

  type t = { 
    x:float ; 
    y:float }
      
  let create a b = { 
    x=a ; 
    y=b }
  
end 

module Point = struct 
  
  type t = {
    x:float ; 
    y:float }
      
  let create a b = { 
    x=a ;
    y=b }

  let move v p = {
    x = p.x +. v.Vector.x ; 
    y = p.y +. v.Vector.y }
   (*
  let distc a b = {
    ((b.x -. a.x) *. (b.x -. a.x)) +. ((b.y -. a.y) *. (b.y -. a.y))
  }
   *) 
end

(*
ocamlc -c geometry.mli geometry.ml
ocamlc -i geometry.ml > geometry.mli
*)
