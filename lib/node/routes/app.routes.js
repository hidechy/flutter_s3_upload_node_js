const uploadController = require('../controller/uploads.controller');

const express = require('express');
const router = express.Router();

router.post('/image-upload', uploadController.uploadFile);

module.exports = router;
