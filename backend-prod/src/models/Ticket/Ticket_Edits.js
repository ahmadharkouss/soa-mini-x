const {sequelize} = require('../../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');
// Define TicketEdits model
class TicketEdits extends Model {}
TicketEdits.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  ticketId: DataTypes.INTEGER,
  contentBefore: DataTypes.TEXT
}, { sequelize, modelName: 'Ticket_Edits', timestamps: true,createdAt: true, updatedAt: false});

module.exports = { TicketEdits };