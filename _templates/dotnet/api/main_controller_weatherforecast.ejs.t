---
to: "<%= features.includes('API/Controllers') ? `${project}/src/${project}/Controllers/WeatherForecastController.cs` : null %>"
---
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using <%= project %>.Configuration;
using <%= project %>.Models;

namespace <%= project %>.Controllers;

[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    private readonly ILogger<WeatherForecastController> logger;
    private readonly IOptions<ServerOptions> options;

    public WeatherForecastController(
        ILogger<WeatherForecastController> logger,
        IOptions<ServerOptions> options)
    {
        this.logger = logger;
        this.options = options;
    }

    [HttpGet(Name = "GetWeatherForecast")]
    public IEnumerable<WeatherForecast> Get()
    {
        var minTemp = options.Value.MinimumTemperature;
        var maxTemp = options.Value.MaximumTemperature;
        return Enumerable.Range(1, 5).Select(index => new WeatherForecast
        {
            Date = DateTime.Now.AddDays(index),
            TemperatureC = minTemp + (Random.Shared.NextDouble() * (maxTemp - minTemp)),
            Summary = Summaries[Random.Shared.Next(Summaries.Length)]
        })
        .ToArray();
    }
}
