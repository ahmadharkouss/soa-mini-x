const express = require('express');
const router = express.Router();
const { createTicket, getTickets, getTicketById, updateTicketById, deleteTicketById } = require('../../../../services/Ticket/ticket.crud.service');

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
 *     Ticket:
 *       type: object
 *       required:
 *         - roomId
 *         - subject
 *         - content
 *         - isEdited
 *         - parentTicket
 *         - createdBy
 *       properties:
 *         id:
 *           type: string
 *           description: The auto-generated id of the ticket
 *         roomId:
 *           type: string
 *           description: The id of the room associated with the ticket
 *         subject:
 *           type: string
 *           description: The subject of the ticket
 *         content:
 *           type: string
 *           description: The content of the ticket
 *         isEdited:
 *           type: boolean
 *           description: If the ticket has been edited
 *         parentTicket:
 *           type: string
 *           description: The id of the parent ticket if any
 *         createdBy:
 *           type: string
 *           description: The id of the user who created the ticket
 *       example:
 *         id: d5fE_asz
 *         roomId: 12345
 *         subject: Issue with projector
 *         content: The projector in room 101 is not working.
 *         isEdited: false
 *         parentTicket: null
 *         createdBy: 67890
 */

/**
 * @swagger
 * tags:
 *   name: Tickets
 *   description: The ticket managing API
 */

/**
 * @swagger
 * /tickets:
 *   post:
 *     summary: Create a new ticket
 *     tags: [Tickets]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Ticket'
 *     responses:
 *       200:
 *         description: The ticket was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Ticket'
 *       500:
 *         description: Some server error
 */
router.post('/', async (req, res, next) => {
    const { roomId, subject, content, isEdited, parentTicket, createdBy } = req.body;
    try {
        if (!roomId || !subject || !content || !createdBy) {
            return res.status(404).json({ message: 'Required fields are missing' });
        }
        const ticket = await createTicket(roomId, subject, content, isEdited, parentTicket, createdBy);
        res.json(ticket);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /tickets:
 *   get:
 *     summary: Returns the list of all the tickets
 *     tags: [Tickets]
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
router.get('/', async (req, res) => {
    const tickets = await getTickets();
    res.json(tickets);
});

/**
 * @swagger
 * /tickets/{id}:
 *   get:
 *     summary: Get the ticket by id
 *     tags: [Tickets]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ticket id
 *     responses:
 *        200:
 *          description: The ticket description by id
 *          contents:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Ticket'
 *        404:
 *          description: The ticket was not found
 */
router.get('/:id', async (req, res, next) => {
    const { id } = req.params;
    try {
        const ticket = await getTicketById(id);
        res.json(ticket);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /tickets/{id}:
 *   put:
 *     summary: Update the ticket by the id
 *     tags: [Tickets]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ticket id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Ticket'
 *     responses:
 *       200:
 *         description: The ticket was updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Ticket'
 *       404:
 *         description: The ticket was not found
 *       500:
 *         description: Some error happened
 */
router.put('/:id', async (req, res, next) => {
    const { id } = req.params;
    const { roomId, subject, content, isEdited, parentTicket, createdBy } = req.body;
    try {
        const ticket = await updateTicketById(id, roomId, subject, content, isEdited, parentTicket, createdBy);
        res.json(ticket);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /tickets/{id}:
 *   delete:
 *     summary: Remove the ticket by id
 *     tags: [Tickets]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ticket id
 *     responses:
 *       200:
 *         description: The ticket was deleted
 *       404:
 *         description: The ticket was not found
 */
router.delete('/:id', async (req, res, next) => {
    const { id } = req.params;
    try {
        await deleteTicketById(id);
        res.json({ message: 'Ticket deleted successfully' });
    } catch (error) {
        next(error);
    }
});

module.exports = router;