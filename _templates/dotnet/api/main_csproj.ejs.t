---
to: <%= project %>/src/<%= project %>/<%= project %>.csproj
---
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net6.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <DockerDefaultTargetOS>Linux</DockerDefaultTargetOS>
    <DockerfileContext>..\..</DockerfileContext>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="AutoMapper.Extensions.Microsoft.DependencyInjection" Version="11.0.0" />
    <PackageReference Include="FluentValidation.AspNetCore" Version="11.1.2" />
    <PackageReference Include="IL.FluentValidation.Extensions.Options" Version="10.0.1" />
<% if (features.includes('API/Entity Framework')) { -%>
    <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="6.0.6">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
    <PackageReference Include="Npgsql.EntityFrameworkCore.PostgreSQL" Version="6.0.5" />
<% } -%>
<% if (features.includes('API/Entity Framework') && features.includes('API/Health checks')) { -%>
    <PackageReference Include="Microsoft.Extensions.Diagnostics.HealthChecks.EntityFrameworkCore" Version="6.0.6" />
<% } -%>
    <PackageReference Include="Microsoft.VisualStudio.Azure.Containers.Tools.Targets" Version="1.16.1" />
<% if (features.includes('API/Controllers')) { -%>
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.3.1" />
<% } -%>
  </ItemGroup>

</Project>
