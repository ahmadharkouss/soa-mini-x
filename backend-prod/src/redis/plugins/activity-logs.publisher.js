const redis = require('redis');


/**
 * Logs user activity and publishes it to a Redis channel.
 * 
 * @param {number} userId - The ID of the user.
 * @param {string} activity - The activity description.
 */
const logUserActivity = async  (userId, activity) => {

    // Create a Redis client
    const redisClient =  await redis.createClient({
        url: 'redis://soa_redis:6379'
      })
    .on('error', err => console.log('Redis Client Error', err))
    .connect();

    // Connect to Redis server
    redisClient.on('connect', () => {
        console.log('Connected to Redis server');
    });

    const activityLog = { userId, activity, timestamp: new Date().toISOString() };
    const activityLogString = JSON.stringify(activityLog);

    // Publish activity log to a channel
    redisClient.publish('user_activity_channel', activityLogString, (err, response) => {
        if (err) {
            console.error('Error publishing user activity:', err);
        } else {
            console.log(`Activity published to channel for user ${userId}: ${activityLogString}`);
        }
    });
};
module.exports = { logUserActivity,
 };




 