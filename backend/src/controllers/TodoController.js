import prisma from "../utils/prisma.js";

export const createTodo = async (req, res) => {
    const {title, description} = req.body;
    try {
        const todo = await prisma.todo.create({
            data: {
                title: title,
                description: description
            }
        });
        res.status(201).send({
            success: true,
            message: 'Todo created successfully',
            data: todo
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
            error: e
        })
    }
}

export const getTodo = async (req, res) => {
    try {
        const todo = await prisma.todo.findMany({});
        res.status(200).send({
            success: true,
            message: 'Todo gets successfully',
            data: todo
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
            error: e
        })
    }
}

export const updateTodo = async (req, res) => {
    const {id} = req.params;
    const {title, description} = req.body;
    try {
        const todo = await prisma.todo.update({
            where: {id: Number(id)},
            data: {
                title: title,
                description: description
            }
        });
        res.status(201).send({
            success: true,
            message: 'Todo update successfully',
            data: todo
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: e.message,
            error: e
        })
    }
}
export const deleteTodo = async (req, res) => {
    const {id} = req.params;
    try {
        const todo = await prisma.todo.delete({
            where: {id: Number(id)},
        });
        res.status(200).send({
            success: true,
            message: 'Todo deleted successfully',
            data: todo
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
            error: e
        })
    }
}