function DxControls() {
    
   // InitializeControlDefinitions();
    InitPatientsGrid();
}



function InitPatientsGrid() {

    var getUrl = "http://localhost/ClinicalWebService/api/patient/";
    var insertUrl = "http://localhost/ClinicalWebService/patients/post/";
    var removeUrl = "http://localhost/ClinicalWebService/patients/delete/";
    var updateUrl = "http://localhost/ClinicalWebService/patients/update/";

    var patients = new DevExpress.data.CustomStore({
        key: "Id",
        load: function (loadOptions) {
            var deferred = $.Deferred(),
                args = {};

            if (loadOptions.sort) {
                args.orderby = loadOptions.sort[0].selector;
                if (loadOptions.sort[0].desc)
                    args.orderby += " desc";
            }

            args.skip = loadOptions.skip || 0;
            args.take = loadOptions.take || 12;

            $.ajax({
                url: getUrl,
                data: args,
                success: function (result) {
                    deferred.resolve(result.items, { totalCount: result.totalCount });
                },
                error: function () {
                    deferred.reject("Data Loading Error");
                },
                timeout: 5000
            });

            return deferred.promise();
        },

        insert: insertUrl && function (values) {
    
            var deferred = $.Deferred();

            $.ajax({
                url: insertUrl,
                type: "POST",
                contentType: "application/json",              
                data: JSON.stringify({ values: values }),
                success: function (result) {
                    deferred.resolve(true);
                },
                error: function (a, g, x) {
                    deferred.reject("Data Loading Error " + g + ", " + x);
                },
                timeout: 5000
            });
           
        },

        remove: removeUrl && function (key) {
            
            var deferred = $.Deferred();

            $.ajax({
                url: removeUrl,
                type: "DELETE",
                contentType: "application/json",
                data: { key: key },
                success: function (result) {
                    deferred.resolve(true);
                },
                error: function (a, g, x) {
                    deferred.reject("Data Loading Error " + g + ", " + x);
                },
                timeout: 5000
            });

        },

        update: updateUrl && function (values) {

            var deferred = $.Deferred();

            $.ajax({
                url: updateUrl,
                type: "POST",
                contentType: "application/json",
                data: { values: JSON.stringify(values) },
                success: function (result) {
                    deferred.resolve(true);
                },
                error: function (a, g, x) {
                    deferred.reject("Data Loading Error " + g + ", " + x);
                },
                timeout: 5000
            });

        },

    });

    var grid = $("#gd_patients").dxDataGrid({
        dataSource: {
            store: patients
        },
        columns: [
            //"id",
            { dataField: 'id', visible: false },
            'FirstName',
            'LastName',
            { dataField: 'DateOfBirth', format: "MM/dd/yyyy" },
            'Country',
            'Phone',
            'Diseases',
            'BloodType'
        ],
        paging: {
            pageSize: 10
        },
        filterRow: {
            visible: true
        },
        editing: {
            mode: "batch",
            allowUpdating: true,
            allowDeleting: true,
            allowAdding: true

        }
    }).dxDataGrid("instance");

    function serializeKey(key) {
        if (typeof key === "object")
            return JSON.stringify(key);

        return key;
    }
}


DxControls();