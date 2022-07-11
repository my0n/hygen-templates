---
to: <%= project %>/src/<%= project %>/appsettings.Development.json
---
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
<% if (usesEF) { -%>
  "ConnectionStrings": {
    "DefaultConnection": "Server=host.docker.internal;Port=5432;Database=<%= project %>;User Id=postgres;Password=password"
  },
<% } -%>
  "Server": {
  }
}
