const express = require('express');
const router = express.Router();
const { createUser, getUsers, getUserById, updateUserById, deleteUserById } = require('../../../../services/User/user.crud.service');


const session = require('express-session');
const bodyParser = require('body-parser');

/*
const Keycloak = require('keycloak-connect');

const memoryStore = new session.MemoryStore();

router.use(session({
    secret: 'thisShouldBeLongAndSecret',
    resave: false,
    saveUninitialized: true,
    store: memoryStore
}));

const keycloak = new Keycloak({ store: memoryStore }, './src/configs/keycloak-config.json');
router.use(keycloak.middleware());
*/


router.use(bodyParser.json());
// Middleware that is specific to this router
const timeLog = (req, res, next) => {
    console.log('Time: ', Date.now());
    next();
};
router.use(timeLog);

// Swagger definitions for Bearer token authentication
/**
 * @swagger
 * components:
 *   securitySchemes:
 *     bearerAuth:
 *       type: http
 *       scheme: bearer
 *       bearerFormat: JWT
 *   schemas:
 *     User:
 *       type: object
 *       required:
 *         - name
 *         - alias
 *       properties:
 *         name:
 *           type: string
 *           description: The name of the user
 *         alias:
 *           type: string
 *           description: The alias of the user
 *       example:
 *         name: John Doe
 *         alias: johnd
 */

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: The user Transaction API
 */

/**
 * @swagger
 * /users:
 *   post:
 *     summary: Create a new user
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: The user was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       500:
 *         description: Some server error
 */
router.post('/', async (req, res, next) => {
    const { name, alias } = req.body;
    try {
        if (!name || !alias) {
            return res.status(404).json({ message: 'Name and alias are required' });
        }
        const user = await createUser(name, alias);
        
        // Exclude the updatedAt field from the returned user object
        const { updatedAt, ...userWithoutUpdatedAt } = user.toJSON ? user.toJSON() : user;

        res.status(200).json(userWithoutUpdatedAt);
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});

/**
 * @swagger
 * /users/{id}:
 *   put:
 *     summary: Update the user by the id
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The user id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: The user was updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       404:
 *         description: The user was not found
 *       500:
 *         description: Some error happened
 */
router.put('/:id', async (req, res, next) => {
    const { id } = req.params;
    const { name, alias } = req.body;
    if (!id)
        return res.status(400).json({ message: 'Bad request, missing fields' });
    if (!name || !alias) {
        return res.status(400).json({ message: 'Name and alias are required' });
    }
    try {
        const user = await updateUserById(id, name, alias);
        res.status(200).json(user);
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});

/**
 * @swagger
 * /users/{id}:
 *   delete:
 *     summary: Remove the user by id
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The user id
 *     responses:
 *       200:
 *         description: The user was deleted
 *       404:
 *         description: The user was not found
 */
router.delete('/:id', async (req, res, next) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }
    try {
        await deleteUserById(id);
        res.status(200).json({ message: 'User deleted successfully' });
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});

module.exports = router;
