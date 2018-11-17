type 'a t = ('a, ErrorCodes.t) Pervasives.result

let get res =
    match res with
    | Ok a -> a
    | Error b -> failwith b

let (||>) result fct =
  match result with
  | Ok a -> fct a
  | Error b -> Error b