import { useState, useEffect } from "react";
import axios from "axios";

function App() {
  const [todos, setTodos] = useState([]);
  const [title, setTitle] = useState("");

  useEffect(() => { fetchTodos(); }, []);

  const fetchTodos = async () => {
    const res = await axios.get("http://localhost:8000/api/todos/");
    setTodos(res.data);
  };

  const addTodo = async () => {
    if (!title) return;
    await axios.post("http://localhost:8000/api/todos/", { title, completed: false });
    setTitle(""); fetchTodos();
  };

  const toggleTodo = async (todo) => {
    await axios.patch(`http://localhost:8000/api/todos/${todo.id}/`, { completed: !todo.completed });
    fetchTodos();
  };

  const deleteTodo = async (id) => {
    await axios.delete(`http://localhost:8000/api/todos/${id}/`);
    fetchTodos();
  };

  return (
    <div style={{ margin: "20px" }}>
      <h1>Todo App</h1>
      <input value={title} onChange={e => setTitle(e.target.value)} />
      <button onClick={addTodo}>Add</button>
      <ul>
        {todos.map(todo => (
          <li key={todo.id}>
            <span style={{ textDecoration: todo.completed ? "line-through" : "" }}
                  onClick={() => toggleTodo(todo)}>
              {todo.title}
            </span>
            <button onClick={() => deleteTodo(todo.id)}>❌</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;

