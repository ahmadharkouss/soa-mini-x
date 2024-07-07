// services/Room-User/room.user.service.js
const { User } = require('../models/Room-User/User');
const { Room } = require('../models/Room-User/Room');
const { UsersRoomsRoles } = require('../models/Room-User/Users_Rooms_Roles');

// services/Room-User/room.user.service.js
const joinRoom = async (userId, roomId) => {
    try {
        const user = await User.findByPk(userId);
        const room = await Room.findByPk(roomId);

        if (!user || !room) {
            throw new Error('User or Room not found');
        }
        //check  if the user is already in the room
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (userRoomRole) {
            throw new Error('User is already in the room');
        }

        // Users join rooms without a specific role; default role could be set if needed
        await UsersRoomsRoles.create({ userId, roomId, role: null }); // default role as member
        return { message: 'User joined the room successfully' };
    } catch (error) {
        throw new Error(`Error joining room: ${error.message}`);
    }
};



const leaveRoom = async (userId, roomId) => {
    try {
        const user = await User.findByPk(userId);
        const room = await Room.findByPk(roomId);

        if (!user || !room) {
            throw new Error('User or Room not found');
        }

        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (!userRoomRole) {
            throw new Error('User is not in the room');
        }

        await userRoomRole.destroy();
        return { message: 'User left the room successfully' };
    } catch (error) {
        throw new Error(`Error leaving room: ${error.message}`);
    }
};


// services/Room-User/room.user.service.js
const kickUserFromRoom = async (adminId, userId, roomId) => {
    try {
        const adminRoomRole = await UsersRoomsRoles.findOne({ where: { userId: adminId, roomId, role: 'admin' } });
        if (!adminRoomRole) {
            throw new Error('User is not an admin of the room');
        }
        if(adminId === userId){
            throw new Error('Admin cannot kick himself');
        }
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (!userRoomRole) {
            throw new Error('User is not in the room');
        }

        await userRoomRole.destroy();
        return { message: 'User kicked from the room successfully' };
    } catch (error) {
        throw new Error(`Error kicking user from room: ${error.message}`);
    }
};


const getAllUserRoomRoles = async () => {
    try {
        const roles = await UsersRoomsRoles.findAll();
        console.log("Roles found:", roles);
        return roles;
    } catch (error) {
        throw new Error(`Error fetching user-room roles: ${error.message}`);
    }
};

const getUserRoomRoleByIds = async (userId , roomId) => {
    try {
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        return userRoomRole;
    } catch (error) {
        throw new Error(`Error fetching user-room role: ${error.message}`);
    }
}
// Add function to assign role to a user in a room by an admin
const assignRole = async (adminId, userId, roomId, role) => {
    try {
        const adminRole = await UsersRoomsRoles.findOne({ where: { userId: adminId, roomId, role: 'admin' } });
        if (!adminRole) {
            throw new Error('Only admins can assign roles and are owner of the room');
        }

        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId, roomId } });
        if (userRoomRole) {
            // Update existing role if already joined
            userRoomRole.role = role;
            await userRoomRole.save();
            return { message: 'Role assigned successfully' };
        }
       
    } catch (error) {
        throw new Error(`Error assigning role: ${error.message}`);
    }
};

//get users in a room

const getUsersInRoom = async (roomId) => {
    try {
        const users = await UsersRoomsRoles.findAll({ where: { roomId } });
        return users;
    } catch (error) {
        throw new Error(`Error fetching users in room: ${error.message}`);
    }
}


module.exports = {
    joinRoom,
    leaveRoom,
    kickUserFromRoom,
    getAllUserRoomRoles,
    getUserRoomRoleByIds ,
    assignRole,
    getUsersInRoom 
};
