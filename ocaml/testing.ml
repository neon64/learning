open Format

let rec kth l n = match l with
  | [] -> None
  | x::xs -> if n = 1 then Some x else kth xs (n-1)
;;

let rec findInList l v = match l with
  | [] -> None
  | x::xs -> if x = v then Some x else findInList xs v
;;

match findInList [1; 2; 3; 4; 5] 9 with
  | Some x -> printf "%d" x
  | None -> printf "Not found in list"
;;
