//room crud model service

const { Room } = require('../../models/Room-User/Room');
const { UsersRoomsRoles } = require('../../models/Room-User/Users_Rooms_Roles');

const {getUserById} = require('../User/user.crud.service');

//create a new room

const createRoom = async (name, createdBy) => {
    //check if the user exists

    const user = await getUserById(createdBy);
    if (!user) {
        throw new Error('User not found');
    }
    const transaction = await Room.sequelize.transaction();
    try {
        // Create the room
        const room = await Room.create({ name }, { transaction });

        console.log('----------');
        console.log('roomId', room.id);
        console.log('createdBy', createdBy);

        // Add the user who created the room to the room with the role 'admin' by default
        await UsersRoomsRoles.create({
            userId: createdBy,
            roomId: room.id,
            role: 'admin'
        }, { transaction });

        await transaction.commit();
        return room;
    } catch (error) {
        await transaction.rollback();
        console.error(error);
        throw new Error('Error creating room and assigning admin role');
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

const deleteRoomById = async (id) => {

    try {
        const room = await Room.findByPk(id);
        await room.destroy();
        return room;
    } catch (error) {
        console.error(error);
    }
}


//delete room by id


const deleteRoomByIdByAdmin = async (userId, roomId) => {
    try {
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (!userRoomRole || userRoomRole.role !== 'admin') {
            throw new Error('User is not an admin of the room');
        }

        const room = await Room.findByPk(roomId);
        if (!room) {
            throw new Error('Room not found');
        }

        await room.destroy();
        return room;
    } catch (error) {
        console.error(error);
        throw new Error('Error deleting room by admin');
    }
}

const updateRoomByAdmin = async (userId, roomId, name) => {
    try {
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (!userRoomRole || userRoomRole.role !== 'admin') {
            throw new Error('User is not an admin of the room');
        }

        const room = await Room.findByPk(roomId);
        if (!room) {
            throw new Error('Room not found');
        }

        room.name = name;
        await room.save();
        return room;
    } catch (error) {
        console.error(error);
        throw new Error('Error updating room by admin');
    }
};





module.exports = { createRoom, getRooms, getRoomById, updateRoomById, deleteRoomById , deleteRoomByIdByAdmin, 
    updateRoomByAdmin
 };