const express = require('express');
const router = express.Router();
const { createUser, getUsers, getUserById, updateUserById, deleteUserById } = require('../../../../services/User/user.crud.service');


const session = require('express-session');
const bodyParser = require('body-parser');
const Keycloak = require('keycloak-connect');

const memoryStore = new session.MemoryStore();

const app = express();

router.use(session({
    secret: 'thisShouldBeLongAndSecret',
    resave: false,
    saveUninitialized: true,
    store: memoryStore
}));

const keycloak = new Keycloak({ store: memoryStore }, './src/configs/keycloak-config.json');

app.use(bodyParser.json());
app.use(keycloak.middleware());

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
 *         id:
 *           type: string
 *           description: The auto-generated id of the user
 *         name:
 *           type: string
 *           description: The name of the user
 *         alias:
 *           type: string
 *           description: The alias of the user
 *       example:
 *         id: d5fE_asz
 *         name: John Doe
 *         alias: johnd
 */

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: The user managing API
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
router.post('/', keycloak.protect(), async (req, res, next) => {
    const { name, alias } = req.body;
    try {
        if (!name || !alias) {
            return res.status(404).json({ message: 'Name and alias are required' });
        }
        const user = await createUser(name, alias);
        
        // Exclude the updatedAt field from the returned user object
        const { updatedAt, ...userWithoutUpdatedAt } = user.toJSON ? user.toJSON() : user;

        res.json(userWithoutUpdatedAt);
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Returns the list of all the users
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: The list of the users
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/User'
 */
router.get('/', keycloak.protect(), async (req, res) => {
    const users = await getUsers();
    res.json(users);
});

/**
 * @swagger
 * /users/{id}:
 *   get:
 *     summary: Get the user by id
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The user id
 *     responses:
 *       200:
 *         description: The user description by id
 *         contents:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       404:
 *         description: The user was not found
 */
router.get('/:id', keycloak.protect(), async (req, res, next) => {
    const { id } = req.params;
    try {
        const user = await getUserById(id);
        res.json(user);
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
 *           type: string
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
router.put('/:id', keycloak.protect(), async (req, res, next) => {
    const { id } = req.params;
    const { name, alias } = req.body;
    try {
        const user = await updateUserById(id, name, alias);
        res.json(user);
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
 *           type: string
 *         required: true
 *         description: The user id
 *     responses:
 *       200:
 *         description: The user was deleted
 *       404:
 *         description: The user was not found
 */
router.delete('/:id', keycloak.protect(), async (req, res, next) => {
    const { id } = req.params;
    try {
        await deleteUserById(id);
        res.json({ message: 'User deleted successfully' });
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});

module.exports = router;
