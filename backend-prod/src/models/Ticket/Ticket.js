const {sequelize} = require('../../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');

// Define Ticket model
class Ticket extends Model {}
Ticket.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  roomId: DataTypes.INTEGER,
  subject: DataTypes.STRING,
  content: DataTypes.TEXT,
  isEdited: DataTypes.BOOLEAN,
  parentTicket: DataTypes.INTEGER,
  createdBy: DataTypes.INTEGER,
}, { sequelize, modelName: 'Ticket', timestamps: true, createdAt: true, updatedAt: false});

module.exports = { Ticket };