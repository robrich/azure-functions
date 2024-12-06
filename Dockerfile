# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/azure-functions/dotnet-isolated:4-dotnet-isolated8.0 AS base
WORKDIR /home/site/wwwroot
EXPOSE 80


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY FunctionAppContainer.sln .
COPY FunctionAppContainer.csproj .
RUN dotnet restore FunctionAppContainer.csproj

COPY . .
RUN dotnet build FunctionAppContainer.csproj -c Release
RUN dotnet publish FunctionAppContainer.csproj -c Release -o /dist/func
#/p:UseAppHost=false


# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /home/site/wwwroot
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true
ENV MySetting=""
COPY --from=build /dist/func .
