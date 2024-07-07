// routes/api/room.user.routes.js
const express = require('express');
const router = express.Router();
const { joinRoom, leaveRoom, kickUserFromRoom,  getAllUserRoomRoles, 
    getUserRoomRoleByIds, assignRole,getUsersInRoom 
  } = require('../../../services/user-room.service');
/**
 * @swagger
 * tags:
 *   name: RTL
 *   description: The Rooms Transactions/Listing API
 */


/**
 * @swagger
 * /rooms/join:
 *   post:
 *     summary: Join a room
 *     tags: [RTL]
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
router.post('/join', async (req, res, next) => {
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
 *     tags: [RTL]
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
router.post('/leave', async (req, res, next) => {
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



/**
 * @swagger
 * /rooms/{roomId}/users/{userId}/role:
 *   get:
 *     summary: Get the role of a user in a specific room
 *     tags: [RTL]
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
router.get('/:roomId/users/:userId/role', async (req, res) => {
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





module.exports = router;
