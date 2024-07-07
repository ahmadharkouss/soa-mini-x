const express = require('express');
const router = express.Router();


const {getTickets, getTicketById,ticketEditsHistory, getAllRepliesOfTicket} = require('../../../services/Ticket/ticket.crud.service');
const { getRooms, getRoomById } = require('../../../services/Room/room.crud.service');
const { getUsersInRoom, getUserRoomRoleByIds } = require('../../../services/user-room.service');
const {getUsers, getUserById} = require('../../../services/User/user.crud.service');


// Middleware that is specific to this router
const timeLog = (req, res, next) => {
    console.log('Time: ', Date.now());
    next();
};
router.use(timeLog);



/**
 * @swagger
 * tags:
 *   - name: TicketsGet
 *     description: Public Get Endpoints related to tickets
 *   - name: RoomsGet
 *     description: Public Get Endpoints related to rooms
 *   - name: UsersGet
 *     description: Public Get Endpoints related to users
 */


/**
 * @swagger
 * components:
 *   schemas:
 *     Ticket:
 *       type: object
 *       required:
 *         - roomId
 *         - subject
 *         - content
 *         - isEdited
 *         - createdBy
 *       properties:
 *         roomId:
 *           type: integer
 *           description: The id of the room associated with the ticket
 *         subject:
 *           type: string
 *           description: The subject of the ticket
 *         content:
 *           type: integer
 *           description: The content of the ticket
 *         isEdited:
 *           type: boolean
 *           description: If the ticket has been edited
 *         parentTicket:
 *           type: integer
 *           description: The id of the parent ticket if any
 *         createdBy:
 *           type: integer
 *           description: The id of the user who created the ticket
 *       example:
 *         roomId: 12345
 *         subject: Issue with projector
 *         content: The projector in room 101 is not working.
 *         isEdited: false
 *         parentTicket: null
 *         createdBy: 1
 */
/**
 * @swagger
 * /tickets:
 *   get:
 *     summary: Returns the list of all the tickets
 *     tags: [TicketsGet]
 *     responses:
 *       200:
 *         description: The list of the tickets
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Ticket'
 */
router.get('/tickets', async (req, res) => {
    const tickets = await getTickets();
    res.status(200).json(tickets);
});


/**
 * @swagger
 * /tickets/{id}:
 *   get:
 *     summary: Get the ticket by id
 *     tags: [TicketsGet]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The ticket id
 *     responses:
 *        200:
 *          description: The ticket description by id
 *          content:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Ticket'
 *        404:
 *          description: The ticket was not found
 */
router.get('/tickets/:id', async (req, res, next) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }
    try {
        const ticket = await getTicketById(id);
        if (!ticket) {
            return res.status(404).json({ message: 'Ticket not found' });
        }
        res.status(200).json(ticket);
    } catch (error) {
        next(error);
    }
});
/**
 * @swagger
 * /tickets/{ticketId}/edits:
 *   get:
 *     summary: Get the edit history of a ticket
 *     tags: [TicketsGet]
 *     parameters:
 *       - in: path
 *         name: ticketId
 *         schema:
 *           type: string
 *         required: true
 *         description: The id of the ticket
 *     responses:
 *       200:
 *         description: The edit history of the ticket
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: string
 *                     description: The id of the edit record
 *                   ticketId:
 *                     type: string
 *                     description: The id of the ticket
 *                   content:
 *                     type: string
 *                     description: The content of the ticket edit
 *                   editedBy:
 *                     type: string
 *                     description: The id of the user who edited the ticket
 *                   createdAt:
 *                     type: string
 *                     format: date-time
 *                     description: The time when the edit was made
 *       404:
 *         description: Ticket not found
 *       500:
 *         description: Some server error
 */
router.get('/tickets/:ticketId/edits', async (req, res, next) => {
    const { ticketId } = req.params;

    if (!ticketId) {
        return res.status(400).json({ message: 'Ticket ID is required' });
    }

    try {
        const ticket = await getTicketById(ticketId);
        if (!ticket) {
            return res.status(404).json({ message: 'Ticket not found' });
        }

        const edits = await ticketEditsHistory(ticketId);
        res.status(200).json(edits);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /tickets/{ticketId}/replies:
 *   get:
 *     summary: Get all replies of a ticket
 *     tags: [TicketsGet]
 *     parameters:
 *       - in: path
 *         name: ticketId
 *         schema:
 *           type: string
 *         required: true
 *         description: The id of the ticket
 *     responses:
 *       200:
 *         description: The list of replies of the ticket
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Ticket'
 *       404:
 *         description: Ticket not found
 *       500:
 *         description: Some server error
 */
router.get('/tickets/:ticketId/replies', async (req, res, next) => {
    const { ticketId } = req.params;

    if (!ticketId) {
        return res.status(400).json({ message: 'Ticket ID is required' });
    }

    try {
        const ticket = await getTicketById(ticketId);
        if (!ticket) {
            return res.status(404).json({ message: 'Ticket not found' });
        }

        const replies = await getAllRepliesOfTicket(ticketId);
        res.status(200).json(replies);
    } catch (error) {
        next(error);
    }
});


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
 *           type: integer
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
 * /rooms:
 *   get:
 *     summary: Returns the list of all the rooms
 *     tags: [RoomsGet]
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
router.get('/rooms/', async (req, res) => {
    const rooms = await getRooms();
    res.status(200).json(rooms);
});


/**
 * @swagger
 * /rooms/{id}:
 *   get:
 *     summary: Get the room by id
 *     tags: [RoomsGet]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
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
router.get('/rooms/:id', async (req, res, next) => {
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
 *           type: integer
 *           description: The unique identifier of the user
 *         userName:
 *           type: string
 *           description: The name of the user
 *         role:
 *           type: string
 *           description: The role of the user in the room
 *       example:
 *         userId: 1
 *         userName: 'John Doe'
 *         role: 'admin'
 *
 * /rooms/{roomId}/users_with_roles:
 *   get:
 *     summary: Get all users with their roles in a specified room
 *     tags: [RoomsGet]
 *     parameters:
 *       - in: path
 *         name: roomId
 *         required: true
 *         schema:
 *           type: integer
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
router.get('/rooms/:roomId/users_with_roles', async (req, res) => {
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


/**
 * @swagger
 * /rooms/{roomId}/users/{userId}/role:
 *   get:
 *     summary: Get the role of a user in a specific room
 *     tags: [RoomsGet]
 *     parameters:
 *       - in: path
 *         name: roomId
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the room
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user
 *     responses:
 *       200:
 *         description: Role of the user in the room
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 userId:
 *                   type: integer
 *                 roomId:
 *                   type: integer
 *                 role:
 *                   type: string
 *       404:
 *         description: User-room role not found
 *       500:
 *         description: Server error
 */
router.get('/rooms/:roomId/users/:userId/role', async (req, res) => {
    const { userId, roomId } = req.params;
    if (!userId || !roomId) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }
    try {
        const userRoomRole = await getUserRoomRoleByIds(userId, roomId);
        if (!userRoomRole) {
            return res.status(404).json({ message: 'User-room role not found' });
        }
        res.status(200).json(userRoomRole);
    } catch (error) {
        res.status(500).json({ message: `Server error: ${error.message}` });
    }
});


/**
 * @swagger
 * components:
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
 * /users:
 *   get:
 *     summary: Returns the list of all the users
 *     tags: [UsersGet]
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
router.get('/users/', async (req, res) => {
    const users = await getUsers();
    res.status(200).json(users);
});

/**
 * @swagger
 * /users/{id}:
 *   get:
 *     summary: Get the user by id
 *     tags: [UsersGet]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
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
router.get('/users/:id', async (req, res, next) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }
    try {
        const user = await getUserById(id);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.status(200).json(user);
    } catch (error) {
        next(error);  // Pass the error to the error handling middleware
    }
});



module.exports = router;