const express = require('express');
const router = express.Router();
const Contact = require('../models/Contact');

// Create a new contact message
router.post('/', async (req, res) => {
    try {
        const newContact = new Contact(req.body);
        const savedContact = await newContact.save();
        res.status(201).json(savedContact);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Get all contact messages
router.get('/', async (req, res) => {
    try {
        const contacts = await Contact.find();
        res.status(200).json(contacts);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
