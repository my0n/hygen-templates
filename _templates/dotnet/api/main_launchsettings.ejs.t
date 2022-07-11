---
to: <%= project %>/src/<%= project %>/Properties/launchSettings.json
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