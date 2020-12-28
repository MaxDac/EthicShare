type apiError = array<string>

type apiResponse<'t> =
    | Ok('t)
    | Error(apiError)

type fetchRequest<'t> = 
    | Get(string)
    | Post(string, apiResponse<'t>)

let emptyElement: React.element = <></>

let identity: 't => 't = c => c

let showOrNull: (option<'t>, ('t => React.element)) => React.element = (value, del) =>
    value 
    |> Option.map(del)
    |> Option.getOrElse(emptyElement)
