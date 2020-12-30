open BaseTypes
open PageUtils
open BootstrapImports
open BootstrapCard
open PostsService

@react.component
let make = () => {
    module PostsStateManager = PageStateManager({
        type t = array<post>

        let rehidrate = getPosts
    })

    let (posts, setPosts) = PostsStateManager.usePageState()
    
    React.useEffect0(() => PostsStateManager.effectDelegate(setPosts))

    let postToElement: post => React.element = p => 
        <DefaultCard title={p.title} text={p.text |> Option.getOrElse("")} />

    let postsToElement: array<post> => React.element = ps =>
        <div>
            {React.array(ps |> Array.map(postToElement))}
        </div>

    <div className="default-container">
        <div>{React.string("this is the first text")}</div>
        <div>
            <Button 
                color="primary" 
                onClick={() => Js.log("Test")}
                active={true}>
                    {React.string("Primary link")}
            </Button>
        </div>
        <div>
            {switch posts {
            | PageLoading => React.string("Waiting")
            | PageLoaded(ps) =>
                Js.log(ps)
                postsToElement(ps)
            | PageWithError(e) =>
                Js.log(e)
                React.string("Page with error")
            }}
        </div>
    </div>
}
