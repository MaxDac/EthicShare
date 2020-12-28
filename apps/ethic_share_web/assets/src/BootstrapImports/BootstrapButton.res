module Button = {
    @bs.module("../../node_modules/reactstrap/lib/Button.js")
    @react.component
    external make: (
        ~className: string=?,
        ~color: string=?,
        ~onClick: () => unit=?,
        ~size: string=?, 
        ~active: bool=?,
        ~disabled: bool=?,
        ~\"type": string=?,
        ~children: React.element=?) => React.element = "default"
}