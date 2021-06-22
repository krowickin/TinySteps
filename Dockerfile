FROM mcr.microsoft.com/dotnet/framework/sdk:3.5 AS build 
WORKDIR /app

FROM mcr.microsoft.com/dotnet/framework/sdk:3.5 AS base
# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -o out

# Build runtime image

WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "wrld.dll"]