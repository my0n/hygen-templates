---
to: <%= project %>/src/<%= project %>/Dockerfile
---
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/<%= project %>/<%= project %>.csproj", "src/<%= project %>/"]
RUN dotnet restore "src/<%= project %>/<%= project %>.csproj"
COPY . .
WORKDIR "/src/src/<%= project %>"
RUN dotnet build "<%= project %>.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "<%= project %>.csproj" -c Release -o /app/publish
<% if (features.includes('Entity Framework')) { -%>
RUN dotnet tool install --global dotnet-ef
RUN dotnet ef migrations bundle --output /app/db/bundle
RUN chmod u+x /app/db/bundle
<% } -%>

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "<%= project %>.dll"]

<% if (features.includes('Entity Framework')) { -%>
FROM base AS migrations
WORKDIR /app
COPY --from=publish /app/db .
ENTRYPOINT ./bundle --connection "$CONNECTION_STRING"
<% } -%>
