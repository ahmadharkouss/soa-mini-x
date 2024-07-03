const express = require('express');
const router = express.Router();
const { createRoom, getRooms, getRoomById, updateRoomById, deleteRoomById } = require('../../../../services/Room/room.crud.service');

// Middleware that is specific to this router
const timeLog = (req, res, next) => {
    console.log('Time: ', Date.now());
    next();
};
router.use(timeLog);

/**
 * @swagger
 * components:
 *   schemas:
 *     Room:
 *       type: object
 *       required:
 *         - name
 *       properties:
 *         id:
 *           type: string
 *           description: The auto-generated id of the room
 *         name:
 *           type: string
 *           description: The name of the room
 *       example:
 *         id: d5fE_asz
 *         name: Conference Room
 */

/**
 * @swagger
 * tags:
 *   name: Rooms
 *   description: The room managing API
 */

/**
 * @swagger
 * /rooms:
 *   post:
 *     summary: Create a new room
 *     tags: [Rooms]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Room'
 *     responses:
 *       200:
 *         description: The room was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Room'
 *       500:
 *         description: Some server error
 */
router.post('/', async (req, res, next) => {
    const { name } = req.body;
    try {
        if (!name) {
            return res.status(404).json({ message: 'Name is required' });
        }
        const room = await createRoom(name);
        res.json(room);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /rooms:
 *   get:
 *     summary: Returns the list of all the rooms
 *     tags: [Rooms]
 *     responses:
 *       200:
 *         description: The list of the rooms
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Room'
 */
router.get('/', async (req, res) => {
    const rooms = await getRooms();
    res.json(rooms);
});

/**
 * @swagger
 * /rooms/{id}:
 *   get:
 *     summary: Get the room by id
 *     tags: [Rooms]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The room id
 *     responses:
 *       200:
 *         description: The room description by id
 *         contents:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Room'
 *       404:
 *         description: The room was not found
 */
router.get('/:id', async (req, res, next) => {
    const { id } = req.params;
    try {
        const room = await getRoomById(id);
        res.json(room);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /rooms/{id}:
 *   put:
 *     summary: Update the room by the id
 *     tags: [Rooms]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The room id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Room'
 *     responses:
 *       200:
 *         description: The room was updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Room'
 *       404:
 *         description: The room was not found
 *       500:
 *         description: Some error happened
 */
router.put('/:id', async (req, res, next) => {
    const { id } = req.params;
    const { name } = req.body;
    try {
        const room = await updateRoomById(id, name);
        res.json(room);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /rooms/{id}:
 *   delete:
 *     summary: Remove the room by id
 *     tags: [Rooms]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The room id
 *     responses:
 *       200:
 *         description: The room was deleted
 *       404:
 *         description: The room was not found
 */
router.delete('/:id', async (req, res, next) => {
    const { id } = req.params;
    try {
        await deleteRoomById(id);
        res.json({ message: 'Room deleted successfully' });
    } catch (error) {
        next(error);
    }
});

module.exports = router;