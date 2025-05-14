# Stage 1: Build the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy project files
COPY Tarea3/Tarea3/Tarea3.csproj .
COPY Tarea3/Tarea3/ .

# Restore dependencies and publish
RUN dotnet restore
RUN dotnet publish -c Release -o /app

# Stage 2: Run the app
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app .

# Expose port 80 (HTTP) and 443 (HTTPS)
EXPOSE 80
EXPOSE 443

# Start the app
ENTRYPOINT ["dotnet", "Tarea3.dll"]
