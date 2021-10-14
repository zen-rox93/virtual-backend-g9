import {Router} from 'express'

import * as usuarioController from '../controllers/usuario.controller'

export const usuarioRouter = Router();

usuarioRouter.post("/registro", usuarioController.registroController);

export default usuarioRouter;