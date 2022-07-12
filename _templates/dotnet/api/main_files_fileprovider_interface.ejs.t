---
to: "<%= features.includes('API/File provider') ? `${project}/src/${project}/Files/FileProviders/IApplicationDataFileProvider.cs` : null %>"
---
using Microsoft.Extensions.FileProviders;

namespace <%= project %>.Files.FileProviders;

public interface IApplicationDataFileProvider : IFileProvider
{
}
