
(function () {
    var url = "http://localhost/ClinicalWebService/";

    Application1.db = DevExpress.data.AspNet.createStore({
        key: "Id",
        loadUrl: url,
        insertUrl: url,
        updateUrl: url,
        deleteUrl: url
    });
})()

