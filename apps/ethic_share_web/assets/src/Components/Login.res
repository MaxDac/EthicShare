open JsInterop
open BootstrapButton
open FormikImports

type formValues = {
    email: string,
    password: string
}

@react.component
let make = () => {
    let initialValues: formValues = {
        email: "",
        password: ""
    }

    let formValidation: formValues => {..} = values => {
        let checkEmail: (option<string>, formValues) => formValues = (e, vs) => 
            switch e {
            | None => {...vs, email: "Required"}
            | Some("") => {...vs, email: "Required"}
            | Some(v) => 
                switch Js.String.match_(%re("/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i"), v) {
                | None => {...vs, email: "Invalid email address"}
                | Some(_) => vs
                }
            }

        let checkPassword: (option<string>, formValues) => formValues = (e, vs) =>
            switch e {
            | None => {...vs, password: "Required"}
            | Some("") => {...vs, password: "Required"}
            | Some(_) => vs
            }

        initialValues
        |> checkEmail(values.email |> Option.noneIfEmpty)
        |> checkPassword(values.password |> Option.noneIfEmpty)
        |> checkIfNullAndReturnEmptyObject
    }

    let onFormSubmit: (formValues, formikSubmitEvent) => unit = (values, { setSubmitting }) => {
        Js.log(values);
        setSubmitting(false) |> ignore;
    }

    <div className="centered-compact-container">
        <h3>{React.string("Login into the application!")}</h3>
        <Formik initialValues={initialValues} validate={formValidation} onSubmit={onFormSubmit}>
            <Form>
                <FormControl>
                    <Field \"type"="email" name="email" className="form-control bg-dark text-white" />
                </FormControl>
                <FormControlMessage>
                    <ErrorMessage name="email" component="div" />
                </FormControlMessage>
                <FormControl>
                    <Field \"type"="password" name="password" className="form-control bg-dark text-white" />
                </FormControl>
                <FormControlMessage>
                    <ErrorMessage name="password" component="div" className="error-message" />
                </FormControlMessage>
                <FormControl>
                    <Button \"type"="submit" color="primary">{React.string("Submit")}</Button>
                </FormControl>
            </Form>
        </Formik>
    </div>
}