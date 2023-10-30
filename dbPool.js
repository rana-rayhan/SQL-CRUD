const { createPool } = require("mysql2");

const pool = createPool({
  host: "localhost",
  user: "root",
  password: "your_password",
  database: "your_database_name",
}).promise();

const connectiondb = async () => {
  pool
    .getConnection()
    .then((connection) => {
      console.log("Database connected");
      connection.release();
    })
    .catch((err) => {
      console.error("Error connecting to the database:", err.message);
    });
};

module.exports = {
  pool,
  connectiondb,
};
