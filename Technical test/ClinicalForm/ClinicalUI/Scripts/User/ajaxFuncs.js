var QueryController = function(entity) {
    
   this.Get = function(entity) {
        debugger;
        $.ajax({
            method: "GET",
            url: "http://localhost/ClinicalWebService/api/" + entity,       
            })
        .done(function (msg) {
            return msg;
        })
       .fail(function ( jqXHR, textStatus, errorThrown ) {
           ThrowError(textStatus, errorThrown);
       });
    }

}

function ThrowError(textStatus, errorThrown) {
    alert("Webservice call error: Status: " + textStatus.toUpperCase() + ", errorThrown: " + errorThrown.toUpperCase());
}