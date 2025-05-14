# Build stage - Use .NET 8.0 SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build  # Changed from 6.0 to 8.0
WORKDIR /src

# Copy project file first for efficient caching
COPY Tarea3/Tarea3/Tarea3.csproj .
RUN dotnet restore

# Copy remaining files
COPY Tarea3/Tarea3/ .
RUN dotnet publish -c Release -o /app

# Runtime stage - Use .NET 8.0 runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime  # Changed from 6.0 to 8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Tarea3.dll"]
