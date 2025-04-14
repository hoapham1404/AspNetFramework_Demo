using System.Linq;
using System.Web.Mvc;
using WebApplication1.Models;
using System.Net;
using System.Threading.Tasks;
using System.Data.Entity;

namespace WebApplication1.Controllers
{
    public class ProductsController : Controller
    {
        private ProductModel context = new ProductModel();
        
        public async Task<ActionResult> Index()
        {
            var products = await context.Products.ToListAsync();
            return View(products);
        }

        public async Task<ActionResult> Details(int? id)
        {
            if (id is null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            Product product = await context.Products.FindAsync(id);
            return View(product);
        }
    }
}