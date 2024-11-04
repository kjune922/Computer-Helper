const express = require('express');
const mysql = require('mysql2');

const app = express();

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '1234',
    database: 'pc_db'
});

connection.connect((err) => {
    if (err) {
        console.error('MySQL 연결 오류:', err);
        return;
    }
    console.log('MySQL에 연결되었습니다.');
});


const port = 3000;

app.get('/', (req, res) => {
    const sql ="SELECT * from cpu;"
    connection.query(sql, (err, results) => {
        res.send(results)
    });

});

app.listen(port, () => {
    console.log('Example app listening on port 3000!')
});