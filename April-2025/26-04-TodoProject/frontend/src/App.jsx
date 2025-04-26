import React, { useState, useEffect } from 'react';
import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL;

function App() {
  const [todos, setTodos] = useState([]);
  const [task, setTask] = useState('');

  useEffect(() => {
    console.log(API_URL)
    axios.get(`${API_URL}/todos`).then(res => {console.log(res.data);setTodos(res.data)});
  }, []);

  const addTodo = () => {
    axios.post(`${API_URL}/todos`, { task }).then(res => {
      setTodos([...todos, res.data]);
      setTask('');
    });
  };

  const toggleTodo = (id, completed) => {
    axios.put(`${API_URL}/todos/${id}`, { completed: !completed }).then(res => {
      setTodos(todos.map(t => t._id === id ? res.data : t));
    });
  };

  const deleteTodo = id => {
    axios.delete(`${API_URL}/todos/${id}`).then(() => {
      setTodos(todos.filter(t => t._id !== id));
    });
  };

  return (
    <div className="App">
      <h1>Todo App</h1>
      <input value={task} onChange={e => setTask(e.target.value)} placeholder="Add task..." />
      <button onClick={addTodo}>Add</button>
      <ul>
        {todos.map(todo => (
          <li key={todo._id}>
            <span
              onClick={() => toggleTodo(todo._id, todo.completed)}
              style={{ textDecoration: todo.completed ? 'line-through' : '' }}
            >
              {todo.task}
            </span>
            <button onClick={() => deleteTodo(todo._id)}>❌</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
