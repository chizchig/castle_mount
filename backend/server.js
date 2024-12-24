const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5001;

// Log the MongoDB URI (with credentials redacted)
console.log('MONGODB_URI:', process.env.MONGODB_URI.replace(/\/\/.*:.*@/, '//[REDACTED]:[REDACTED]@'));

// Middleware
app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('MongoDB connected'))
  .catch(err => {
    console.error('MongoDB connection error:', err);
    console.error('Connection string:', process.env.MONGODB_URI.replace(/\/\/.*:.*@/, '//[REDACTED]:[REDACTED]@'));
  });

// Routes
// Commented out until the auth route is created
// app.use('/api/auth', require('./routes/auth'));
app.use('/api/bookings', require('./routes/bookings'));
app.use('/api/contacts', require('./routes/contacts'));
app.use('/api/products', require('./routes/products'));
app.use('/api/services', require('./routes/services'));

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
