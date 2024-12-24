// src/App.js
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import NavBar from './components/NavBar';
import Footer from './components/Footer';
import HeroSection from './components/Home/HeroSection';
// import FeaturedServices from './components/Home/FeaturedServices'; // Unused
// import Testimonials from './components/Home/Testimonials'; // Unused
import CompanyInfo from './components/AboutUs/CompanyInfo';
import TeamMembers from './components/AboutUs/TeamMembers';
import ServicesList from './components/Services/ServicesList';
import ServiceDetails from './components/Services/ServiceDetails';
import BookingForm from './components/Booking/BookingForm';
import ProductList from './components/Store/ProductList';
import ProductDetails from './components/Store/ProductDetails';
import ShoppingCart from './components/Store/ShoppingCart';
import CheckoutForm from './components/Store/CheckoutForm';
import ContactForm from './components/ContactUs/ContactForm';
import ContactInfo from './components/ContactUs/ContactInfo';

const App = () => (
  <Router>
    <Header />
    <NavBar />
    <Routes>
      <Route path="/" element={<HeroSection />} />
      <Route path="/about" element={<>
        <CompanyInfo />
        <TeamMembers />
      </>} />
      <Route path="/services" element={<ServicesList />} />
      <Route path="/services/:id" element={<ServiceDetails />} />
      <Route path="/booking" element={<BookingForm />} />
      <Route path="/store" element={<ProductList />} />
      <Route path="/store/:id" element={<ProductDetails />} />
      <Route path="/cart" element={<ShoppingCart />} />
      <Route path="/checkout" element={<CheckoutForm />} />
      <Route path="/contact" element={<>
        <ContactForm />
        <ContactInfo />
      </>} />
    </Routes>
    <Footer />
  </Router>
);

export default App;
