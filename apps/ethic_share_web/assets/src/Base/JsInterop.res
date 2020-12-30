%%raw(`

    const isNullOrEmpty = function (a) {
        return a === undefined || a === null || a === "";
    }

    const checkIfNullAndReturnEmptyObject = function (a) {
        for (const idx in a) {
            if (!isNullOrEmpty(idx) && !isNullOrEmpty(a[idx])) {
                return a;
            }
        }

        return {};
    }

    const fastClone = function(obj) {
        return JSON.parse(JSON.stringify(obj));
    }

    const addProperty = function(name, value, obj) {
        let cloned = fastClone(obj);
        cloned[name] = value;
        return cloned;
    }
`)

@bs.val
external checkIfNullAndReturnEmptyObject: 't => {..} = "checkIfNullAndReturnEmptyObject"

@bs.val
external addProperty: (string, 't, {..}) => {..} = "addProperty"

@bs.val
external showSimpleAlert: string => unit = "alert"

@bs.val
@bs.scope("JSON")
external stringify: 'a => string = "stringify"