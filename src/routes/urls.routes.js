import { Router } from "express";
import { openShortUrl, shortUrls, shorten } from "../controllers/urls.controllers.js";
import { validateSchema } from "../middlewares/validateSchema.middleware.js";
import { urlSchema } from "../schemas/urls.schemas.js";
import { authorizationValidation } from "../middlewares/authorization.middleware.js";

const urlsRouter = Router()

urlsRouter.post("/urls/shorten", [authorizationValidation, validateSchema(urlSchema)], shorten)
urlsRouter.get("/urls/:id", shortUrls)
urlsRouter.get("/urls/open/:shortUrl", openShortUrl)

export default urlsRouter