open EthicShareBase.BaseTypes
open EthicShareBase.Fetch

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
    req => fetch(Post(`/api/authenticate`, req))
