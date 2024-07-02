/**
 * @api {get} / Index
 * @apiName Index
 * @apiGroup Index
 * @apiDescription Index page
 * @apiVersion 1.0.0
 
  * @apiSuccess {String} title Title of the page
    
 */


var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Mini Twitter Web Api' });
});

module.exports = router;
