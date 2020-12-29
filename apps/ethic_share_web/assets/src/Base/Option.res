let map = (mapDelegate, element) =>
    switch element {
    | None => None
    | Some(v) => Some(mapDelegate(v))
    }

let get: (option<'t>) => 't = t =>
    switch t {
    | None => Js.Exn.raiseError("The object does not exist")
    | Some(v) => v
    }

let getOrElse = (default, value) =>
    switch value {
    | None => default
    | Some(v) => v
    }

let noneIfEmpty: string => option<string> = s =>
    switch s {
    | "" => None
    | v => Some(v)
    }