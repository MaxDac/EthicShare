open JsInterop
open BootstrapImports
open FormikImports
open LoginService
open BaseTypes
open PageUtils
open FormUtils
open FormContainer

type formValues = {
    "username": string,
    "email": string,
    "password": string,
    "repeatedPassword": string,
}

@react.component
let make = () => {

    let initialValues: formValues = {
        "username": "",
        "email": "",
        "password": "",
        "repeatedPassword": ""
    }

    let formProperties = [
        {
            name: "username",
            _type: "username",
            label: "Username"
        },
        {
            name: "email",
            _type: "email",
            label: "Email"
        },
        {
            name: "password",
            _type: "password",
            label: "Password"
        },
        {
            name: "repeatedPassword",
            _type: "repeatedPassword",
            label: "Repeat Password"
        }
    ]

    let formValidation: formValues => {..} = values => {
        open Validator
        
        container()
        |> Validator.checkNotNull(values["username"] |> Option.noneIfEmpty, "username")
        |> Validator.checkNotNull(values["email"] |> Option.noneIfEmpty, "email")
        |> Validator.checkEmailFormat(values["email"], "email")
        |> Validator.checkNotNull(values["password"] |> Option.noneIfEmpty, "password")
        |> Validator.checkEquals(values["password"], values["repeatedPassword"], "repeatedPassword")
        |> checkIfNullAndReturnEmptyObject
    }

    let performLoginDelegate = (v: formValues) =>
        performLogin({
            username: v["email"],
            password: v["password"]
        })

    let handleOk = (res) => {
        Js.log(res)
    }

    <DefaultForm
        initialValues={initialValues}
        formProperties={formProperties}
        formValidation={formValidation}
        saveDelegate={performLoginDelegate}
        onSaveOk={handleOk} />
}