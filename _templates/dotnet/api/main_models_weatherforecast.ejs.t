---
to: "<%= features.includes('API/Controllers') ? `${project}/src/${project}/Models/WeatherForecast.cs` : null %>"
---
namespace <%= project %>.Models;

public class WeatherForecast
{
    public DateTime Date { get; set; }

    public double TemperatureC { get; set; }

    public double TemperatureF => 32 + (TemperatureC / 0.5556);

    public string? Summary { get; set; }
}
