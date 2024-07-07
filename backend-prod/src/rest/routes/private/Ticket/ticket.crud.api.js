const express = require('express');
const router = express.Router();
const { createTicket, getTickets, getTicketById, updateTicketById, deleteTicketById, editTicketContent,  replyTicket,
    ticketEditsHistory 
 } = require('../../../../services/Ticket/ticket.crud.service');
const {getUserById} = require('../../../../services/User/user.crud.service');
const {getRoomById} = require('../../../../services/Room/room.crud.service');
// Middleware that is specific to this router
const timeLog = (req, res, next) => {
    console.log('Time: ', Date.now());
    next();
};
router.use(timeLog);
const { keycloakMiddleware, keycloak } = require('../../../../middleware/keycloack.middleware');
keycloakMiddleware(router);


/**
 * @swagger
 * components:
 *   securitySchemes:
 *     bearerAuth:
 *       type: http
 *       scheme: bearer
 *       bearerFormat: JWT
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
 * components:
 *   securitySchemes:
 *     bearerAuth:
 *       type: http
 *       scheme: bearer
 *       bearerFormat: JWT
 *   schemas:
 *     Ticket2:
 *       type: object
 *       required:
 *         - roomId
 *         - subject
 *         - content
 *         - createdBy
 *       properties:
 *         roomId:
 *           type: integer
 *           description: The id of the room associated with the ticket
 *         subject:
 *           type: string
 *           description: The subject of the ticket
 *         content:
 *           type: string
 *           description: The content of the ticket
 *         parentTicket:
 *           type: integer
 *           description: The id of the parent ticket if any
 *         createdBy:
 *           type: integer
 *           description: The id of the user who created the ticket
 *       example:
 *         roomId: 1
 *         subject: Issue with projector
 *         content: The projector in room 101 is not working.
 *         createdBy: 1
 */

/**
 * @swagger
 * tags:
 *   name: Tickets
 *   description: The ticket Transactions API
 */


/**
 * @swagger
 * /tickets:
 *   post:
 *     summary: Create a new ticket
 *     tags: [Tickets]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Ticket2'
 *     responses:
 *       200:
 *         description: The ticket was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Ticket'
 *       400:
 *         description: Bad Request - Required fields are missing 
 *       404:
 *        description: Useror room not found
 *       403:
 *         description: User has not joined the room
 *       500:
 *         description: Some server error
 */
router.post('/', keycloak.protect(),async (req, res, next) => {
    const { roomId, subject, content, createdBy } = req.body;
    try {
        if (!roomId || !subject || !content || !createdBy) {
            return res.status(400).json({ message: 'Required fields are missing' });
        }
        const user = await getUserById(createdBy);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const room = await getRoomById(roomId);
        if (!room) {
            return res.status(404).json({ message: 'Room not found' });
        }
        const ticket = await createTicket(roomId, subject, content, createdBy);
        const {updatedAt, ...ticketWithoutUpdatedAt} = ticket.toJSON ? ticket.toJSON() : ticket;
        res.status(200).json(ticketWithoutUpdatedAt);
    } catch (error) {
           return res.status(403).json({ message: error.message });
        
    }
});




/**
 * @swagger
 * /tickets/{parentId}/reply:
 *   post:
 *     summary: Reply to a ticket
 *     tags: [Tickets]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: parentId
 *         schema:
 *           type: integer
 *         required: true
 *         description: The id of the parent ticket
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               subject:
 *                 type: string
 *                 description: The subject of the reply
 *               content:
 *                 type: string
 *                 description: The content of the reply
 *               createdBy:
 *                 type: integer
 *                 description: The id of the user creating the reply
 *             example:
 *               subject: "Re: Issue with projector"
 *               content: "The projector in room 101 has been fixed."
 *               createdBy: 1
 *     responses:
 *       200:
 *         description: The reply was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Ticket'
 *       400:
 *         description: Bad Request - Required fields are missing
 *       404:
 *         description: The user or  parent ticket was not found
 *       403:
 *         description: User has not joined the room
 *       500:
 *         description: Some server error
 */


router.post('/:parentId/reply',keycloak.protect(), async (req, res, next) => {
    const { parentId } = req.params
    const { subject, content, createdBy} = req.body;

    if (!subject || !content || !createdBy || !parentId) {
        return res.status(400).json({ message: 'Subject, content, createdBy, and parentTicket are required' });
    }
    const user = await getUserById(createdBy);
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    const parentTicketd = await getTicketById(parentId);
    if (!parentTicketd) {
        return res.status(404).json({ message: 'Parent ticket not found' });
    }
    try {
        const ticket = await replyTicket(parentTicketd.roomId, subject, content, createdBy, parentId);
        res.status(200).json({ ticket });
    } catch (error) {
        if (error.message.includes('User has not joined the room')) {
            res.status(403).json({ message: error.message });
        } else {
            next(error);
        }
    }
});




/**
 * @swagger
 * /tickets/{id}/edit:
 *   put:
 *     summary: Edit the ticket content by user id
 *     tags: [Tickets]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The ticket id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               content:
 *                 type: string
 *                 description: The new content of the ticket
 *               editedBy:
 *                 type: integer
 *                 description: The id of the user editing the ticket
 *             example:
 *               content: The projector in room 101 has been fixed.
 *               editedBy: 1
 *     responses:
 *       200:
 *         description: The ticket content was edited
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Ticket'
 *       404:
 *         description: The ticket was not found
 *       403:
 *         description: You are not authorized to edit this ticket
 *       500:
 *         description: Some error happened
 */

router.put('/:id/edit',keycloak.protect(),async (req, res, next) => {
    const { id } = req.params;
    const { content, editedBy } = req.body;

    if (!content || !id || !editedBy) {
        return res.status(400).json({ message: 'Required fields are missing' });
    }
    const user = await getUserById(editedBy);
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    const ticket = await getTicketById(id);
    if (!ticket) {
        return res.status(404).json({ message: 'Ticket not found' });
    }
    if (ticket.createdBy !== editedBy) {
        return res.status(403).json({ message: 'You are not authorized to edit this ticket' });
    }
    try {
        const ticket = await editTicketContent(id, content, editedBy);
        res.status(200).json(ticket);
    } catch (error) {
        next(error);
    }
});




/**
 * @swagger
 * /tickets/{id}:
 *   delete:
 *     summary: Remove the ticket by user  id
 *     tags: [Tickets]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The ticket id
 *       - in: query
 *         name: deletedBy
 *         schema:
 *           type: string
 *         required: true
 *         description: The id of the user deleting the ticket
 *     responses:
 *       200:
 *         description: The ticket was deleted
 *       400:
 *          description: Bad request - missing fields
 *       403:
 *          description: You are not authorized to delete this ticket
 *       404:
 *         description: The ticket or User was not found
 */

router.delete('/:id',keycloak.protect(),async (req, res, next) => {
    const { id } = req.params;
    const { deletedBy } = req.query;

    if (!id || !deletedBy) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }

    const user = await getUserById(deletedBy);
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    const ticket = await getTicketById(id);
    if (!ticket) {
        return res.status(404).json({ message: 'Ticket not found' });
    }
    console.log("------------")
    console.log(ticket.createdBy)
    console.log(deletedBy)
    console.log("------------")
    if (ticket.createdBy != deletedBy) {
        return res.status(403).json({ message: 'You are not authorized to delete this ticket' });
    }
    try {
        await deleteTicketById(id, deletedBy);
        res.status(200).json({ message: 'Ticket deleted successfully' });
    } catch (error) {
        next(error);
    }
});


module.exports = router;
