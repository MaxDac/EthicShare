open EthicShareBase.BaseTypes
open EthicShareBase.Fetch

type post = {
    id: int,
    tags: option<array<string>>,
    title: string,
    text: option<string>
}

let getPosts: () => Js.Promise.t<apiResponse<array<post>>> =
    () => fetch(Get(`/api/posts`))
