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
    
    rs >= Point.distance p1 p2
;;
 
  let collide_with_any_of p plist =
    List.exists (collide p) plist;;
  
end
