open BaseTypes

type pageState<'t> =
    | PageLoading
    | PageLoaded('t)
    | PageWithError(array<string>)

module type PageStateItem = {
    type t

    let rehidrate: () => Js.Promise.t<apiResponse<t>>
}

module PageStateManager = (Item: PageStateItem) => {
    type tStateGetter = pageState<Item.t>

    type tStateSetter = (pageState<Item.t> => pageState<Item.t>) => unit

    type tUseEffectDelegate = option<unit => unit>

    let defaultPageState: () => pageState<Item.t> = () => PageLoading

    let usePageState: unit => (tStateGetter, tStateSetter) = () => React.useState(defaultPageState)

    let effectDelegate: tStateSetter => tUseEffectDelegate = setter =>{
        Item.rehidrate()
        |> Js.Promise.then_(el => {
            Js.log(el)

            switch el {
            | Ok(posts) => setter(_ => PageLoaded(posts))
            | Error(e) => setter(_ => PageWithError(e))
            }

            Js.Promise.resolve()
        })
        |> Js.Promise.catch(error => {
            Js.log(error)
            setter(_ => PageWithError([]))
            Js.Promise.resolve()
        })
        |> ignore

        None
    }
}