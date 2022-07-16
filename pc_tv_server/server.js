const express = require("express");
const connectDB = require("./db");
const app = express();

if (process.env.NODE_ENV !== 'production'){
  require('dotenv').config();
}

const PORT = process.env.PORT || 5000;

connectDB();

app.use(express.json());

// Routes
app.use("/api", require("./Connect/route"));
app.use("/api/auth", require("./Auth/route"));

const server = app.listen(PORT, () =>
  console.log(`Server Connected to port ${PORT}`)
);

process.on("unhandledRejection", (err) => {
  console.log(`An error occurred: ${err.message}`);
  server.close(() => process.exit(1));
});