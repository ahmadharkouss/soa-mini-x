//ticket crud model service

const { Ticket } = require('../../models/Ticket/Ticket');
const { TicketEdits } = require('../../models/Ticket/Ticket_Edits');
const { UsersRoomsRoles } = require('../../models/Room-User/Users_Rooms_Roles');

//create a new ticket


const createTicket = async (roomId, subject, content,createdBy) => {
    try {
        // Check if the user is part of the room
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId: createdBy, roomId } });
        if (!userRoomRole) {
            throw new Error('User has not joined the room');
        }

        // Create the ticket
        const ticket = await Ticket.create({
            roomId,
            subject,
            content,
            isEdited: false,
            parentTicket: null,
            createdBy
        });
        return ticket;
    } catch (error) {
        console.error(error);
        throw new Error(`Error creating ticket: ${error.message}`);
    }
};

const replyTicket = async (roomId, subject, content, createdBy, parentTicket) => {
    try {
        // Check if the user is part of the room
        const userRoomRole = await UsersRoomsRoles.findOne({ where: { userId: createdBy, roomId } });
        if (!userRoomRole) {
            throw new Error('User has not joined the room');
        }

        // Create the ticket
        const ticket = await Ticket.create({
            roomId,
            subject,
            content,
            isEdited: false,
            parentTicket,
            createdBy
        });
        return ticket;
    } catch (error) {
        console.error(error);
        throw new Error(`Error creating ticket: ${error.message}`);
    }
}


//get all tickets

const getTickets = async () => {

    try {
        const tickets = await Ticket.findAll();
        return tickets;
    } catch (error) {
        console.error(error);
    }
}


//get ticket by id


const getTicketById = async (id) => {

    try {
        const ticket = await Ticket.findByPk(id);
        return ticket;
    } catch (error) {
        console.error(error);
    }
}



//edit ticket content

const editTicketContent = async (ticketId, content, editedBy) => {
    try {
        const ticket = await Ticket.findByPk(ticketId);
        if (!ticket) {
            throw new Error('Ticket not found');
        }
        const ticketEdit = await TicketEdits.create({
            ticketId: ticket.id,
            contentBefore: ticket.content,
        });
        ticket.content = content;
        ticket.isEdited = true;
        await ticket.save();
        return ticket;
    } catch (error) {
        console.error(error);
        throw new Error(`Error editing ticket: ${error.message}`);
    }
}





//delete ticket by id
const deleteTicketById = async (id, deletedBy) => {
    try {
        const ticket = await Ticket.findByPk(id);
        if (!ticket) {
            throw new Error('Ticket not found');
        }
        ticket.deletedBy = deletedBy; // Update the deletedBy field
        await ticket.destroy();
        return ticket;
    } catch (error) {
        console.error(error);
        throw new Error(`Error deleting ticket: ${error.message}`);
    }
}

//update ticket by id


const updateTicketById = async (id, roomId, subject, content, isEdited, parentTicket, createdBy) => {

    try {
        const ticket = await Ticket.findByPk(id);
        ticket.roomId = roomId;
        ticket.subject = subject;
        ticket.content = content;
        ticket.isEdited = isEdited;
        ticket.parentTicket = parentTicket;
        ticket.createdBy = createdBy;
        await ticket.save();
        return ticket;
    } catch (error) {
        console.error(error);
    }
}


const ticketEditsHistory = async (ticketId) => {
    try {
        const ticketEdits = await TicketEdits.findAll({ where: { ticketId } });
        return ticketEdits;
    } catch (error) {
        console.error(error);
    }
}
const getAllRepliesOfTicket = async (ticketId) => {
    try {
        const replies = await Ticket.findAll({ where: { parentTicket: ticketId } });
        return replies;
    } catch (error) {
        console.error(error);
    }
}

module.exports = {
    createTicket,
    getTickets,
    getTicketById,
    updateTicketById ,
    deleteTicketById,
    editTicketContent,
    replyTicket,
    ticketEditsHistory,
    getAllRepliesOfTicket
};