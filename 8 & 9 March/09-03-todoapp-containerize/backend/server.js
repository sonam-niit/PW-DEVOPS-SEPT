const express = require('express');
const mongoose= require('mongoose');
require('dotenv').config()

const app = express(); //server
app.use(express.json()); //reading JSON

mongoose.connect(process.env.MONGO_URI)
.then(()=>console.log('DB Connected...!!!'))
.catch((e)=>console.log('Error in connection',e))

app.use('/api/todo',require('./routes/todoRoutes'));
app.listen(5000,()=>console.log('server is running on PORT 5000'))