const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const app= express();
const PORT = 5000;

const db= mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
})

db.connect((err)=>{
    if(err){
        console.log(process.env.DB_USER);
        
        console.log('Erron Connecting to MYSQL',err)
    }else{
        console.log('Connected to MYSQL')
    }
})

app.get('/',(req,res)=>{
    res.send('Backend Is Running')
})
app.listen(PORT,()=>{
    console.log('Backend is Running on PORT: '+PORT)
})