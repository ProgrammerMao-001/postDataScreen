// 用于操作数据库
let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// GET 获取所有数据
exports.getDefiniteList = (req, res) => {
    let sql = 'select * from definitelist'
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
// 需要传入的参数 =》 名称：name、密接人：staticname（都不传则默认所有数据）
exports.getDefiniteListByName = (req, res) => {
    let sql = 'SELECT * FROM definitelist';
    let obj = req.query;
    if (!obj) sql = 'SELECT name,staticname FROM definitelist'
    if (obj.staticname && !obj.name) sql = `SELECT * FROM definitelist WHERE staticname = "${obj.staticname}"`
    if (obj.name && !obj.staticname) sql = `SELECT * FROM definitelist WHERE name = "${obj.name}"`
    if (obj.staticname && obj.name) sql = `SELECT * FROM definitelist WHERE name = "${obj.name}" AND staticname = "${obj.staticname}"`
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


// POST 新增
// id
// name            确诊人（单个）
// namephone       确诊人联系方式
// namein          确诊人隔离地点
// namewhere       确诊人居住地
// namestatus      确诊人状态（已治愈，已死亡，治疗中）
// namestatusid    确诊人状态id
// staticname      密接人（单个）
// staticphone     密接人联系方式
// staticin        密接人隔离地点
// staticwhere     密接人居住地
// staticstatus    密接人状态
// staticstatusid  密接人状态id
exports.addDefinite = (req, res) => {
    let id = makeUuid()
    const body = req.body
    const query = 'SELECT * FROM definitelist WHERE name=?'
    db.query(query, body.name, (err, result) => {
        if (err) return res.cc(err);
        if (result.length > 0) {
            res.send({
                status: 403,
                data: 'ok',
                message: '确诊人已存在'
            })
        } else {
            const sqlint = 'INSERT INTO definitelist SET ?'
            db.query(sqlint,
                {
                    name: body.name,
                    namephone: body.namephone,
                    namein: body.namein,
                    namewhere: body.namewhere,
                    namestatus: body.namestatus,
                    namestatusid: body.namestatusid,
                    staticname: body.staticname,
                    staticphone: body.staticphone,
                    staticin: body.staticin,
                    staticwhere: body.staticwhere,
                    staticstatus: body.staticstatus,
                    staticstatusid: body.staticstatusid,
                    id: id,
                }, (err, result) => {
                    if (err) return res.cc(err)
                    if (!result.affectedRows) return res.cc('新增失败')
                    res.send({
                        status: 200,
                        data: 'ok',
                        message: 'success'
                    })
                })
        }
    })
}

// POST 编辑
// id
// name            确诊人（单个）
// namephone       确诊人联系方式
// namein          确诊人隔离地点
// namewhere       确诊人居住地
// staticname      密接人（单个）
// staticphone     密接人联系方式
// staticin        密接人隔离地点
// staticwhere     密接人居住地
exports.updateDefinite = (req, res) => {
    let sql = 'UPDATE definitelist SET name = ?, `namephone` = ?, `namein` = ?, `namewhere` = ?, `namestatus` = ?, `namestatusid` = ?, `staticname` = ?, `staticphone` = ?, `staticin` = ?, `staticwhere` = ?, `staticstatus` = ?, `staticstatusid` = ? where `id` = ?'
    let arr = [req.body.name, req.body.namephone, req.body.namein, req.body.namewhere, req.body.namestatus, req.body.namestatusid, req.body.staticname, req.body.staticphone, req.body.staticin, req.body.staticwhere, req.body.staticstatus, req.body.staticstatusid, req.body.id]
    db.query(sql, arr, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        if (data.changedRows > 0) {
            res.send({
                status: 200,
                message: 'success',
            })
        } else {
            res.send({
                status: 500,
                message: '服务器错误，请联系管理员。'
            })
        }
    })
}

// GET 详情
// 需要传入的参数 =》 id：id
exports.getDefiniteDetail = (req, res) => {
    // 根据条件查询数据库表单的数据
    const sql = `SELECT * FROM definitelist WHERE id = '${req.query.id}'`
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

// GET 删除
// 需要传入的参数 =》 id(必填)
exports.deleteDefinite = (req, res) => {
    let sql = `DELETE FROM definitelist WHERE id = "${req.query.id}"`
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: 'success'
        })
    })
}
