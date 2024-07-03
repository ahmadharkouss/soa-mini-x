//room crud model service

const { Room } = require('../../models/Room-User/Room');

//create a new room

const createRoom = async (name) => {
    try {
        const room = await Room.create({ name });
        return room;
    } catch (error) {
        console.error(error);
    }
};

//get all rooms

const getRooms = async () => {
    try {
        const rooms = await Room.findAll();
        return rooms;
    } catch (error) {
        console.error(error);
    }
}

//get room by id


const getRoomById = async (id) => {

    try {
        const room = await Room.findByPk(id);
        return room;
    } catch (error) {
        console.error(error);
    }
}

//update room by id

const updateRoomById = async (id, name) => {

    try {
        const room = await Room.findByPk(id);
        room.name = name;
        await room.save();
        return room;
    } catch (error) {
        console.error(error);
    }
}


//delete room by id


const deleteRoomById = async (id) => {

    try {
        const room = await Room.findByPk(id);
        await room.destroy();
        return room;
    } catch (error) {
        console.error(error);
    }
}

module.exports = { createRoom, getRooms, getRoomById, updateRoomById, deleteRoomById };