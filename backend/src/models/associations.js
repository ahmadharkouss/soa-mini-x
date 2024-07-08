const {User} = require('./Room-User/User');
const {Room} = require('./Room-User/Room');
const {UsersRoomsRoles} = require('./Room-User/Users_Rooms_Roles');
const {Ticket} = require('./Ticket/Ticket');
const {TicketEdits} = require('./Ticket/Ticket_Edits');
const {Logs} = require('./logs');


// Define associations between models

//many to many relationship between User and Room
User.belongsToMany(Room, { through: UsersRoomsRoles, foreignKey: 'userId' });
Room.belongsToMany(User, { through: UsersRoomsRoles, foreignKey: 'roomId' });

//one to many relationship between Room and Ticket = room has many tickets
Room.hasMany(Ticket, { foreignKey: 'roomId' });
Ticket.belongsTo(Room, { foreignKey: 'roomId' });

//one to many relationship between Ticket and TicketEdits = ticket has many ticket edits
Ticket.hasMany(TicketEdits, { foreignKey: 'ticketId' });
TicketEdits.belongsTo(Ticket, { foreignKey: 'ticketId' });

//one to many relationship between User and Ticket = user has many tickets
User.hasMany(Ticket, { foreignKey: {allowNull: false, name: 'createdBy'}});
Ticket.belongsTo(User, { foreignKey: {allowNull: false, name: 'createdBy'} });

//Ticket.hasMany(Ticket, { foreignKey: 'parent_Ticket', as: 'replies' });


//one to many relationship between User and Logs = user has many logs
User.hasMany(Logs, { foreignKey: 'userId' });
Logs.belongsTo(User, { foreignKey: 'userId' });
