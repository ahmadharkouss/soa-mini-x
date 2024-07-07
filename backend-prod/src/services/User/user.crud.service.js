//user crud model service

const { User } = require('../../models/Room-User/User');


//todo create classes for each service

//create a new user

const createUser = async (name, alias) => {
    try {
        const user = await User.create({ name, alias });
        return user;
    } catch (error) {
        console.error(error);
    }
}

//get all users

const getUsers = async () => {

    try {
        const users = await User.findAll();
        return users;
    } catch (error) {
        console.error(error);
    }
}


//get user by id

const getUserById = async (id) => {

    try {
        const user = await User.findByPk(id);
        return user;
    } catch (error) {
        console.error(error);
    }
}


//update user by id

const updateUserById = async (id, name, alias) => {

    try {
        const user = await User.findByPk(id);
        user.name = name;
        user.alias = alias;
        await user.save();
        return user;
    } catch (error) {
        console.error(error);
    }
}


//delete user by id


const deleteUserById = async (id) => {


    try {
        const user = await User.findByPk(id);
        await user.destroy();
        return user;
    } catch (error) {
        console.error(error);
    }
}


module.exports = { createUser, getUsers, getUserById, updateUserById, deleteUserById };