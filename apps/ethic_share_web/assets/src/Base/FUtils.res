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
    |> fold_left(f, init)
}

let filter: ('t => bool, list<'t>) => list<'t> = (f, lss) => {
    let filter_reducer: ('t, list<'t>) => list<'t> = (element: 't, ls: list<'t>) => {
        switch f(element) {
        | true => list{element, ...ls}
        | false => ls
        }
    }

    let ret: list<'t> = fold_right(filter_reducer, list{}, lss)

    
}