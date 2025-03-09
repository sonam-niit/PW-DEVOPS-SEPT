import { useEffect, useState } from 'react'
import axios from 'axios';
import TodoList from './components/TodoList';
import TodoForm from './components/TodoForm';
function App() {
  
  const [todos,setTodos]=useState([]);
  const fetchData=async()=>{
    const resp =await axios.get('http://localhost:5000/api/todo');
    if(resp.status==200){
      setTodos(resp.data);
    }
  }
  useEffect(()=>{
    fetchData()
  },[])
  return (
    <div>
        <TodoList todos={todos} />
        <TodoForm setTodos={setTodos} todos={todos} />
    </div>
  )
}

export default App
