open BaseTypes

%%raw(`
    const getFetchWrapper = function (url) {
        return fetch(url).then(res => res.json());
    }

    const genericFetchWrapper = function (url, method, body) {
        return fetch(url, { 
            method: method,
            body: JSON.string(body),
            headers: { "Content-Type": "application/json; charset=UTF-8" }
        }).then(res => res.json());
    }

    const getEnvVar = function (envName) {
        return process.env[envName];
    }
`)

type fetchApiResponse<'t> = {
    data: option<'t>,
    error: option<string>,
    errorList: option<array<string>>
}

@bs.val
external getFetch: string => Js.Promise.t<fetchApiResponse<'t>> = "getFetchWrapper"

@bs.val
external genericFetch: (string, string, 't) => Js.Promise.t<fetchApiResponse<'q>> = "genericFetchWrapper"

@bs.val
external getEnvironmentVariable: (string) => option<string> = "getEnvVar"

let fetch: fetchRequest<'t> => Js.Promise.t<apiResponse<'q>> = req => {
    let tryGetError: fetchApiResponse<'q> => apiResponse<'q> = res =>
        switch res.error {
        | None => 
            switch res.errorList {
            | None => Error(["Generic error."])
            | Some(ls) => Error(ls)
            }
        | Some(e) => Error([e])
        }

    let response: Js.Promise.t<fetchApiResponse<'q>> =
        switch req {
        | Get(url) => getFetch(url)
        | Post(url, body) => genericFetch(url, "POST", body)
        }

    response
    |> Js.Promise.then_(r => {
        let returnValue = 
            switch r.data {
            | None => tryGetError(r)
            | Some(value) => Ok(value)
            }

        Js.Promise.resolve(returnValue)
    })
}
