const express = require('express');
const router = express.Router();
const { createRoom, getRooms, getRoomById,
} = require('../../../../services/Room/room.crud.service');

const { getUsersInRoom 
  } = require('../../../../services/user-room.service');

// Middleware that is specific to this router
const timeLog = (req, res, next) => {
    console.log('Time: ', Date.now());
    next();
};
router.use(timeLog);



/**
 * @swagger
 * tags:
 *   name: Rooms
 *   description: The room managing API
 */

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
 * components:
 *   schemas:
 *     Room2:
 *       type: object
 *       required:
 *         - name
 *         - createdBy
 *       properties:
 *         name:
 *           type: string
 *           description: The name of the room
 *         createdBy:
 *           type: string
 *           description: The ID of the user who creates the room and will be assigned as admin
 *       example:
 *         name: Conference Room
 *         createdBy: "1"
 */

/**
 * @swagger
 * /rooms:
 *   post:
 *     summary: Create a new room and assign the creator as the admin
 *     tags: [Rooms]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Room2'
 *     responses:
 *       200:
 *         description: The room was successfully created, and the creator was assigned as the admin
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Room'
 *       400:
 *         description: Name or createdBy is required
 *       500:
 *         description: Some server error
 */

router.post('/', async (req, res, next) => {
    const { name, createdBy } = req.body;

    try {
        if (!name || !createdBy) {
            return res.status(400).json({ message: 'Name and createdBy are required' });
        }
        const room = await createRoom(name, createdBy);
        const { updatedAt, ...roomWithoutUpdatedAt } = room.toJSON ? room.toJSON() : room;
        res.status(200).json(roomWithoutUpdatedAt, { message: 'Room created successfully' });
    } catch (error) {
        if (error.message.includes('User not found')) {
            res.status(404).json({ message: 'User not found' });
        } else {
            next(error);
        }
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
    res.status(200).json(rooms);
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
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Room'
 *       404:
 *         description: The room was not found
 */
router.get('/:id', async (req, res, next) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ message: 'Invalid room ID provided' });
    }
    try {
        const room = await getRoomById(id);
        if (!room) {
            return res.status(404).json({ message: 'Room not found' });
        }
        res.status(200).json(room);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * components:
 *   schemas:
 *     UserInRoom:
 *       type: object
 *       required:
 *         - userId
 *         - userName
 *         - role
 *       properties:
 *         userId:
 *           type: string
 *           description: The unique identifier of the user
 *         userName:
 *           type: string
 *           description: The name of the user
 *         role:
 *           type: string
 *           description: The role of the user in the room
 *       example:
 *         userId: '12345'
 *         userName: 'John Doe'
 *         role: 'admin'
 *
 * /rooms/{roomId}/users_with_roles:
 *   get:
 *     summary: Get all users with their roles in a specified room
 *     tags: [RTL]
 *     parameters:
 *       - in: path
 *         name: roomId
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the room for which to fetch users
 *     responses:
 *       200:
 *         description: A list of users in the room
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/UserInRoom'
 *       400:
 *         description: Invalid room ID provided
 *       404:
 *         description: Room not found
 *       500:
 *         description: Server error
 */
router.get('/:roomId/users_with_roles', async (req, res) => {
    const { roomId } = req.params;

    if (!roomId) {
        return res.status(400).json({ message: 'Invalid room ID provided' });
    }
    const room = await getRoomById(roomId);
    if (!room) {
        return res.status(404).json({ message: 'Room not found' });
    }
    try {
        const users = await getUsersInRoom(roomId);
        res.status(200).json(users);
    } catch (error) {
            res.status(404).json({ message: error.message });
        
            res.status(500).json({ message: error.message });
    
    }
});





module.exports = router;
