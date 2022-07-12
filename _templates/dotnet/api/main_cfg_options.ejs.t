---
to: <%= project %>/src/<%= project %>/Configuration/ServerOptions.cs
---
namespace <%= project %>.Configuration;

public class ServerOptions
{
<% if (features.includes('API/File provider')) { -%>
    public string DataPath { get; set; } = "/data";

<% } -%>
    public double MinimumTemperature { get; set; } = 0.0;
    public double MaximumTemperature { get; set; } = 40.0;
}
