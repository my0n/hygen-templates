---
to: "<%= features.includes('CI/GitHub Actions') ? `${project}/.github/workflows/build.yml` : null %>"
---
name: build

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

env:
  DOTNET_VERSION: 6.0.x
  DOTNET_BUILD_CONFIGURATION: Release
<% if (features.includes('CI/ghcr.io')) { -%>
  DOCKER_IMAGE_NAME_APP: <%= shortName %>
<% if (features.includes('API/Entity Framework')) { -%>
  DOCKER_IMAGE_NAME_MIGRATIONS: <%= shortName %>-migrations
<% } -%>
<% } -%>
  DOCKER_PROJECT_DOCKERFILE: src/<%= project %>/Dockerfile

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Setup .NET
      uses: actions/setup-dotnet@v2
      with:
        dotnet-version: ${{ env.DOTNET_VERSION }}

    - name: Restore dependencies
      run: dotnet restore

    - name: Build
      run: dotnet build --configuration ${{ env.DOTNET_BUILD_CONFIGURATION }} --no-restore

    - name: Test
      run: dotnet test --configuration ${{ env.DOTNET_BUILD_CONFIGURATION }} --no-build

    - name: Version and Tag
      if: github.ref == 'refs/heads/master'
      id: bump_version
      uses: mathieudutour/github-tag-action@v5.6
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}

    - name: Prep Version String
      if: github.ref == 'refs/heads/master'
      run: echo "VERSION_NUMBER=$(echo ${{ steps.bump_version.outputs.new_tag }} | sed 's/[v]//g')" >> $GITHUB_ENV

    - name: Set Package Version
      if: github.ref == 'refs/heads/master'
      uses: roryprimrose/set-vs-sdk-project-version@v1
      with:
        version: ${{ env.VERSION_NUMBER }}

    - name: Set up Docker Buildx
      if: github.ref == 'refs/heads/master'
      uses: docker/setup-buildx-action@v1

<% if (features.includes('CI/ghcr.io')) { -%>
    - name: Login to GitHub Packages Docker Registry
      if: github.ref == 'refs/heads/master'
      uses: docker/login-action@v1
      with:
        registry: ghcr.io
        username: ${{ github.repository_owner }}
        password: ${{ secrets.GITHUB_TOKEN }}

    - name: Build and push app docker image
      if: github.ref == 'refs/heads/master'
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ${{ env.DOCKER_PROJECT_DOCKERFILE }}
        target: final
        push: true
        tags: "ghcr.io/${{ github.repository_owner }}/${{ env.DOCKER_IMAGE_NAME_APP }}:latest,ghcr.io/${{ github.repository_owner }}/${{ env.DOCKER_IMAGE_NAME_APP }}:${{ env.VERSION_NUMBER }}"

<% if (features.includes('API/Entity Framework')) { -%>
    - name: Build and push Entity Framework migrations docker image
      if: github.ref == 'refs/heads/master'
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ${{ env.DOCKER_PROJECT_DOCKERFILE }}
        target: migrations
        push: true
        tags: "ghcr.io/${{ github.repository_owner }}/${{ env.DOCKER_IMAGE_NAME_MIGRATIONS }}:latest,ghcr.io/${{ github.repository_owner }}/${{ env.DOCKER_IMAGE_NAME_MIGRATIONS }}:${{ env.VERSION_NUMBER }}"

<% } -%>
<% } -%>
    - name: Create Release
      if: github.ref == 'refs/heads/master'
      uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: ${{ steps.bump_version.outputs.new_tag }}
        release_name: Release ${{ steps.bump_version.outputs.new_tag }}
        body: ${{ steps.bump_version.outputs.changelog }}
