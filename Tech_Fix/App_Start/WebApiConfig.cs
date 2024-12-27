using System.Web.Http;

namespace Tech_Fix.App_Start
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Enable attribute routing
            config.MapHttpAttributeRoutes();

            // Define the default route for Web API
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            // Optionally, configure JSON formatter to return data in camelCase
            var jsonFormatter = config.Formatters.JsonFormatter;
            jsonFormatter.SerializerSettings.ContractResolver = new Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver();

            // Optionally, remove XML formatter if you only want to return JSON
            config.Formatters.Remove(config.Formatters.XmlFormatter);

            // Other Web API configuration can be added here as needed
        }
    }
}
