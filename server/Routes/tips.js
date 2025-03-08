const tips = require('../Model/tips');
const express = require('express');
const router = express.Router();


router.get('/', async (req, res) => {
  try {
      const allTips = await tips.find({});
      res.json(allTips);
  } catch (err) {
    console.error("Error fetching tips:", err);
      res.status(500).json({ message: "Internal Server Error" });
  }
});


router.post('/create', async (req, res) => {
    console.log(req.body);

  try {
    const newTip = await tips(req.body).save(); 

    res.send(newTip);

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

module.exports = router;
