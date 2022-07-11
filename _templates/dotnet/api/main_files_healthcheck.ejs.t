---
to: "<%= features.includes('File provider') && features.includes('Health checks') ? `${project}/src/${project}/Files/HealthChecks/ApplicationDataHealthCheck.cs` : null %>"
---
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Options;
using <%= project %>.Configuration;
using <%= project %>.Files.FileProviders;

namespace <%= project %>.Files.HealthChecks;

public class ApplicationDataHealthCheck : IHealthCheck
{
    private readonly IApplicationDataFileProvider fileProvider;
    private readonly IOptions<ServerOptions> options;

    public ApplicationDataHealthCheck(
        IApplicationDataFileProvider fileProvider,
        IOptions<ServerOptions> options)
    {
        this.fileProvider = fileProvider;
        this.options = options;
    }

    public Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        var fileInfo = fileProvider.GetFileInfo("");

        if (!fileInfo.Exists)
        {
            return Task.FromResult(HealthCheckResult.Unhealthy($"File path '{options.Value.DataPath}' does not exist"));
        }

        if (!fileInfo.IsDirectory)
        {
            return Task.FromResult(HealthCheckResult.Unhealthy($"File path '{options.Value.DataPath}' is not a directory"));
        }

        return Task.FromResult(HealthCheckResult.Healthy());
    }
}
