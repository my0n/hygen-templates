---
to: "<%= features.includes('API/File provider') ? `${project}/src/${project}/Files/Repositories/IApplicationDataFileRepository.cs` : null %>"
---
namespace <%= project %>.Files.Repositories;

public interface IApplicationDataFileRepository
{
    Task<string> GetWeatherReportAsync(Guid id);
}
