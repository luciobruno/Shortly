import { Router } from "express";
import { signin, signup } from "../controllers/users.controllers.js";
import { validateSchema } from "../middlewares/validateSchema.middleware.js";
import { userSchema, userSigninSchema } from "../schemas/users.schemas.js";

const usersRouter = Router()

usersRouter.post("/signup", validateSchema(userSchema), signup)
usersRouter.post("/signin", validateSchema(userSigninSchema), signin)

export default usersRouter