const {sequelize} = require('../../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');
         

// Define Users_Rooms_Roles model
class UsersRoomsRoles extends Model {}
UsersRoomsRoles.init({
  role: DataTypes.STRING ,
  userId: DataTypes.INTEGER,
  roomId: DataTypes.INTEGER
}, { sequelize, modelName: 'Users_Rooms_Roles',timestamps: true});

module.exports = { UsersRoomsRoles };