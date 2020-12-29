open BaseTypes

type loginRequest = {
    username: string,
    password: string
}

type user = {
    username: string,
    email: string,
    avatar: string,
    description: string
}

let performLogin: loginRequest => Js.Promise.t<apiResponse<user>> =
    req => Fetch.fetch(Post(`/api/authenticate`, req))
