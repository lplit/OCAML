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

  let distance a b =
    (a.x -. b.x)**2. +. (a.y -. b.y)**2.;;

end
