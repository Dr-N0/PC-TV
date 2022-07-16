const express = require("express");
const router = express.Router();

const { pc_searching } = require("./connect");

router.route("/pc_searching").post(pc_searching);

module.exports = router;