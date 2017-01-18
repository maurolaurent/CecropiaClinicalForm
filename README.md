# CecropiaClinicalForm

Technical test from Mauro Laurent


## INSTALLATION INSTRUCTIONS

0. The database script might have to be ran on a empty database. The database name is ClinicalForm.
1. Open Technical test\ClinicalForm.ClinicalForm.sln with Visual Studio
2. Build the solution. You might have to update the NuGets as well.
3. Check the both solutions ClinicalWebService and ClinicalUI. Both need to run in localhost for better results.
4. The solutions web.config (ClinicalWebService, ClinicalUI) must match the ClinicalLib app.config cconnection string, which must point your database.

## PROJECT STRUCTURE

ClinicalLib: Contains CRUD operations, entity framework modules & structure and models for the solution.
ClinicalWebService: Webservice that receives external communications, has a reference of ClinicalLib to communicate with database. Contains a Web api controllers as well MVC Controllers. MVC controllers were used to not mess too much with the routing, and therefore only used for PUT, POST, DELETE operations. Asynchronous operations are handled by the other web api controllers.
ClinicalUI: Visual Interface of the aplication, communicates thru Ajax to the webservice, totally decoupled. Has mostly javascript and html code neccesary to run the grid.