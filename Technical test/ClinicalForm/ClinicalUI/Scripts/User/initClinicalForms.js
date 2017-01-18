/*
* Clinical Form Javascript Control Initialization Module
* Grid configurations are here
*/



var bloodTypes, countries;

function DxControls() {
    
    InitializeBloodTypes().done(function () {
        InitializeCountries().done(function () {
            InitPatientsGrid();
        });
        
    });
    
}

function InitializeBloodTypes() {

    var dfd = $.Deferred();

    var getUrl_bloodTypes = "http://localhost/ClinicalWebService/api/bloodtypes/";;

    function GetBloodTypes() {
     

        $.ajax({
            url: getUrl_bloodTypes,
            type: "GET",
            async: true,
            contentType: "application/json",
            success: function (result) {
                bloodTypes = result;
                dfd.resolve();
            },
            error: function () {
                dfd.reject("Data Loading Error");
            },
            timeout: 5000
        });

        
    };

    GetBloodTypes();

    return dfd;
}

function InitializeCountries() {
    
    var dfd = $.Deferred();

    var getUrl_countries = "http://localhost/ClinicalWebService/api/countries/";;

    function GetCountries() {


        $.ajax({
            url: getUrl_countries,
            type: "GET",
            async: true,
            contentType: "application/json",
            success: function (result) {
                countries = result;
                dfd.resolve();
            },
            error: function () {
                dfd.reject("Data Loading Error");
            },
            timeout: 5000
        });
    };

    GetCountries();

    return dfd;

}



function InitPatientsGrid() {

    var getUrl = "http://localhost/ClinicalWebService/api/patient/";
    var insertUrl = "http://localhost/ClinicalWebService/patients/post/";
    var removeUrl = "http://localhost/ClinicalWebService/patients/delete/";
    var updateUrl = "http://localhost/ClinicalWebService/patients/update/";

    var patients = new DevExpress.data.CustomStore({
        key: "id",
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
                    $("#gd_patients").dxDataGrid("instance").refresh();
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
                data: JSON.stringify({ key: key }),
                success: function (result) {
                    deferred.resolve(true);
                    $("#gd_patients").dxDataGrid("instance").refresh();
                },
                error: function (a, g, x) {
                    deferred.reject("Data Loading Error " + g + ", " + x);
                },
                timeout: 5000
            });

        },

        update: updateUrl && function (key,values) {

            var deferred = $.Deferred();

            $.ajax({
                url: updateUrl,
                type: "PUT",
                contentType: "application/json",
                data: JSON.stringify({ key: key ,patient: values }),
                success: function (result) {
                    deferred.resolve(true);
                    $("#gd_patients").dxDataGrid("instance").refresh();
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
            { dataField: 'DateOfBirth', dataType: 'date', format: "shortDate" },
             {
                 dataField: 'Country', caption: 'Country', lookup: { dataSource: countries, valueExpr: 'Id', displayExpr: 'Name' }
             },
            'Phone',
            'Diseases',
            {
                dataField: 'BloodType', caption: 'Blood Type', lookup: { dataSource: bloodTypes, valueExpr: 'Id', displayExpr: 'Antigen' }
            }
           
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