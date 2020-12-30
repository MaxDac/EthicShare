open FormikImports
open BootstrapImports
open FormControl
open FormControlMessage

type formFieldProperty = {
    _type: string,
    name: string
}

@react.component
let make = (
    ~properties: array<formFieldProperty>,
    ~initialValues: 't,
    ~validator: 't => {..},
    ~onFormSubmit: ('t, formikSubmitEvent) => unit) => {

    let fieldFromProperty = (p: formFieldProperty) => {
        <>
            <FormControl>
                <Field \"type"={p._type} name={p.name} className="form-control bg-dark text-white" />
            </FormControl>
            <FormControlMessage>
                <ErrorMessage name={p.name} component="div" />
            </FormControlMessage>
        </>
    }
    
    let fields = 
        properties 
        |> Array.map(fieldFromProperty)
        |> React.array

    <Formik initialValues={initialValues} validate={validator} onSubmit={onFormSubmit}>
        {({isSubmitting}) => {
            <Form>
                {fields}
                <FormControl>
                    <Button \"type"="submit" color="primary" disabled={isSubmitting |> Option.getOrElse(true)}>{React.string("Submit")}</Button>
                </FormControl>
            </Form>
        }}
    </Formik>
}