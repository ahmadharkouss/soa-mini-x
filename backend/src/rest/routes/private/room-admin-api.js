const express = require('express');
const router = express.Router();
const {kickUserFromRoom,
  assignRole
  } = require('../../../services/user-room.service');
  const { 
    updateRoomByAdmin, deleteRoomByIdByAdmin
} = require('../../../services/Room/room.crud.service');


const {getUserById} = require('../../../services/User/user.crud.service');
const {getRoomById} = require('../../../services/Room/room.crud.service');




/**
 * @swagger
 * tags:
 *   name: RA
 *   description: The Room admin API for managing users
 */



/**
 * @swagger
 * /rooms/admin/kick:
 *   post:
 *     summary: Kick a user from a room (admin only)
 *     tags: [RA]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - adminId
 *               - userId
 *               - roomId
 *             properties:
 *               adminId:
 *                 type: integer
 *               userId:
 *                 type: integer
 *               roomId:
 *                 type: integer
 *     responses:
 *       200:
 *         description: User kicked from the room successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *       400:
 *         description: Bad request
 *       403:
 *         description: Forbidden - User is not an admin
 *       404:
 *         description: Not found - User or Room not found
 *       500:
 *         description: Server error
 */
router.post('/kick', async (req, res, next) => {
    const { adminId, userId, roomId } = req.body;
    if (!adminId || !userId || !roomId) {
        return res.status(400).json({ message: 'Required fields are missing' });
    }
    try {
        const response = await kickUserFromRoom(adminId, userId, roomId);
        res.status(200).json(response);
    } catch (error) {
        if (error.message.includes('User is not an admin of the room') || error.message.includes('User is not in the room')) {
            return res.status(403).json({ message: error.message });
        } else if (error.message.includes('User or Room not found')) {
            return res.status(404).json({ message: error.message });
            
        }
        else if (error.message.includes('Admin cannot kick himself')) {
            return res.status(403).json({ message: error.message });
        } 
        else {
            next(error);
        }
    }
});


/**
 * @swagger
 * /rooms/admin/assign-role:
 *   post:
 *     summary: Assign a role to a user in a room (admin only)
 *     tags: [RA]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - adminId
 *               - userId
 *               - roomId
 *               - role
 *             properties:
 *               adminId:
 *                 type: integer
 *               userId:
 *                 type: integer
 *               roomId:
 *                 type: integer
 *               role:
 *                 type: string
 *     responses:
 *       200:
 *         description: Role assigned successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *       403:
 *         description: Forbidden - Only admins can assign roles
 *       404:
 *         description: Not found - User or Room not found
 *       500:
 *         description: Server error
 */
router.post('/assign-role', async (req, res, next) => {
    const { adminId, userId, roomId, role } = req.body;
    if (!adminId || !userId || !roomId || !role) {
        return res.status(400).json({ message: 'Required fields are missing' });
    }
    const room = await getRoomById(roomId);
    if (!room) {
        return res.status(404).json({ message: 'Room not found' });
    }
    const user = await getUserById(userId);
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    const admin = await getUserById(adminId);
    if (!admin) {
        return res.status(404).json({ message: 'Admin not found' });
    }
    try {
        const response = await assignRole(adminId, userId, roomId, role);
        res.status(200).json(response);
    } catch (error) {
        if (error.message.includes('Only admins')) {
            res.status(403).json({ message: error.message });
        } else {
            next(error);
        }
    }
});



/**
 * @swagger
 * /rooms/admin/{roomId}/update:
 *   put:
 *     summary: Update a room name by an admin
 *     tags: [RA]
 *     parameters:
 *       - in: path
 *         name: roomId
 *         schema:
 *           type: integer
 *         required: true
 *         description: The id of the room
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *                 description: The id of the user making the request
 *               name:
 *                 type: string
 *                 description: The new name for the room
 *             example:
 *               userId: 1
 *               name: New Room Name
 *     responses:
 *       200:
 *         description: The room was successfully updated
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   description: The id of the room
 *                 name:
 *                   type: string
 *                   description: The name of the room
 *       400:
 *         description: Bad Request - Required fields are missing
 *       403:
 *         description: Forbidden - User is not an admin
 *       404:
 *         description: Not Found - Room not found
 *       500:
 *         description: Some server error
 */
router.put('/:roomId/update', async (req, res, next) => {
    const { roomId } = req.params;
    const { userId, name } = req.body;
    try {
        if (!userId || !name || !roomId) {
            return res.status(400).json({ message: 'Required fields are missing' });
        }

        //check if the user exists
        const user = await getUserById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const roomf = await getRoomById(roomId);

        if (!roomf) {
            return res.status(404).json({ message: 'Room not found' });
        }

        const room = await updateRoomByAdmin(userId, roomId, name);
        res.status(200).json(room);
    } catch (error) {
        if (error.message.includes('User is not an admin of the room')) {
            return res.status(403).json({ message: error.message });
        } else if (error.message.inlcudes('Room not found')) {
            return res.status(404).json({ message: error.message });
        } else {
            next(error);
        }
    }
});



/**
 * @swagger
 * /rooms/admin/{roomId}/{userId}:
 *   delete:
 *     summary: Delete a room by admin
 *     tags: [RA]
 *     parameters:
 *       - in: path
 *         name: roomId
 *         required: true
 *         schema:
 *           type: integer
 *         description: The id of the room to be deleted
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: The id of the admin user attempting to delete the room
 *     responses:
 *       200:
 *         description: The room was successfully deleted
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Room deleted successfully
 *       403:
 *         description: Forbidden - User is not an admin
 *       404:
 *         description: Not Found - Room not found
 *       500:
 *         description: Server error
 */
router.delete('/:roomId/:userId', async (req, res, next) => {
    const { roomId, userId } = req.params;

    try {
        if (!userId) {
            return res.status(400).json({ message: 'Admin user ID required' });
        }
        if (!roomId) {
            return res.status(400).json({ message: 'Room ID required' });
        }
        // Check if the user exists
        const user = await getUserById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const roomf = await getRoomById(roomId);
        if (!roomf) {
            return res.status(404).json({ message: 'Room not found' });
        }
        // Attempt to delete the room by admin
        const room = await deleteRoomByIdByAdmin(userId, roomId);
        res.status(200).json({ message: 'Room deleted successfully' });
    } catch (error) {
        //CHECK IF error message is not empty
        if (error.message!==undefined && error.message!='') {
            res.status(403).json({ message: error.message });
        } else {
            next(error);
        }
    }
});



module.exports = router;
