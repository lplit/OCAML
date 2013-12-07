module Circle = struct 
  open Geometry;;
  type t = {
    r:float ; 
    v:float ;
    o:Point.t }

  let create r v o = {
    r=r;
    v=v;
    o=o }
    
    
  let create_cir c = { 
    r = c.r ; 
    v = c.v ; 
    o = c.o }

  let move v circle = {
    o = Point.move v circle.o ; 
    r = circle.r ; 
    v = circle.v }

  let collide cira cirb = 
    let rs = cira.r +. cirb.r in 
    let p1 = cira.o in 
    let p2 = cirb.o in 
    
    rs >= Point.distance p1 p2
;;
 
  let collide_with_any_of p plist =
    List.exists (collide p) plist;;
  
end
