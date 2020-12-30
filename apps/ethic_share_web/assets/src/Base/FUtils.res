let fold_left: (('a, 'b) => 'b, 'a, list<'b>) => 'a = (f, init, ls) => {
    let rec fold_left_internal = (lls, acc) => {
        switch lls {
        | list{} => acc
        | list{x, ...xs} => fold_left_internal(xs, f(acc, x))
        }
    }

    fold_left_internal(ls, init)
}

let reverse: list<'a> => list<'a> = ls => {
    let rec rev_internal = (acc, lls) =>
        switch lls {
        | list{} => acc
        | list{x, ...xs} => rev_internal(list{x, ...acc}, xs)
        }

    ls |> rev_internal(list{})
}

let fold_right: (('b, 'a) => 'a, 'a, list<'b>) => 'a = (f, init, ls) => {
    let f1 = (a, b) => f(b, a)

    ls
    |> reverse
    |> fold_left(f1, init)
}

let filter: ('t => bool, list<'t>) => list<'t> = (f, lss) => {
    let rec filter_internal = (acc, ls) => 
        switch ls {
        | list{} => acc
        | list{x, ...xs} => 
            switch f(x) {
            | true => filter_internal(list{x, ...acc}, xs)
            | _ => filter_internal(acc, xs)
            }
        }

    lss
    |> filter_internal(list{})
    |> reverse
}

let stringToList: string => list<string> = str => {
    let rec string_to_list: (list<string>, string) => list<string> = (acc, s) =>
    switch s {
    | "" => acc
    | str =>
        string_to_list(
        list{String.sub(str, 0, 1), ...acc},
        String.sub(str, 1, (str |> String.length) - 1),
        )
    }

    string_to_list(list{}, str)
}

let listToString : list<string> => string = ls => {
    let rec list_to_string: (string, list<string>) => string = (acc, lss) => 
        switch lss {
        | list{} => acc
        | list{x, ...xs } =>
            list_to_string(`${acc}${x}`, xs)
        }

    list_to_string("", ls)
}

let getStringTail: string => string = s => String.sub(s, 1, String.length(s) - 1)

let getStringHead: string => string = s => String.sub(s, 0, 1)

let firstCapital: string => string = s => {
    let head = s |> getStringHead |> String.uppercase_ascii
    let tail = s |> getStringTail

    return `${head}${tail}`
}

let camelCaseToNormalCase: string => string = s => {
    let rec transform = (acc, ls) =>
        switch ls {
        | list{} => acc
        | list{c, ...cs} =>
            if (c |> String.uppercase_ascii) == c {
                transform(list{" ", c, ...acc}, cs)
            }
            else {
                transform(list{c, ...acc}, cs)
            }
        }

    s 
    |> stringToList
    |> transform(list{})
    |> listToString
    |> firstCapital
}