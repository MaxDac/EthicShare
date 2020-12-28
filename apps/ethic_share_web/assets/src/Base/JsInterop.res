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
`)

@bs.val
external checkIfNullAndReturnEmptyObject: 't => {..} = "checkIfNullAndReturnEmptyObject"