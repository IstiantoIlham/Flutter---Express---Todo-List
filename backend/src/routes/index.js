import {Router} from 'express';
import todoRouter from "./TodoRoute.js";

const router = Router();

router.use('/api', todoRouter);

export default router;