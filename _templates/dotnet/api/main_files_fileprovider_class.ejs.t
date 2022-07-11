---
to: "<%= usesFileProvider ? `${project}/src/${project}/Files/FileProviders/ApplicationDataFileProvider.cs` : null %>"
---
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using <%= project %>.Configuration;

namespace <%= project %>.Files.FileProviders;

public class ApplicationDataFileProvider : IApplicationDataFileProvider
{
    private readonly IFileProvider backing;

    public ApplicationDataFileProvider(IOptions<ServerOptions> options)
    {
        backing = new PhysicalFileProvider(options.Value.DataPath);
    }

    public IDirectoryContents GetDirectoryContents(string subpath)
    {
        return backing.GetDirectoryContents(subpath);
    }

    public IFileInfo GetFileInfo(string subpath)
    {
        return backing.GetFileInfo(subpath);
    }

    public IChangeToken Watch(string filter)
    {
        return backing.Watch(filter);
    }
}
