// src/components/NavBar.js
import React from 'react';
import { Link } from 'react-router-dom';

const NavBar = () => (
  <nav>
    <ul>
      <li><Link to="/">Home</Link></li>
      <li><Link to="/about">About Us</Link></li>
      <li><Link to="/services">Services</Link></li>
      <li><Link to="/booking">Booking</Link></li>
      <li><Link to="/store">Store</Link></li>
      <li><Link to="/contact">Contact Us</Link></li>
    </ul>
  </nav>
);

export default NavBar;
