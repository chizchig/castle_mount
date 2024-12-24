// src/components/Home/Testimonials.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Testimonials = () => {
  const [testimonials, setTestimonials] = useState([]);

  useEffect(() => {
    axios.get('/api/testimonials')
      .then(response => setTestimonials(response.data))
      .catch(error => console.error('Error fetching testimonials:', error));
  }, []);

  return (
    <section>
      <h2>Testimonials</h2>
      <ul>
        {testimonials.map(testimonial => (
          <li key={testimonial.id}>{testimonial.message}</li>
        ))}
      </ul>
    </section>
  );
};

export default Testimonials;
