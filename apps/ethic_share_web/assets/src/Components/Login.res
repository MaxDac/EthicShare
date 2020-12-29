open JsInterop
open BootstrapButton
open FormikImports
open LoginService
open BaseTypes
open PageUtils
open FormUtils
open FormContainer

type formValues = {
    "email": string,
    "password": string
}

@react.component
let make = () => {
    let initialValues: formValues = {
        "email": "",
        "password": ""
    }

    let formProperties = [
        {
            name: "email",
            _type: "email"
        },
        {
            name: "password",
            _type: "password"
        }
    ]

    let formValidation: formValues => {..} = values => {
        open Validator
        
        container()
        |> Validator.checkNotNull(values["email"] |> Option.noneIfEmpty, "email")
        |> Validator.checkEmailFormat(values["email"], "email")
        |> Validator.checkNotNull(values["email"] |> Option.noneIfEmpty, "password")
        |> checkIfNullAndReturnEmptyObject
    }

    let onFormSubmit: (formValues, formikSubmitEvent) => unit = (values, { setSubmitting }) => {

        let performLoginDelegate = (v: formValues) =>
            () => performLogin({
                username: v["email"],
                password: v["password"]
            })

        let handleOk = (res) => {
            setSubmitting(false)
        }

        let handleError = e => {
            Js.log("error!")
            Js.log(e)
            setSubmitting(false)
        }

        Fetch.manageApiResponse(performLoginDelegate(values), handleOk, handleError)

    }

    <div className="centered-compact-container">
        <h3>{React.string("Login into the application!")}</h3>
        <FormContainer 
            initialValues={initialValues} 
            properties={formProperties}
            validator={formValidation} 
            onFormSubmit={onFormSubmit} />
    </div>
}