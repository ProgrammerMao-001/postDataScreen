// 用于操作数据库
let db = require('../db/index')

// GET 查询数据
// 需要传入的参数 =》 医院名：hname、地区id：areaid（都不传则默认所有数据）
exports.getHospitalListByHName = (req, res) => {
    let sql = 'SELECT * FROM hospitallist';
    let obj = req.query;
    if (!obj) sql = 'SELECT hname,areaid FROM hospitallist'
    if (obj.areaid && !obj.hname) sql = `SELECT * FROM hospitallist WHERE areaid = "${obj.areaid}"`
    if (obj.hname && !obj.areaid) sql = `SELECT * FROM hospitallist WHERE hname = "${obj.hname}"`
    if (obj.areaid && obj.hname) sql = `SELECT * FROM hospitallist WHERE hname = "${obj.hname}" AND areaid = "${obj.areaid}"`
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


// POST 编辑
// id
// areaid       区域id (不能编辑)
// hname        地区名称(不能编辑)
// firstnum     第一针疫苗数
// secondnum    第二针疫苗数
// thirdnum     第三针疫苗数
exports.updateHospital = (req, res) => {
    let sql = 'UPDATE hospitallist SET areaid = ?, `hname` = ?, `firstnum` = ?, `secondnum` = ?, `thirdnum` = ? where `id` = ?'
    let arr = [req.body.areaid, req.body.hname, req.body.firstnum, req.body.secondnum, req.body.thirdnum, req.body.id]
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
exports.getHospitalDetail = (req, res) => {
    // 根据条件查询数据库表单的数据
    const sql = `SELECT * FROM hospitallist WHERE id = '${req.query.id}'`
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
