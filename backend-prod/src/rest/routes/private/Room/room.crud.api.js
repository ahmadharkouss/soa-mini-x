const express = require('express');
const router = express.Router();
const { createRoom, getRooms, getRoomById,
} = require('../../../../services/Room/room.crud.service');

const { getUsersInRoom 
  } = require('../../../../services/user-room.service');

  const {logUserActivity}= require('../../../../redis/plugins/activity-logs.publisher')
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
 * tags:
 *   name: Rooms
 *   description: The room creation API
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
 * components:
 *   securitySchemes:
 *     bearerAuth:
 *       type: http
 *       scheme: bearer
 *       bearerFormat: JWT
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
 *           type: integer
 *           description: The ID of the user who creates the room and will be assigned as admin
 *       example:
 *         name: Conference Room
 *         createdBy: 1
 */

/**
 * @swagger
 * /rooms:
 *   post:
 *     summary: Create a new room and assign the creator as the admin
 *     tags: [Rooms]
 *     security:
 *       - bearerAuth: []
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
router.post('/',keycloak.protect(), async (req, res, next) => {
    const { name, createdBy } = req.body;

    try {
        if (!name || !createdBy) {
            return res.status(400).json({ message: 'Name and createdBy are required' });
        }
        const room = await createRoom(name, createdBy);
        const { updatedAt, ...roomWithoutUpdatedAt } = room.toJSON ? room.toJSON() : room;
        // Log user activity asynchronously, without affecting the response
        logUserActivity(createdBy, `Created room ${room.name}`).catch(err => {
            console.error('Failed to log user activity:', err);
        })
        res.status(200).json(roomWithoutUpdatedAt);
    } catch (error) {
        if (error.message.includes('User not found')) {
            res.status(404).json({ message: 'User not found' });
        } else {
            next(error);
        }
    }
});



module.exports = router;
