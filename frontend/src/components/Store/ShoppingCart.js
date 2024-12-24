// src/components/Store/ShoppingCart.js
import React, { useState } from 'react';

const ShoppingCart = () => {
  const [cart] = useState([]);

  return (
    <section>
      <h2>Shopping Cart</h2>
      <ul>
        {cart.map((item, index) => (
          <li key={index}>{item.name} - ${item.price}</li>
        ))}
      </ul>
      <button>Checkout</button>
    </section>
  );
};

export default ShoppingCart;
