---
to: "<%= usesFileProvider ? `${project}/src/${project}/Files/Repositories/ApplicationDataFileRepository.cs` : null %>"
---
using <%= project %>.Files.FileProviders;

namespace <%= project %>.Files.Repositories;

public class ApplicationDataFileRepository : IApplicationDataFileRepository
{
    private readonly IApplicationDataFileProvider fileProvider;

    public ApplicationDataFileRepository(IApplicationDataFileProvider fileProvider)
    {
        this.fileProvider = fileProvider;
    }

    public async Task<string> GetWeatherReportAsync(Guid id)
    {
        using var stream = fileProvider.GetFileInfo($"{id}").CreateReadStream();
        using var reader = new StreamReader(stream);
        return await reader.ReadToEndAsync();
    }
}
