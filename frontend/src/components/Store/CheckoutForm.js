// src/components/Store/CheckoutForm.js
import React, { useState } from 'react';
import axios from 'axios';

const CheckoutForm = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    address: '',
    paymentMethod: 'credit-card',
  });
  const [confirmation, setConfirmation] = useState(null);

  const handleChange = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = e => {
    e.preventDefault();
    axios.post('/api/checkout', formData)
      .then(response => setConfirmation(response.data))
      .catch(error => console.error('Error processing checkout:', error));
  };

  return (
    <section>
      <h2>Checkout</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Name:
          <input type="text" name="name" value={formData.name} onChange={handleChange} />
        </label>
        <label>
          Email:
          <input type="email" name="email" value={formData.email} onChange={handleChange} />
        </label>
        <label>
          Address:
          <input type="text" name="address" value={formData.address} onChange={handleChange} />
        </label>
        <label>
          Payment Method:
          <select name="paymentMethod" value={formData.paymentMethod} onChange={handleChange}>
            <option value="credit-card">Credit Card</option>
            <option value="paypal">PayPal</option>
          </select>
        </label>
        <button type="submit">Submit</button>
      </form>
      {confirmation && <p>Checkout Confirmed: {confirmation.message}</p>}
    </section>
  );
};

export default CheckoutForm;
