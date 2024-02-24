// 用于操作数据库
let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// GET 获取所有数据
exports.getCompanyList = (req, res) => {
    let sql = 'select * from companylist'
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
// 需要传入的参数 =》 企业名称：name、经营状态：business_status（都不传则默认所有数据）
exports.getCompanyListByPrams = (req, res) => {
    let sql = 'SELECT * FROM companylist';
    let obj = req.query;
    if (!obj) sql = 'SELECT name,remark FROM companylist'
    if (obj.business_status && !obj.name) sql = `SELECT * FROM companylist WHERE business_status = "${obj.business_status}"`
    if (obj.name && !obj.business_status) sql = `SELECT * FROM companylist WHERE name LIKE "%${obj.name}%"`
    if (obj.business_status && obj.name) sql = `SELECT * FROM companylist WHERE name LIKE "%${obj.name}%" AND business_status = "${obj.business_status}"`
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
// intro
// user_name
// user_id
// founded
// business_status
// address
// position
// province
// province_id
// social_code
// registration_authority
// business_scope
// photos
exports.addCompany = (req, res) => {
    let id = makeUuid()
    const body = req.body
    const query = 'SELECT * FROM companylist WHERE name=?'
    db.query(query, body.name, (err, result) => {
        if (err) return res.cc(err);
        if (result.length > 0) {
            res.send({
                status: 403, data: 'ok', message: '企业名称已存在'
            })
        } else {
            const sqlint = 'INSERT INTO companylist SET ?'
            db.query(sqlint, {
                id: id,
                name: body.name,
                intro: body.intro,
                user_name: body.user_name,
                user_id: body.user_id,
                founded: body.founded,
                business_status: body.business_status,
                address: body.address,
                position: body.position,
                province: body.province,
                province_id: body.province_id,
                social_code: body.social_code,
                registration_authority: body.registration_authority,
                business_scope: body.business_scope,
                photos: body.photos,
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
// intro
// user_name
// user_id
// founded
// business_status
// address
// position
// province
// province_id
// social_code
// registration_authority
// business_scope
// photos
exports.updateCompany = (req, res) => {
    let sql = 'UPDATE companylist SET name = ?, `intro` = ?, `user_name` = ?, `user_id` = ?, `founded` = ?, `business_status` = ?, `address` = ?, `position` = ?, `province` = ?, `province_id` = ?, `social_code` = ?, `registration_authority` = ?, `business_scope` = ?, `photos` = ? where `id` = ?'
    let arr = [
        req.body.name,
        req.body.intro,
        req.body.user_name,
        req.body.user_id,
        req.body.founded,
        req.body.business_status,
        req.body.address,
        req.body.position,
        req.body.province,
        req.body.province_id,
        req.body.social_code,
        req.body.registration_authority,
        req.body.business_scope,
        req.body.photos,
        req.body.id
    ]
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
exports.getCompanyDetail = (req, res) => {
    // 根据条件查询数据库表单的数据
    const sql = `SELECT * FROM companylist WHERE id = '${req.query.id}'`
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
exports.deleteCompany = (req, res) => {
    let sql = `DELETE FROM companylist WHERE id = "${req.query.id}"`
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: 'success'
        })
    })
}
