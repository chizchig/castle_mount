// src/components/ContactUs/ContactInfo.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ContactInfo = () => {
  const [info, setInfo] = useState({});

  useEffect(() => {
    axios.get('/api/contact-info')
      .then(response => setInfo(response.data))
      .catch(error => console.error('Error fetching contact info:', error));
  }, []);

  return (
    <section>
      <h2>Contact Information</h2>
      <p>Phone: {info.phone}</p>
      <p>Email: {info.email}</p>
      <p>Address: {info.address}</p>
    </section>
  );
};

export default ContactInfo;
