open BaseTypes

let fetch: fetchRequest<'t> => Js.Promise.t<apiResponse<'q>>

let getEnvironmentVariable: (string) => option<string>
