const express = require('express')

const app = express()
app.get('/hello',(req,res)=>{
    res.json({message: 'Hello From Sonam Soni'})
})
app.get('/about',(req,res)=>{
    res.json({message: 'About Us'})
})
app.get('/contact',(req,res)=>{
    res.json({message: 'Contact Us'})
})

module.exports = app

