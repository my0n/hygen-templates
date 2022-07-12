---
to: "<%= features.includes('API/Entity Framework') ? `${project}/src/${project}/Database/EntityConfigurations/DbCityConfiguration.cs` : null %>"
---
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using <%= project %>.Database.Entities;

namespace <%= project %>.Database.EntityConfigurations;

public class DbCityConfiguration : IEntityTypeConfiguration<DbCity>
{
    public void Configure(EntityTypeBuilder<DbCity> builder)
    {
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Name)
            .HasMaxLength(256);
    }
}
