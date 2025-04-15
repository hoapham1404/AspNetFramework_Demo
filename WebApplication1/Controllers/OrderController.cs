using System.Web.Mvc;
using WebApplication1.Helpers;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class OrderController : Controller
    {
        private readonly ProductModel _context = new ProductModel();

        public PartialViewResult CartCount()
        {
            return PartialView("_CartPartial");
        }
        [HttpPost]
        public ActionResult AddToCart(int productId, int quantity = 1)
        {
            var product = _context.Products.Find(productId);
            if (product == null) return HttpNotFound();

            var item = new CartItemViewModel
            {
                ProductId = product.Id,
                Name = product.Name,
                Price = product.Price ?? 0,
                Quantity = quantity
            };
            CartSessionHelper.AddToCart(Session, item);
            return new HttpStatusCodeResult(200);
        }

        public ActionResult Cart()
        {
            var cart = CartSessionHelper.GetCartItems(Session);
            return View(cart);
        }

    }
}