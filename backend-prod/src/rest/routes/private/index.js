var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('private_index', { title: 'Mini Twitter Private Web Api', });
});

module.exports = router;