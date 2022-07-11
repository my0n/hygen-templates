---
to: <%= project %>/src/<%= project %>/appsettings.Example.json
---
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
<% if (features.includes('Entity Framework')) { -%>
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Port=5432;Database=<%= project %>;User Id=postgres;Password=password"
  },
<% } -%>
  "Server": {
  }
}
