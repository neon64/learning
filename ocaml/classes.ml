open Format

class stack_of_ints = object (self)
    val mutable the_list = ( [] : int list ) (* instance variable *)
    method push x = (* push method *)
        the_list <- x :: the_list
    method pop = (* pop method *)
        let result = List.hd the_list in
        the_list <- List.tl the_list;
        result
    method peek = (* peek method *)
        List.hd the_list
    method size = List.length the_list
end;;

let s = new stack_of_ints;;

for i = 1 to 10 do
    s#push (i*i)
done;;

printf "%d" s#size;;