open BaseTypes

type post = {
    id: int,
    tags: option<array<string>>,
    title: string,
    text: option<string>
}

let getPosts: () => Js.Promise.t<apiResponse<array<post>>> =
    () => Fetch.fetch(Get(`/api/posts`))
