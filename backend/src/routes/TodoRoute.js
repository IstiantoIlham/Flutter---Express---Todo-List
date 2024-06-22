import {Router} from "express";
import {createTodo, deleteTodo, getTodo, updateTodo} from "../controllers/TodoController.js";

const todoRouter = Router();

todoRouter.get('/todos', getTodo);
todoRouter.post('/todos', createTodo);
todoRouter.put('/todos/:id', updateTodo);
todoRouter.delete('/todos/:id', deleteTodo);

export default todoRouter;