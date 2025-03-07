

const mongoose = require('mongoose');


const productSchema = new mongoose.Schema({
    name: String,
    details: {
        type : String,

    },
    price:{
        type: Number,
    },
    type: {
        type: String,
    },
    image:{
        type: String,
    }
}, {timestamps: true})

module.exports = mongoose.model('Product', productSchema)