//ticket crud model service

const { Ticket } = require('../../models/Ticket/Ticket');


//create a new ticket

const createTicket = async (roomId, subject, content, isEdited, parentTicket, createdBy ) => {
    
        try {
            const ticket = await Ticket.create({
                roomId,
                subject,
                content,
                isEdited,
                parentTicket,
                createdBy
            });
            return ticket;
        } catch (error) {
            console.error(error);
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


//delete ticket by id
const deleteTicketById = async (id) => {


    try {
        const ticket = await Ticket.findByPk(id);
        await ticket.destroy();
        return ticket;
    } catch (error) {
        console.error(error);
    }
}


module.exports = {
    createTicket,
    getTickets,
    getTicketById,
    updateTicketById ,
    deleteTicketById
};