type formikSubmitEvent = {
    setSubmitting: bool => unit
}

// There are more properties, refer to the Typescript type in the node_modules
type formikFormItem = {
    touched: option<bool>,
    isSubmitting: option<bool>
}

module Formik = {
    @bs.module("../../../node_modules/formik/dist/index.js")
    @react.component
    external make: (
        ~initialValues: 't=?,
        ~validate: 't => 'e=?,
        ~onSubmit: ('t, formikSubmitEvent) => unit=?,
        // ~children: React.element=?
        ~children: formikFormItem => React.element) => React.element = "Formik"
}

module Form = {
    @bs.module("../../../node_modules/formik/dist/index.js")
    @react.component
    external make: (
        ~children: React.element=?) => React.element = "Form"
}

module Field = {
    @bs.module("../../../node_modules/formik/dist/index.js")
    @react.component
    external make: (
        ~name: string,
        ~\"type": string,
        ~className: string=?,
        ~children: React.element=?) => React.element = "Field"
}

module ErrorMessage = {
    @bs.module("../../../node_modules/formik/dist/index.js")
    @react.component
    external make: (
        ~name: string,
        ~component: string,
        ~className: string=?,
        ~children: React.element=?) => React.element = "ErrorMessage"
}
