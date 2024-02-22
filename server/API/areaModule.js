let db = require('../db/index')
// GET 获取所有数据
exports.getAreaList = (req, res) => {
    let sql = 'select * from arealist'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: "success",
            data
        })
    })
}
