// src/components/Booking/BookingForm.js
import React, { useState } from 'react';
import axios from 'axios';

const BookingForm = () => {
  const [formData, setFormData] = useState({
    service: '',
    date: '',
    time: '',
    name: '',
    email: '',
  });
  const [confirmation, setConfirmation] = useState(null);

  const handleChange = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = e => {
    e.preventDefault();
    axios.post('/api/booking', formData)
      .then(response => setConfirmation(response.data))
      .catch(error => console.error('Error submitting booking:', error));
  };

  return (
    <section>
      <h2>Book a Massage</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Select Massage Type:
          <select name="service" value={formData.service} onChange={handleChange}>
            {/* Options should be dynamically loaded from the backend */}
            <option value="swedish">Swedish Massage</option>
            <option value="deep-tissue">Deep Tissue Massage</option>
          </select>
        </label>
        <label>
          Date:
          <input type="date" name="date" value={formData.date} onChange={handleChange} />
        </label>
        <label>
          Time:
          <input type="time" name="time" value={formData.time} onChange={handleChange} />
        </label>
        <label>
          Name:
          <input type="text" name="name" value={formData.name} onChange={handleChange} />
        </label>
        <label>
          Email:
          <input type="email" name="email" value={formData.email} onChange={handleChange} />
        </label>
        <button type="submit">Submit</button>
      </form>
      {confirmation && <p>Booking Confirmed: {confirmation.message}</p>}
    </section>
  );
};

export default BookingForm;
