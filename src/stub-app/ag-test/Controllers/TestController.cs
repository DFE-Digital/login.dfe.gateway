using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace ag_test.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TestController : ControllerBase
    {
        private readonly IConfiguration _config;
        public TestController(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet]
        public string Get()
        {
            string site = _config.GetSection("Ident")["Name"];
            return $"I Am {site}";
        }
    }
}
