[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/gbms311/CSV2SCIMBulkUploadPoC/refs/heads/main/csv2scimbulkupload-template.json)


https://github.com/gbms311/CSV2SCIMBulkUploadPoC.git

# CSV2SCIMBulkUpload

Simple Azure Logic Apps workflow that converts a CSV file containing user records to a SCIM bulk upload request that can be sent to the Entra ID provisioning service [/bulkUpload](https://learn.microsoft.com/graph/api/synchronization-synchronizationjob-post-bulkupload) API endpoint.

## How to use the Logic Apps workflow

Refer to the instructions [Quickstart API-driven inbound provisioning with Azure Logic Apps](https://aka.ms/Entra/InboundProvWithLogicApps).

## How to file issues and get help  

This sample asset uses GitHub Issues to track bugs and feature requests. Please search the existing 
issues before filing new issues to avoid duplicates.  For new issues, file your bug or 
feature request as a new Issue.

For help and questions about Entra ID API-driven inbound provisioning, refer to the [documentation](https://aka.ms/Entra/ProvisionFromAnySource)

## Credits
This is a clone and tweak from [CSV2SCIMBulkUpload](https://github.com/AzureAD/entra-id-inbound-provisioning/tree/main/LogicApps/CSV2SCIMBulkUpload)
The workflow reuses the awesome [CSVtoJSONcore](https://github.com/joelbyford/CSVtoJSONcore/) Azure function. 
