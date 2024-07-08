const express = require('express');
const router = express.Router();
const { getLogs, getLogsByUserId } = require('../../../services/logs.services');

const { keycloakMiddleware, keycloak } = require('../../../middleware/keycloack.middleware');
keycloakMiddleware(router);
const {logUserActivity}= require('../../../redis/plugins/activity-logs.publisher');
/**
 * @swagger
 * tags:
 *   name: Logs
 *   description: API for managing logs
 */

/**
 * @swagger
 * /plugin/logs:
 *   get:
 *     summary: Get all logs
 *     tags: [Logs]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of all logs
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   userId:
 *                     type: integer
 *                   activity:
 *                     type: string
 *                   timestamp:
 *                     type: string
 *       500:
 *         description: Server error
 */
router.get('/',keycloak.protect(), async (req, res, next) => {
    try {
        const logs = await getLogs();
        res.status(200).json(logs);
    } catch (error) {
        next(error);
    }
});

/**
 * @swagger
 * /plugin/logs/{userId}:
 *   get:
 *     summary: Get logs by user ID
 *     tags: [Logs]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: The user ID
 *     responses:
 *       200:
 *         description: List of logs for the specified user ID
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   userId:
 *                     type: integer
 *                   activity:
 *                     type: string
 *                   timestamp:
 *                     type: string
 *       404:
 *         description: User not found
 *       500:
 *         description: Server error
 */
router.get('/:userId',keycloak.protect(), async (req, res, next) => {
    const { userId } = req.params;
    try {
        const logs = await getLogsByUserId(userId);
        res.status(200).json(logs);
    } catch (error) {
        if (error.message.includes('User not found')) {
            res.status(404).json({ message: 'User not found' });
        } else {
            next(error);
        }
    }
});

module.exports = router;
