const express = require('express');
const router = express.Router();

/**
 * @swagger
 * /hello:
 *   get:
 *     summary: Returns a greeting message
 *     responses:
 *       200:
 *         description: A successful response
 *         content:
 *           text/plain:
 *             schema:
 *               type: string
 *               example: Hello, World!
 */
router.get('/', (req, res) => {
  res.send('Hello, World!');
});

module.exports = router;
