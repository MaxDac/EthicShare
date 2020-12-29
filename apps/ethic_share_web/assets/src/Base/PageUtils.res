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

    let effectDelegate: tStateSetter => tUseEffectDelegate = setter => {
        Fetch.manageApiResponse(
            Item.rehidrate, 
            posts => setter(_ => PageLoaded(posts)),
            e => setter(_ => PageWithError(e)))

        None
    }
}
