// 用于操作数据库
let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// GET 获取所有数据
exports.getDictList = (req, res) => {
    let sql = 'select * from dictlist'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: "success", data
        })
    })
}

// GET 查询数据
// 需要传入的参数 =》 名称：name、备注：remark（都不传则默认所有数据）
exports.getDictListByPrams = (req, res) => {
    let sql = 'SELECT * FROM dictlist';
    let obj = req.query;
    if (!obj) sql = 'SELECT name,remark FROM dictlist'
    // if (obj.remark && !obj.name) sql = `SELECT * FROM dictlist WHERE remark = "${obj.remark}"` // 精确查询
    if (obj.remark && !obj.name) sql = `SELECT * FROM dictlist WHERE remark LIKE "%${obj.remark}%"` // 模糊查询
    // if (obj.name && !obj.remark) sql = `SELECT * FROM dictlist WHERE name = "${obj.name}"`
    if (obj.name && !obj.remark) sql = `SELECT * FROM dictlist WHERE name LIKE "%${obj.name}%"`
    // if (obj.remark && obj.name) sql = `SELECT * FROM dictlist WHERE name = "${obj.name}" AND remark = "${obj.remark}"`
    if (obj.remark && obj.name) sql = `SELECT * FROM dictlist WHERE name LIKE "%${obj.name}%" AND remark LIKE "%${obj.remark}%"`
    db.query(sql, (err, data, fields) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: "success", data
        });
    })
}


// POST 新增
// id
// name
// data
// remark
exports.addDict = (req, res) => {
    let id = makeUuid()
    const body = req.body
    const query = 'SELECT * FROM dictlist WHERE name=?'
    db.query(query, body.name, (err, result) => {
        if (err) return res.cc(err);
        if (result.length > 0) {
            res.send({
                status: 403, data: 'ok', message: '字典名已存在'
            })
        } else {
            const sqlint = 'INSERT INTO dictlist SET ?'
            db.query(sqlint, {
                id: id,
                name: body.name,
                data: body.data,
                remark: body.remark,
            }, (err, result) => {
                if (err) return res.cc(err)
                if (!result.affectedRows) return res.cc('新增失败')
                res.send({
                    status: 200, data: 'ok', message: 'success'
                })
            })
        }
    })
}

// POST 编辑
// id
// name
// data
// remark
exports.updateDict = (req, res) => {
    let sql = 'UPDATE dictlist SET name = ?, `data` = ?, `remark` = ? where `id` = ?'
    let arr = [req.body.name, req.body.data, req.body.remark, req.body.id]
    db.query(sql, arr, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        if (data.changedRows > 0) {
            res.send({
                status: 200, message: 'success',
            })
        } else {
            res.send({
                status: 500, message: '服务器错误，请联系管理员。'
            })
        }
    })
}

// GET 详情
// 需要传入的参数 =》 id：id
exports.getDictDetail = (req, res) => {
    // 根据条件查询数据库表单的数据
    const sql = `SELECT * FROM dictlist WHERE id = '${req.query.id}'`
    db.query(sql, (err, data, fields) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: "success", data
        });
    })
}

// GET 删除
// 需要传入的参数 =》 id(必填)
exports.deleteDict = (req, res) => {
    let sql = `DELETE FROM dictlist WHERE id = "${req.query.id}"`
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: 'success'
        })
    })
}
