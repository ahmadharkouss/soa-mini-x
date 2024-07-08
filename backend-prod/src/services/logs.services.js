const {Logs} = require('../models/logs')

const  {getUserById} =  require('./User/user.crud.service');




//create a new log


const createLog = async (logData) => {
    try {
        const log = await Logs.create(logData);
        return log;
    } catch (error) {
        console.error('Error creating log:', error);
        throw new Error('Error creating log');
    }
};


//get all logs

const getLogs = async () => {
    
        try {
            const logs = await Logs.findAll();
            return logs;
        } catch (error) {
            console.error(error);
        }
    }



//get all logs of a userId

const getLogsByUserId = async (userId) => {

    const user = await getUserById(userId);
    if (!user) {
        throw new Error('User not found');
    }
        
    try {
                const logs = await Logs.findAll({where:{userId}});
                return logs;
    } catch (error) {
                console.error(error);
    }
}

module.exports = { createLog, getLogs, getLogsByUserId };