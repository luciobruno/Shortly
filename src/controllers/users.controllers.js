import { db } from "../database/database.connection.js";
import bcrypt from "bcrypt"
import { v4 as uuid } from "uuid"

export async function signup(req, res) {

    const { name, email, password, confirmPassword } = req.body

    try {

        const user = await db.query(`SELECT * FROM users WHERE email=$1;`, [email])

        if (user.rowCount !== 0) {
            return res.sendStatus(409)
        }

        if (password !== confirmPassword) {
            return res.sendStatus(422)
        }

        const hash = bcrypt.hashSync(password, 10)

        await db.query(`INSERT INTO users (name, email, password) VALUES ($1,$2,$3);`, [name, email, hash])

        res.sendStatus(201)

    } catch (err) {
        res.status(500).send(err.message)
    }

}

export async function signin(req, res) {
    const { email, password } = req.body

    try {

        const user = await db.query(`SELECT users.* FROM users WHERE users.email=$1;`, [email])

        if (user.rowCount === 0) {
            return res.sendStatus(401)
        }

        const correctPassword = bcrypt.compareSync(password, user.rows[0].password)

        if (user.rows[0].email !== email || !correctPassword) {
            return res.sendStatus(401)
        }

        const token = uuid()

        await db.query(`INSERT INTO sessions (token, "userId") VALUES ($1,$2);`, [token, user.rows[0].id])

        res.status(200).send({ token: token })

    } catch (err) {
        res.status(500).send(err.message)
    }
}