// 用于操作数据库
let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// GET 获取所有数据
exports.getPostList = (req, res) => {
    let sql = 'select * from postlist'
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
// 需要传入的参数 =》 岗位名称：name，企业id：company_id（不传则默认所有数据）
// exports.getPostListByPrams = (req, res) => {
//     let sql = 'SELECT * FROM postlist';
//     let obj = req.query;
//     if (!obj) sql = 'SELECT name FROM postlist'
//     if (obj.name) sql = `SELECT * FROM postlist WHERE name LIKE "%${obj.name}%"`
//     db.query(sql, (err, data, fields) => {
//         if (err) {
//             return res.send('错误：' + err.message)
//         }
//         res.send({
//             status: 200, message: "success", data
//         });
//     })
// }

exports.getPostListByPrams = (req, res) => {
    let sql = 'SELECT * FROM postlist';
    let obj = req.query;
    if (!obj) sql = 'SELECT name,company_id FROM postlist'
    if (obj.company_id && !obj.name) sql = `SELECT * FROM postlist WHERE company_id = "${obj.company_id}"`
    if (obj.name && !obj.company_id) sql = `SELECT * FROM postlist WHERE name LIKE "%${obj.name}%"`
    if (obj.company_id && obj.name) sql = `SELECT * FROM postlist WHERE name LIKE "%${obj.name}%" AND company_id = "${obj.company_id}"`
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
// salary_range
// avg_range
// desc
// recruitment_status
// post_type
// company_name
// company_id
// company_address
// company_position
// company_province
// company_province_id
// education
// work_life
exports.addPost = (req, res) => {
    let id = makeUuid()
    const body = req.body
    const sqlint = 'INSERT INTO postlist SET ?'
    db.query(sqlint, {
        id: id,
        name: body.name,
        salary_range: body.salary_range,
        avg_range: body.avg_range,
        desc: body.desc,
        recruitment_status: body.recruitment_status,
        post_type: body.post_type,
        company_name: body.company_name,
        company_id: body.company_id,
        company_address: body.company_address,
        company_position: body.company_position,
        company_province: body.company_province,
        company_province_id: body.company_province_id,
        education: body.education,
        work_life: body.work_life,
    }, (err, result) => {
        if (err) return res.cc(err)
        if (!result.affectedRows) return res.cc('新增失败')
        res.send({
            status: 200, data: 'ok', message: 'success'
        })
    })
}

// POST 编辑
exports.updatePost = (req, res) => {
    let sql = 'UPDATE postlist SET name = ?, `salary_range` = ?, `avg_range` = ?, `desc` = ?, `recruitment_status` = ?, `post_type` = ?, `company_name` = ?, `company_id` = ?, `company_address` = ?, `company_position` = ?, `company_province` = ?, `company_province_id` = ?, `education` = ?, `work_life` = ? where `id` = ?'
    let arr = [
        req.body.name,
        req.body.salary_range,
        req.body.avg_range,
        req.body.desc,
        req.body.recruitment_status,
        req.body.post_type,
        req.body.company_name,
        req.body.company_id,
        req.body.company_address,
        req.body.company_position,
        req.body.company_province,
        req.body.company_province_id,
        req.body.education,
        req.body.work_life,
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
exports.getPostDetail = (req, res) => {
    // 根据条件查询数据库表单的数据
    const sql = `SELECT * FROM postlist WHERE id = '${req.query.id}'`
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
exports.deletePost = (req, res) => {
    let sql = `DELETE FROM postlist WHERE id = "${req.query.id}"`
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200, message: 'success'
        })
    })
}
