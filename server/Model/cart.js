//แก้ไข
const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
    name: { type: String, ref: 'Bestseller', required: true },
    quantity: { type: Number, required: true, min: 1 },
    price:{
        type: Number,
    },
    type: {
        type: String,
    },
    image:{
        type: String,
    },

},

{ timestamps: true });



module.exports = mongoose.model('Cart', cartSchema);
