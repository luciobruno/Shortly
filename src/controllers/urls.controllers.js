import { db } from "../database/database.connection.js";
import { nanoid } from 'nanoid'

export async function shorten(req, res) {

    const { url } = req.body
    const { authorization } = req.headers
    const token = authorization?.replace("Bearer ", "")

    try {

        const user = await db.query(`SELECT * FROM sessions WHERE token=$1;`, [token])
        const shortUrl = nanoid(15)
        const id = user.rows[0].userId

        await db.query(`INSERT INTO "shortUrls" (name,url,"userId") VALUES ($1,$2,$3);`, [shortUrl, url, id])

        const finalUrl = await db.query(`SELECT * FROM "shortUrls" WHERE name=$1;`, [shortUrl])

        const result = {
            id: finalUrl.rows[0].id,
            shortUrl: shortUrl
        }

        res.status(201).send(result)

    } catch (err) {
        res.status(500).send(err.message)
    }

}

export async function shortUrls(req, res) {
    const { id } = req.params

    try {

        const shortUrl = await db.query(`SELECT * FROM "shortUrls" WHERE id=$1;`, [id])

        if (shortUrl.rowCount === 0) {
            return res.sendStatus(404)
        }

        const result = {
            id: id,
            shortUrl: shortUrl.rows[0].name,
            url: shortUrl.rows[0].url
        }

        res.status(200).send(result)

    } catch (err) {
        res.status(500).send(err.message)
    }
}

export async function openShortUrl(req, res) {
    const { shortUrl } = req.params

    try {

        const url = await db.query(`SELECT "shortUrls".url FROM "shortUrls" WHERE name=$1;`, [shortUrl])

        if (url.rowCount === 0) {
            return res.sendStatus(404)
        }

        const result = url.rows[0].url

        res.redirect(result)

    } catch (err) {
        res.status(500).send(err.message)
    }
}

export async function deleteShortUrl(req, res) {

    const { id } = req.params

    const { authorization } = req.headers
    const token = authorization?.replace("Bearer ", "")

    try {

        const user = await db.query(`SELECT * FROM sessions WHERE token=$1;`, [token])

        const url = await db.query(`SELECT * FROM "shortUrls" WHERE id=$1;`, [id])

        if (url.rowCount === 0) {
            return res.sendStatus(404)
        }

        if (url.rows[0].userId !== user.rows[0].id) {
            return res.sendStatus(401)
        }

        await db.query(`DELETE FROM "shortUrls" WHERE id=$1`, [id])

        res.sendStatus(204)

    } catch (err) {
        res.status(500).send(err.message)
    }
}