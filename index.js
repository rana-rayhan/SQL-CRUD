const express = require("express");
const { v4: uuidv4 } = require("uuid");
const { connectiondb, pool } = require("./dbPool");
const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.get("/left-join", async (req, res) => {
  try {
    const [data] = await pool.query(`
    SELECT students.id as studentId, students.studentName, courses.courseName
    FROM students
    LEFT JOIN courses 
    ON students.courseId = courses.courseId;`);
    res.json(data);
  } catch (error) {
    res.send(error);
    console.log(error);
  }
});

app.get("/", async (req, res, next) => {
  try {
    const [students] = await pool.query("SELECT * FROM students");
    res.status(200).json(students);
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.get("/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const [student] = await pool.query(`SELECT * FROM students WHERE id=?`, [
      id,
    ]);
    res.send(student);
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.post("/", async (req, res, next) => {
  try {
    const id = uuidv4();
    const { studentName, marks, courseId } = req.body;

    const [student] = await pool.query(
      `INSERT INTO students (id, studentName, marks, courseId) VALUE (?,?,?,?)`,
      [id, studentName, marks, courseId]
    );
    if (student.affectedRows === 1) {
      res.status(200).json({
        msg: "Student is created",
        student: { id, studentName, marks, courseId },
      });
    } else {
      res.status(500).json({ error: "Failed to insert data" });
    }
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.put("/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const { studentName, marks, courseId } = req.body;

    const [updateStudent] = await pool.query(
      `UPDATE students
      SET studentName=?, marks = ?,courseId=? 
      WHERE id=?;`,
      [studentName, marks, courseId, id]
    );

    res.json({ message: updateStudent.affectedRows, data: req.body });
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.delete("/:id", async (req, res, next) => {
  try {
    const id = req.params.id;

    const [updateStudent] = await pool.query(
      `DELETE FROM students
      WHERE id=?;`,
      [id]
    );

    res.json(updateStudent);
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}!`);
  connectiondb();
});
