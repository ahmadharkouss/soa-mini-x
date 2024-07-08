const {sequelize} = require('../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');
// Define TicketEdits model
class Logs extends Model {}
Logs.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  userId: DataTypes.INTEGER,
  activity: DataTypes.TEXT,
  timestamp: DataTypes.DATE
}, { sequelize, modelName: 'Logs', timestamps: false,createdAt: false, updatedAt: false});

module.exports = { Logs };