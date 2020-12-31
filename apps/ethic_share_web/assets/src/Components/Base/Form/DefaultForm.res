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
    ~initialValues: 't,
    ~formProperties: array<formFieldProperty>,
    ~formValidation: 't => {..},
    ~saveDelegate: 't => Js.Promise.t<apiResponse<'q>>,
    ~onSaveOk: 'q => unit
) => {
    let (showAlert, setShowAlert) = React.useState(() => false)
    let (alertText, setAlertText) = React.useState(() => "")

    let handleError: (bool => unit) => (array<string> => unit) = 
        setSubmitting => 
            e => {
                let error: string = 
                    e
                    |> Array.to_list
                    |> List.filter(e => e != "")
                    |> FUtils.fold_right((el: string, acc: string) => `${acc},\n"${el}`, "")

                setAlertText(_ => error)
                setShowAlert(_ => true)
                setSubmitting(false)
            }

    let onFormSubmit: ('t, formikSubmitEvent) => unit = (values, { setSubmitting }) => {
        let okHandler = res => {
            setSubmitting(false)
            onSaveOk(res)
        }

        Fetch.manageApiResponse(() => saveDelegate(values), okHandler, handleError(setSubmitting))
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
            validator={formValidation} 
            onFormSubmit={onFormSubmit} />
    </div>
}