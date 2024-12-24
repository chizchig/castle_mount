// src/components/Services/ServiceDetails.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';

const ServiceDetails = () => {
  const [service, setService] = useState(null);
  const { id } = useParams();

  useEffect(() => {
    axios.get(`/api/services/${id}`)
      .then(response => setService(response.data))
      .catch(error => console.error('Error fetching service details:', error));
  }, [id]);

  if (!service) return <div>Loading...</div>;

  return (
    <section>
      <h2>{service.name}</h2>
      <p>{service.description}</p>
    </section>
  );
};

export default ServiceDetails;
