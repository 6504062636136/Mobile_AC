const mongoose = require('mongoose')

const connectDB = () => {
    try {
        mongoose.connect('mongodb+srv://s6504062636136:EFxLw1B7PJZnm6tv@cluster0.cu6l1.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0',
        {useNewUrlParser: true,useUnifiedTopology: true})      
        console.log('MongoDB is connected')
    } catch (err){
        console.log(err)
    }
}

module.exports = connectDB

