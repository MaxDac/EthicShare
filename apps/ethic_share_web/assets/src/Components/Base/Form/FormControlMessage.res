@react.component
let make = (~children: React.element) => 
    <div className="form-control-container-label form-control-container-lateral input-group">
        {children}
    </div>