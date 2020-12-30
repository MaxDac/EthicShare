open JsInterop
open BootstrapImports
open FormikImports
open LoginService
open BaseTypes
open PageUtils
open FormUtils
open FormContainer

@react.component
let make = (
    ~initialValues: option<'t>=?,
    ~initialValuesGetter: option<() => Js.Promise.t<'t>>=?,
    ~formProperties: array<formFieldProperty>,
    ~formValidation: 't => {..},
    ~saveDelegate: 't => Js.Promise.t<apiResponse<'q>>
) => {
    let (formModel, setFormModel) = React.useState(() => None)
    let (showAlert, setShowAlert) = React.useState(() => false)
    let (alertText, setAlertText) = React.useState(() => "")

    let handleError: array<string> => unit = e => {
        let error: string = 
            e
            |> Array.to_list
            |> List.filter(e => e != "")
            |> FUtils.fold_right((el: string, acc: string) => `${acc},\n"${el}`, "")

        setAlertText(_ => error)
        setShowAlert(_ => true)
        setSubmitting(false)
    }

    React.useEffect0(() => {
        switch (initialValues, initialValuesGetter) {
        | (None, None) =>
            setAlertText(_ => "No model nor getter defined.")
            setShowAlert(_ => true)
        | (Some(value), _) =>
            setFormModel(_ => value)
        | (_, Some(getter)) =>
            getter()
            |> Js.Promise.then_(model => {
                switch model {
                | Ok(value) => setFormModel(-value)
                | Error(error) => handleError(error)
                }
            })
            |> Js.Promise.catch(handleError)
        }
    })

    let onFormSubmit: ('t, formikSubmitEvent) => unit = (values, { setSubmitting }) => {

        let handleOk = (_) => {
            setSubmitting(false)
        }

            setAlertText(_ => error)
            setShowAlert(_ => true)
            setSubmitting(false)
        }

        Fetch.manageApiResponse(() => saveDelegate(values), handleOk, handleError)

    }

    <div className="centered-compact-container">
        <div className="padded-alert">
            <Alert color="danger" isOpen={showAlert} toggle={() => setShowAlert(_ => false)}>
                {React.string({alertText})}
            </Alert>
        </div>
        <h3>{React.string("Create the new user!")}</h3>
        <FormContainer 
            initialValues={initialValues} 
            properties={formProperties}
            validator={formModel} 
            onFormSubmit={onFormSubmit} />
    </div>
}