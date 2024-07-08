// routes/api/room.user.routes.js
const express = require('express');
const router = express.Router();
const { joinRoom, leaveRoom, kickUserFromRoom,  getAllUserRoomRoles, 
    getUserRoomRoleByIds, assignRole,getUsersInRoom 
  } = require('../../../services/user-room.service');


const { keycloakMiddleware, keycloak } = require('../../../middleware/keycloack.middleware');
keycloakMiddleware(router);

/**
 * @swagger
 * tags:
 *   name: RT
 *   description: The Rooms Transactions API
 */


/**
 * @swagger
 * /rooms/join:
 *   post:
 *     summary: Join a room
 *     tags: [RT]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - userId
 *               - roomId
 *             properties:
 *               userId:
 *                 type: integer
 *               roomId:
 *                 type: integer
 *     responses:
 *       200:
 *         description: User joined the room successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/join',keycloak.protect(), async (req, res, next) => {
    const { userId, roomId } = req.body;
    if (!userId || !roomId) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }

    try {
        const response = await joinRoom(userId, roomId);
        res.status(200).json(response);
    } catch (error) {
        if (error.message.includes('User or Room not found')) {
            return res.status(404).json({ message: error.message });
        }
        if(error.message.includes('User is already in the room')){
            return res.status(403).json({ message: error.message });
        }
        next(error);
    }
});

/**
 * @swagger
 * /rooms/leave:
 *   post:
 *     summary: Leave a room
 *     tags: [RT]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - userId
 *               - roomId
 *             properties:
 *               userId:
 *                 type: integer
 *               roomId:
 *                 type: integer
 *     responses:
 *       200:
 *         description: User left the room successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/leave',keycloak.protect(), async (req, res, next) => {
    const { userId, roomId } = req.body;
    if (!userId || !roomId) {
        return res.status(400).json({ message: 'Bad request, missing fields' });
    }
    try {
        const response = await leaveRoom(userId, roomId);
        res.status(200).json(response);
    } catch (error) {
        if (error.message.includes('User or Room not found')) {
            return res.status(404).json({ message: error.message });
        }
        if (error.message.includes('User is not in the room')) {
            return res.status(403).json({ message: error.message });
        }
        next(error);
    }
});








module.exports = router;