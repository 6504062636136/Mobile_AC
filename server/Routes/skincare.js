const express = require('express');
const router = express.Router();
const Skincare = require('../Model/skincare'); 

router.get('/', async (req, res) => {
  try {
      const producted = await product.find({});
      res.json(producted);
  } catch (err) {
    console.error("Error fetching products:", err);
      res.status(500).json({ message: "Internal Server Error" });
  }
});

router.post('/create', async (req, res) => {
    console.log(req.body);

    try {
        const newSkincare = new Skincare(req.body); 
        const savedSkincare = await newSkincare.save(); 

        res.status(201).json(savedSkincare); 
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
});

module.exports = router;
