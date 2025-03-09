import { useState } from "react";
import axios from 'axios';

function TodoForm({setTodos,todos}) {
    const [text, setText] = useState('');
    const addtodo=async(e)=>{
        e.preventDefault();
        const resp= await axios.post('http://localhost:5000/api/todo',{text});
        if(resp.status==201){
            alert('Todo Added');
            setText('');
            setTodos([...todos,{text,completed:false}])
        }
    }
    return (
        <form onSubmit={addtodo}>
            <input type="text"
                onChange={(e) => setText(e.target.value)}
                value={text} 
                placeholder="Enter Your Todo"
            />
            <button type="submit">Add</button>
        </form>
    );
}

export default TodoForm;