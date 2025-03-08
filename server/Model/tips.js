const mongoose = require('mongoose');

// สร้าง schema สำหรับ Tips
const tipsSchema = new mongoose.Schema({
    name: String,
    details: {
        type : String,
    },
      image:{
          type: String,
      }
  }, {timestamps: true})

module.exports = mongoose.model('Tips', tipsSchema);
