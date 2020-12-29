open BaseTypes

let fetch: fetchRequest<'t> => Js.Promise.t<apiResponse<'q>>

let getEnvironmentVariable: (string) => option<string>

let manageApiResponse: ((() => Js.Promise.t<apiResponse<'q>>), 'q => unit, apiError => unit) => unit
