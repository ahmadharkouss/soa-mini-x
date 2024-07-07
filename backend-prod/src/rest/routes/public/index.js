var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('public_index', { title: 'Mini Twitter Public Web Api', });
});

module.exports = router;
