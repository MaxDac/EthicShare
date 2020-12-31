open BootstrapImports
open FormikImports

@react.component
let make = (~\"type": string, ~name: string, ~label: string) => {
    <>
        <FormControl>
            <Label \"for"={name}>
                {React.string(label)}
            </Label>
        </FormControl>
        <FormControl>
            <Field 
                \"type"={\"type"} 
                name={name} 
                id={name}
                placeholder={label}
                className="form-control bg-dark text-white" />
        </FormControl>
        <FormControlMessage>
            <ErrorMessage name={name} component="div" />
        </FormControlMessage>
    </>
}