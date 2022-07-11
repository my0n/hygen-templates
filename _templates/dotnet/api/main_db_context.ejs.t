---
to: "<%= features.includes('Entity Framework') ? `${project}/src/${project}/Database/ApplicationDbContext.cs` : null %>"
---
using Microsoft.EntityFrameworkCore;
using <%= project %>.Database.Entities;

namespace <%= project %>.Database;

public class ApplicationDbContext : DbContext
{
    public virtual DbSet<DbCity> Cities { get; set; } = default!;

    public ApplicationDbContext(
        DbContextOptions options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);
    }
}
