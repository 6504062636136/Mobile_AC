const product = require('../Model/product')
const express = require('express')
const router = express.Router()

router.post('/create', async (req, res) => {
    console.log(req.body);

  try {
    const producted = await product(req.body).save();

    res.send(producted);

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

module.exports = router