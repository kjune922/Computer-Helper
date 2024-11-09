const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'dilrun2001_2023665',
    password: 'dilrun2001_2023665',
    database: 'dilrun2001_2023665'
});

connection.connect((err) => {
    if (err) {
        console.error('MySQL 연결 오류:', err);
        return;
    }
    console.log('MySQL에 연결되었습니다.');
});


const port = 15011;

app.get('/cpu', (req, res) => {
    const sql ="SELECT * from cpu;"
    connection.query(sql, (err, results) => {
        res.send(results)
    });

});

app.post('/cpudetail', (req, res) => {
    const {productname} = req.body;
    const sql ="SELECT * from cpu WHERE cpu_name = ?;"
    connection.query(sql,[productname], (err, results) => {
        res.send(results)
    });

});

app.get('/graphics', (req, res) => {
    const sql ="SELECT * from graphics;"
    connection.query(sql, (err, results) => {
        res.send(results)
    });

});

app.post('/graphicsdetail', (req, res) => {
    const {productname} = req.body;
    const sql ="SELECT * from graphics WHERE graphics_name = ?;"
    connection.query(sql,[productname], (err, results) => {
        res.send(results)
    });

});

app.get('/mainboard', (req, res) => {
    const sql ="SELECT * from mainboard;"
    connection.query(sql, (err, results) => {
        res.send(results)
    });

});

app.post('/mainboarddetail', (req, res) => {
    const {productname} = req.body;
    const sql ="SELECT * from mainboard WHERE mainboard_name = ?;"
    connection.query(sql,[productname], (err, results) => {
        res.send(results)
    });

});

app.post('/login', (req, res) => {
  const { username, userpassword } = req.body;

    const sql ="SELECT * from member WHERE id = ? AND pw = ?;"

    connection.query(sql, [username, userpassword], (err, results) => {
            if (err) {
                console.error('쿼리 실행 오류:', err);
                res.status(500).send('로그인 중 오류 발생');
                return;
            }
            if (results.length > 0) {
                res.status(200).send(results);
            } else {
               res.status(404).send({ message: '아이디 혹은 비밀번호가 틀렸습니다' });
            }
    });
});



app.listen(port, () => {
    console.log('Example app listening on port 3000!')
});