const {sequelize} = require('../../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');


// Define Room model
class Room extends Model {}
Room.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: DataTypes.STRING
}, { sequelize, modelName: 'Room',timestamps: true });

module.exports = { Room };