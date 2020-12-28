module Card = {
    @bs.module("../../node_modules/reactstrap/lib/Card.js")
    @react.component
    external make: (~children: React.element=?) => React.element = "default"
}

module CardImg = {
    @bs.module("../../node_modules/reactstrap/lib/CardImg.js")
    @react.component
    external make: (
        ~top: bool,
        ~width: string=?,
        ~src: string=?,
        ~alt: string=?) => React.element = "default"
}

module CardBody = {
    @bs.module("../../node_modules/reactstrap/lib/CardBody.js")
    @react.component
    external make: (~children: React.element=?) => React.element = "default"
}

module CardTitle = {
    @bs.module("../../node_modules/reactstrap/lib/CardTitle.js")
    @react.component
    external make: (
        ~tag: string=?,
        ~children: React.element=?) => React.element = "default"
}

module CardSubtitle = {
    @bs.module("../../node_modules/reactstrap/lib/CardSubtitle.js")
    @react.component
    external make: (
        ~tag: string=?,
        ~className: string=?,
        ~children: React.element=?) => React.element = "default"
}

module CardText = {
    @bs.module("../../node_modules/reactstrap/lib/CardSubtitle.js")
    @react.component
    external make: (~children: React.element=?) => React.element = "default"
}
