using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication1.Models;

namespace WebApplication1.Helpers
{
    public static class CartSessionHelper
    {
        private const string CartKey = "Cart";

        public static List<CartItemViewModel> GetCartItems(HttpSessionStateBase session)
        {
            if (session[CartKey] is null) session[CartKey] = new List<CartItemViewModel>();
            return (List<CartItemViewModel>)session[CartKey];
        }

        public static void AddToCart(HttpSessionStateBase session, CartItemViewModel item)
        {
            var cart = GetCartItems(session);
            var existingItem = cart.FirstOrDefault(i => i.ProductId == item.ProductId);
            if (existingItem != null)
            {
                existingItem.Quantity += item.Quantity;
            }
            else
            {
                cart.Add(item);
            }
            session[CartKey] = cart;

        }

        public static int CountItems(HttpSessionStateBase session)
        {
            var cart = GetCartItems(session);
            return cart.Sum(i => i.Quantity);
        }
    } 
}