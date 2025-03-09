function TodoList({todos}) {
    
    return ( 
        <div>
            <ul>
                {
                    todos.map((todo,index)=>(
                        <li key={index}>{todo.text}</li>
                    ))
                }
            </ul>
        </div>
     );
}

export default TodoList;