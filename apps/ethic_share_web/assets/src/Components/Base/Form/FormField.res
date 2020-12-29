open FormikImports

@react.component
let make = (~\"type": string, ~name: string) => {
    <>
        <FormControl>
            <Field \"type"={\"type"} name={name} className="form-control bg-dark text-white" />
        </FormControl>
        <FormControlMessage>
            <ErrorMessage name={name} component="div" />
        </FormControlMessage>
    </>
}