const express =require('express');
const app= express();

app.get('/',(req,res)=>{
    res.send('Hello From Server')
})

app.listen(5000,()=>console.log('server started'))