const express = require('express');
const Todo = require('../models/Todo');
const router= express.Router();

//Add New Todo
router.post('/',async(req,res)=>{
    const {text} = req.body;
    const newTodo= new Todo({text});
    await newTodo.save(); //save todo in database
    res.status(201).json(newTodo);
})
// Get All todos
router.get('/',async(req,res)=>{
    const todos=await Todo.find(); //get all todos from db
    res.status(200).json(todos);
})

//update todo by completing its task
//update completed status from false to true
router.put('/:id',async(req,res)=>{
    const todo= await Todo.findById(req.params.id);
    todo.completed= !todo.completed;
    await todo.save();
    res.status(200).json(todo);//return updated todo
})

//Delete todo
router.delete('/:id',async(req,res)=>{
    await Todo.findByIdAndDelete(req.params.id);
    res.status(200).json({message:"Deleted Successfully"});//return updated todo
})

module.exports = router;