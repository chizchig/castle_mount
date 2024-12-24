// src/components/Home/FeaturedServices.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const FeaturedServices = () => {
  const [services, setServices] = useState([]);

  useEffect(() => {
    axios.get('/api/services/featured')
      .then(response => setServices(response.data))
      .catch(error => console.error('Error fetching featured services:', error));
  }, []);

  return (
    <section>
      <h2>Featured Services</h2>
      <ul>
        {services.map(service => (
          <li key={service.id}>{service.name}</li>
        ))}
      </ul>
    </section>
  );
};

export default FeaturedServices;
