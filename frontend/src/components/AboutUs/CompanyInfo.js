// src/components/AboutUs/CompanyInfo.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const CompanyInfo = () => {
  const [info, setInfo] = useState('');

  useEffect(() => {
    axios.get('/api/company-info')
      .then(response => setInfo(response.data))
      .catch(error => console.error('Error fetching company info:', error));
  }, []);

  return (
    <section>
      <h2>About Us</h2>
      <p>{info}</p>
    </section>
  );
};

export default CompanyInfo;
