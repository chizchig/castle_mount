// src/components/Services/ServicesList.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ServicesList = () => {
  const [services, setServices] = useState([]);

  useEffect(() => {
    axios.get('/api/services')
      .then(response => setServices(response.data))
      .catch(error => console.error('Error fetching services:', error));
  }, []);

  return (
    <section>
      <h2>Our Services</h2>
      <ul>
        {services.map(service => (
          <li key={service.id}>{service.name}</li>
        ))}
      </ul>
    </section>
  );
};

export default ServicesList;
