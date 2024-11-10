const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());

const connection = mysql.createConnection({
    host: 'localhost',//116.124.191.174
    user: 'dilrun2001_2023665',//dilrun2001_2023665
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

app.post('/signup', (req, res) => {
  const { username, userpassword } = req.body;

            const selectSql = "SELECT * FROM `member` WHERE `id` = ?;";

            connection.query(selectSql, [username], (err, results) => {
              if (err) {
                console.error('중복 확인 오류:', err);
                res.status(500).send('회원가입 중 오류 발생');
                return;
              }

              if (results.length > 0) {
                // 이미 같은 아이디가 있는 경우
                res.status(409).send({ message: '이미 사용 중인 아이디입니다' });
              } else {
                // 중복되지 않는 경우 새로운 회원 등록
                const insertSql = "INSERT INTO `member` (`id`, `pw`, `level`) VALUES (?, ?, '구매자');";

                connection.query(insertSql, [username, userpassword], (err, insertResults) => {
                  if (err) {
                    console.error('회원가입 오류:', err);
                    res.status(500).send('회원가입 중 오류 발생');
                    return;
                  }

                  if (insertResults.affectedRows > 0) {
                    res.status(201).send();
                  } else {
                    res.status(500).send({ message: '회원가입 실패' });
                  }
                });
              }
            });



});





app.listen(port, () => {
    console.log('Example app listening on port 15011!')
});