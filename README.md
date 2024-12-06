Azure Function in a Container
=============================

This is an experiment deploying a .NET Function App into a container


Build on GitHub Actions
-----------------------

To create the `AZURE_CREDENTIALS` secret:

```bash
az ad sp create-for-rbac --name "func1" --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Web/sites/{app-name} \
  --sdk-auth
```

See https://github.com/Azure/functions-container-action

The other secrets are copied straight from the Azure Container Registry.


Run in Azure Functions
----------------------

Set these environment variables:

- `WEBSITES_ENABLE_APP_SERVICE_STORAGE=false` see https://stackoverflow.com/questions/73816151/azure-functions-with-docker-container-doesnt-detect-functions
- `FUNCTIONS_WORKER_RUNTIME=dotnet-isolated` even though it's `custom` else it fails to sync function definitions in GitHub Actions build task

Then browse to the function url, e.g. `https://<app_name>.azurewebsites.net/api/Function1`. Replace `<app_name>` with your Azure Function name.


Kudu
----

The Kudu (Advanced tools) portal is https://<app_name>.scm.azurewebsites.net/. Replace <app_name> with your Azure Function name.


License
-------

MIT, Copyright Richardson & Sons, LLC.
