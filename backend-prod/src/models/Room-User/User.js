const {sequelize} = require('../../utilities/connectDb');
const {Model, DataTypes } = require('sequelize');

// Define User model
class User extends Model {}
User.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: DataTypes.STRING,
  alias: DataTypes.STRING
}, { sequelize, modelName: 'User',timestamps: true });

module.exports = { User };