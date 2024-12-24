// src/components/ContactUs/ContactForm.js
import React, { useState } from 'react';
import axios from 'axios';

const ContactForm = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: ''
  });
  const [confirmation, setConfirmation] = useState(null);

  const handleChange = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = e => {
    e.preventDefault();
    axios.post('/api/contact', formData)
      .then(response => setConfirmation(response.data))
      .catch(error => console.error('Error submitting contact form:', error));
  };

  return (
    <section>
      <h2>Contact Us</h2>
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
          Message:
          <textarea name="message" value={formData.message} onChange={handleChange}></textarea>
        </label>
        <button type="submit">Submit</button>
      </form>
      {confirmation && <p>Message Sent: {confirmation.message}</p>}
    </section>
  );
};

export default ContactForm;
