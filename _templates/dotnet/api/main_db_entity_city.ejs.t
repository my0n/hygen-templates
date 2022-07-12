---
to: "<%= features.includes('API/Entity Framework') ? `${project}/src/${project}/Database/Entities/DbCity.cs` : null %>"
---
namespace <%= project %>.Database.Entities;

public class DbCity
{
    public int Id { get; private set; }
    public string Name { get; private set; } = default!;
    public DateTime DateCreated { get; private set; }
    public DateTime DateUpdated { get; private set; }

    [Obsolete("Exists to appease EF", true)]
    public DbCity()
    {
    }

    public DbCity(string name)
    {
        Name = name;
        DateCreated = DateTime.UtcNow;
        DateUpdated = DateTime.UtcNow;
    }

    public void SetName(string name)
    {
        Name = name;
        DateUpdated = DateTime.UtcNow;
    }
}
