---
to: <%= project %>/src/<%= project %>/Program.cs
---
using FluentValidation;
using IL.FluentValidation.Extensions.Options;
<% if (features.includes('API/Entity Framework')) { -%>
using Microsoft.EntityFrameworkCore;
<% } -%>
<% if (features.includes('API/Health checks')) { -%>
using Microsoft.Extensions.Diagnostics.HealthChecks;
<% } -%>
using <%= project %>.Configuration;
<% if (features.includes('API/Entity Framework')) { -%>
using <%= project %>.Database;
<% } -%>
<% if (features.includes('API/File provider')) { -%>
using <%= project %>.Files.FileProviders;
using <%= project %>.Files.HealthChecks;
using <%= project %>.Files.Repositories;
<% } -%>

var builder = WebApplication.CreateBuilder(args);

// AutoMapper
builder.Services.AddAutoMapper(typeof(Program).Assembly);

// Configuration
builder.Services.AddValidatorsFromAssembly(typeof(Program).Assembly);
builder.Services.AddOptions<ServerOptions>("Server")
    .Configure(_ => { })
    .ValidateWithFluentValidator();

<% if (features.includes('API/Controllers')) { -%>
// Controllers and Swashbuckle
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

<% } -%>
<% if (features.includes('API/Entity Framework')) { -%>
// Entity Framework
builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection"));
});

<% } -%>
<% if (features.includes('API/File provider')) { -%>
// Files
builder.Services.AddTransient<IApplicationDataFileProvider, ApplicationDataFileProvider>();
builder.Services.AddTransient<IApplicationDataFileRepository, ApplicationDataFileRepository>();

<% } -%>
<% if (features.includes('API/Health checks')) { -%>
// Health Checks and Monitoring
builder.Services.AddHealthChecks()
<% if (features.includes('API/Entity Framework')) { -%>
    .AddDbContextCheck<ApplicationDbContext>()
<% } -%>
<% if (features.includes('API/File provider')) { -%>
    .AddCheck<ApplicationDataHealthCheck>("Application Data Directory")
<% } -%>
    .AddCheck("Health Checks Endpoint", () => HealthCheckResult.Healthy("Health check endpoint responding to requests."));

<% } -%>
var app = builder.Build();

<% if (features.includes('API/Controllers')) { -%>
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();

<% } -%>
<% if (features.includes('API/Health checks')) { -%>
app.MapHealthChecks("/healthz");

<% } -%>
app.Run();
