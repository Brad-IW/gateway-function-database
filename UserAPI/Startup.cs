using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using UserAPI;

[assembly: FunctionsStartup(typeof(Startup))]

namespace UserAPI;

public class Startup : FunctionsStartup
{
    public override void Configure(IFunctionsHostBuilder builder)
    {
        var connectionString = Environment.GetEnvironmentVariable("SqlConnectionString", EnvironmentVariableTarget.Process);

        if (connectionString is null)
        {
            throw new Exception("Failed to get database string!");
        }

        builder.Services.AddDbContext<ApplicationDbContext>(
            options => SqlServerDbContextOptionsExtensions.UseSqlServer(options, connectionString));
    }   
}
