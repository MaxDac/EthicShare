module Validator = {
    let container: () => {..} = Js.Obj.empty

    let checkNotNull: (option<'t>, string, {..}) => {..} = 
        (value, propertyName, errors) =>
            switch value {
            | None => errors |> JsInterop.addProperty(propertyName, "Required.")
            | Some(_) => errors
            }

    let checkEquals: ('t, 't, string, {..}) => {..} = 
        (value, comparer, propertyName, errors) =>
            switch (value, comparer) {
            | (v1, v2) when v1 == v2 => errors
            | _ => errors |> JsInterop.addProperty(propertyName, `The ${FUtils.camelCaseToNormalCase(propertyName)} must be equal.`)
            }

    let checkEmailFormat: (string, string, {..}) => {..} =
        (value, propertyName, errors) => 
            switch Js.String.match_(%re("/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i"), value) {
            | None => errors |> JsInterop.addProperty(propertyName, "Invalid email address")
            | Some(_) => errors
            }
}