---
to: <%= project %>/src/<%= project %>/Configuration/ServerOptionsValidator.cs
---
using FluentValidation;

namespace <%= project %>.Configuration;

public class ServerOptionsValidator : AbstractValidator<ServerOptions>
{
    public ServerOptionsValidator()
    {
<% if (features.includes('API/File provider')) { -%>
        RuleFor(x => x.DataPath)
            .NotEmpty();

<% } -%>
        RuleFor(x => x.MinimumTemperature)
            .GreaterThanOrEqualTo(-273.15)
            .WithMessage("Must be greater than or equal to absolute zero (-273.15°C).");
        RuleFor(x => x.MaximumTemperature)
            .LessThan(6000.0)
            .WithMessage("Must be less than the surface of the sun (6000°C).");
        RuleFor(x => x.MinimumTemperature)
            .LessThanOrEqualTo(x => x.MaximumTemperature)
            .WithMessage(x => $"Must be less than or equal to the maximum temperature ({x.MaximumTemperature}).");
        RuleFor(x => x.MaximumTemperature)
            .GreaterThanOrEqualTo(x => x.MinimumTemperature)
            .WithMessage(x => $"Must be greater than or equal to the minimum temperature ({x.MinimumTemperature}).");
    }
}
