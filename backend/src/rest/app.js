


var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');



var indexRouter = require('./routes/index');
var publicIndexRouter = require('./routes/public/index');
var privateIndexRouter = require('./routes/private/index');



var privateUsersRouter = require('./routes/private/User/user.crud.api');
var publicRouter = require('./routes/public/get');
var privateTicketRouter = require('./routes/private/Ticket/ticket.crud.api');
var privateRoomRouter = require('./routes/private/Room/room.crud.api');
var privateUserRoomRouter = require('./routes/private/user-room.api');
var privateRoomAdminRouter = require('./routes/private/room-admin-api');

var privateRedisLogPlugin  = require('./routes/private/logs.api');


var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


// Import routes
app.use('/', indexRouter);
app.use('/public', publicIndexRouter);
app.use('/private', privateIndexRouter);

app.use('/public/', publicRouter);


app.use('/private/users', privateUsersRouter);
app.use('/private/tickets', privateTicketRouter);
app.use('/private/rooms',  privateRoomRouter);
app.use('/private/rooms/', privateUserRoomRouter);
app.use('/private/rooms/admin', privateRoomAdminRouter);
app.use('/private/plugin/logs', privateRedisLogPlugin);



const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');

const swaggerOptions = {
  swaggerDefinition: {
    openapi: '3.0.0',
    info: {
      title: 'Transaction API',
      version: '1.0.0',
      description: 'Transaction API Information',
    },
    servers: [
      {
        url: 'https://x.devgains.com/private',
        description: 'Prod Private server',
      },
    ],
   components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
    security: [
      {
        bearerAuth: [],
      },
    ],	  
  },
  apis: ['./src/rest/routes/private/User/user.crud.api.js',
    './src/rest/routes/private/Room/room.crud.api.js',
    './src/rest/routes/private/Ticket/ticket.crud.api.js',
    './src/rest/routes/private/user-room.api.js',
    './src/rest/routes/private/room-admin-api.js',
    './src/rest/routes/private/logs.api.js'
  ], // Path to the API docs
};

const swaggerOptions2 = {
  swaggerDefinition: {
    openapi: '3.0.0',
    info: {
      title: 'Public API',
      version: '1.0.0',
      description: 'Public API Information',
    },
    servers: [
      {
        url: 'https://x.devgains.com/public',
        description: 'Prod Public server',
      },
    ],
  },
  apis: ['./src/rest/routes/public/get.js'], // Path to the API docs
};
/*
const swaggerSpec =swaggerJsdoc(swaggerOptions);
const swaggerSpec2 =swaggerJsdoc(swaggerOptions2);
app.use('/private/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.use('/public/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec2));
*/

const swaggerSpec = swaggerJsdoc(swaggerOptions);
const swaggerSpec2 = swaggerJsdoc(swaggerOptions2);

// Separate middleware instances
const privateSwaggerMiddleware = swaggerUi.setup(swaggerSpec);
const publicSwaggerMiddleware = swaggerUi.setup(swaggerSpec2);
app.use('/private/api-docs2', swaggerUi.serveFiles(swaggerSpec), privateSwaggerMiddleware);
app.use('/public/api-docs', swaggerUi.serveFiles(swaggerSpec2), publicSwaggerMiddleware);
// catch 404 and forward to error handler

/*
app.use(function(req, res, next) {
  next(createError(404));
});
*/
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  //res.locals.message = err.message;
  //res.locals.title = 'Mini Twitter Web Api'; // Set the title
  //res.locals.error = req.app.get('env') === 'development' ? err : {};
  // render the error page
  res.status(err.status || 500);
  //res.render('error');
});


module.exports = app;
