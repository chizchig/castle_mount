const express = require('express');
const router = express.Router();
const Service = require('../models/Service');

// Create a new service
router.post('/', async (req, res) => {
    try {
        const newService = new Service(req.body);
        const savedService = await newService.save();
        res.status(201).json(savedService);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Get all services
router.get('/', async (req, res) => {
    try {
        const services = await Service.find();
        res.status(200).json(services);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
