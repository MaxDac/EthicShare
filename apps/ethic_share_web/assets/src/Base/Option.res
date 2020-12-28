let map = (mapDelegate, element) =>
    switch element {
    | None => None
    | Some(v) => Some(mapDelegate(v))
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