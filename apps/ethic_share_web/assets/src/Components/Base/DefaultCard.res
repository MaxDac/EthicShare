open BaseTypes
open BootstrapCard

@@warning("-27")

@react.component
let make = (
    ~title: string,
    ~text: string,
    ~subtitle: option<string>=?,
    ~width: option<string>=?,
    ~children: option<React.element>=?
) =>
    <Card>
        <CardBody>
            <CardTitle tag="h5">{React.string(title)}</CardTitle>
            {showOrNull(subtitle, sub => <CardSubtitle tag="h6" className="mb-2 text-muted">{React.string(sub)}</CardSubtitle>)}
            <CardText>{React.string("Some quick example text to build on the card title and make up the bulk of the card's content.")}</CardText>
            {showOrNull(children, identity)}
        </CardBody>
    </Card>
