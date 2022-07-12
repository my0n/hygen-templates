---
to: "<%= features.includes('API/Controllers') ? `${project}/src/${project}/Properties/launchSettings.json` : null %>"
---
{
  "$schema": "https://json.schemastore.org/launchsettings.json",
  "profiles": {
    "Docker": {
      "commandName": "Docker",
      "launchBrowser": true,
      "launchUrl": "{Scheme}://{ServiceHost}:{ServicePort}/swagger",
      "publishAllPorts": true,
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}