using FunctionAppContainer;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;


FunctionsApplicationBuilder builder = FunctionsApplication.CreateBuilder(args);

/*
string? env = Environment.GetEnvironmentVariable("AZURE_FUNCTIONS_ENVIRONMENT");
if (!string.IsNullOrEmpty(env))
{
	builder.UseEnvironment(env);
}
*/

builder.ConfigureFunctionsWebApplication();

AppSettings appSettings = new();
builder.Configuration.Bind(appSettings);
appSettings.EnvironmentName = builder.Environment.EnvironmentName;
appSettings.FunctionsEnvironmentName = Environment.GetEnvironmentVariable("AZURE_FUNCTIONS_ENVIRONMENT");
builder.Services.AddSingleton(appSettings);

IHost app = builder.Build();

app.Run();
