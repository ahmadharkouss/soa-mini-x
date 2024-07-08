const redis = require('redis');
const {createLog} = require ('../../services/logs.services')

/**
 * Subscribes to the user activity logs channel and processes incoming messages.
 */


const subscribeToActivityLogs= async () => {
    const subscriber = redis.createClient({
        url: 'redis://soa_redis:6379'
      })
    await subscriber.connect()
    console.log(`Connected to Redis. Listening to user_activity_channel`)
    await subscriber.subscribe('user_activity_channel', (message) => {
        try {
            const activityLog = JSON.parse(message);
            createLog(activityLog);
            console.log(`Activity log saved: ${message}`);
        } catch (error) {
            console.error('Error processing activity log:', error);
        }
        
    })
}

module.exports = { subscribeToActivityLogs };
