// 用于操作数据库
let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// 获取所有数据
exports.getList = (req, res) => {
    let sql = 'select * from routerlist'
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

// GET 查询数据
// 需要传入的参数 =》 名称：name、地址：url（都不传则默认所有数据）
exports.getRouterListByNameUrl = (req, res) => {
    let sql = 'SELECT * FROM routerlist';
    let obj = req.query;
    if (!obj) sql = 'SELECT name,url FROM routerlist'
    if (obj.url && !obj.name) sql = `SELECT * FROM routerlist WHERE url = "${obj.url}"`
    if (obj.name && !obj.url) sql = `SELECT * FROM routerlist WHERE name = "${obj.name}"`
    if (obj.url && obj.name) sql = `SELECT * FROM routerlist WHERE name = "${obj.name}" AND url = "${obj.url}"`
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
