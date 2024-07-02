


var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');


var usersRouter = require('./routes/User/user.crud.api');
var indexRouter = require('./routes/index');

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
app.use('/public', indexRouter);
app.use('/private/users', usersRouter);


const swaggerUi = require('swagger-ui-express');
//const swaggerDocument = require('./swagger.json');
const swaggerJsdoc = require('swagger-jsdoc');

const swaggerOptions  = {
  swaggerDefinition: {
      openapi: '3.0.0',
      info: {
          title: 'User API',
          version: '1.0.0',
          description: 'A simple CRUD API for users',
      },
      servers: [
          {
              url: 'http://localhost:4000',
              description: 'Local server',
          },
      ],
  },
  apis: ['./src/rest/routes/User/user.crud.api.js'] // Path to the API docs
};
const swaggerSpec =swaggerJsdoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// catch 404 and forward to error handler
/*
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  //res.locals.title = 'Mini Twitter Web Api'; // Set the title
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
*/

module.exports = app;
