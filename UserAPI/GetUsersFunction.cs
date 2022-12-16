using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System;
using System.Linq;

namespace UserAPI;

public class GetUsersFunction
{
    private readonly ApplicationDbContext _dbContext;

    public GetUsersFunction(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    [FunctionName("GetUsers")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "get", Route = null)] HttpRequest req,
        ILogger log)
    {
        string json = string.Empty;

        if (req.Query.TryGetValue("skip", out var skipText))
        {
            int skip = int.Parse(skipText);

            int take = 0;
            if (req.Query.TryGetValue("take", out var takeText))
            {
                take = int.Parse(takeText);
            }
            take = Math.Max(take, 0);

            var res = await _dbContext.Users
                .OrderBy(u => u.Id)
                .Skip(skip)
                .Take(take)
                .ToListAsync();

            json = JsonConvert.SerializeObject(res);
        }
        else
        {
            var data = await _dbContext.Users.ToListAsync();
            json = JsonConvert.SerializeObject(data);
        }

        return new OkObjectResult(json);
    }
}
