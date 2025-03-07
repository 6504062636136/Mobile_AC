const express = require('express');
const router = express.Router();
const Skincare = require('../Model/skincare'); // เปลี่ยนจาก Product เป็น Skincare

router.post('/create', async (req, res) => {
    console.log(req.body); // Debugging input

    try {
        const newSkincare = new Skincare(req.body); // ใช้โมเดล Skincare
        const savedSkincare = await newSkincare.save(); // บันทึกลงฐานข้อมูล

        res.status(201).json(savedSkincare); // ส่งข้อมูลกลับ
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
});

module.exports = router;
