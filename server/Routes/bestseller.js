const express = require('express');
const router = express.Router();
const BestsellerModel = require('../Model/bestseller'); // ใช้ 'Model' ตามที่คุณตั้งไว้

// Get all bestsellers
router.get('/', async (req, res) => {
  try {
    const bestsellers = await BestsellerModel.find({}); // เปลี่ยนชื่อให้ไม่ชนกับตัวแปร
    res.json(bestsellers);
  } catch (err) {
    console.error("Error fetching bestsellers:", err);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

// Create a new bestseller
router.post('/create', async (req, res) => {
  try {
    const newBestseller = new BestsellerModel(req.body); // ใช้ new ก่อนเรียก .save()
    await newBestseller.save();
    res.status(201).json(newBestseller);
  } catch (error) {
    console.error("Error creating bestseller:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

module.exports = router;
