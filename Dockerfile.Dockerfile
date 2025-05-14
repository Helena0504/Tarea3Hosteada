# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file first for efficient caching
COPY Tarea3/Tarea3/Tarea3.csproj .
RUN dotnet restore

# Copy remaining files
COPY Tarea3/Tarea3/ .
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Tarea3.dll"]
