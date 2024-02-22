/* 字典 */
let db = require('../db/index')

// GET 查询治愈情况（已治愈，已死亡，治疗中）
exports.getStatus = (req, res) => {
    let sql = 'SELECT * FROM statuslist';
    db.query(sql, (err, data, fields) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: "success",
            data
        });
    })
}
