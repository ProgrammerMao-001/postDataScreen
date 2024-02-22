// 用于操作数据库
let db = require('../db/index')

// GET 查询数据
// 需要传入的参数 =》 名称：name （都不传则默认所有数据）
exports.getRoleListByName = (req, res) => {
    let sql = 'SELECT * FROM rolelist';
    let obj = req.query;
    if (obj.name) sql = `SELECT * FROM rolelist WHERE name = "${obj.name}"`
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
