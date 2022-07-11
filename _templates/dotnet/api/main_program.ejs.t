---
to: <%= project %>/src/<%= project %>/Program.cs
---
using FluentValidation;
using IL.FluentValidation.Extensions.Options;
<% if (usesEF) { -%>
using Microsoft.EntityFrameworkCore;
<% } -%>
<% if (usesHealthChecks) { -%>
using Microsoft.Extensions.Diagnostics.HealthChecks;
<% } -%>
using <%= project %>.Configuration;
<% if (usesEF) { -%>
using <%= project %>.Database;
<% } -%>
<% if (usesFileProvider) { -%>
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

<% if (usesControllers) { -%>
// Controllers and Swashbuckle
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

<% } -%>
<% if (usesEF) { -%>
// Entity Framework
builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection"));
});

<% } -%>
<% if (usesFileProvider) { -%>
// Files
builder.Services.AddTransient<IApplicationDataFileProvider, ApplicationDataFileProvider>();
builder.Services.AddTransient<IApplicationDataFileRepository, ApplicationDataFileRepository>();

<% } -%>
<% if (usesHealthChecks) { -%>
// Health Checks and Monitoring
builder.Services.AddHealthChecks()
<% if (usesEF) { -%>
    .AddDbContextCheck<ApplicationDbContext>()
<% } -%>
<% if (usesFileProvider) { -%>
    .AddCheck<ApplicationDataHealthCheck>("Application Data Directory")
<% } -%>
    .AddCheck("Health Checks Endpoint", () => HealthCheckResult.Healthy("Health check endpoint responding to requests."));

<% } -%>
var app = builder.Build();

<% if (usesControllers) { -%>
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();

<% } -%>
<% if (usesHealthChecks) { -%>
app.MapHealthChecks("/healthz");

<% } -%>
app.Run();
