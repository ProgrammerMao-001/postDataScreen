let db = require('../db/index')
let makeUuid = require("../utils/makeUuid")
// GET 获取所有数据
exports.getClockCardList = (req, res) => {
    let sql = 'select * from clocklist'
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


// POST 新增
// id
// datetime     打卡时间
// userid       打卡人
// isgood       是否健康
// isout        是否出省

exports.addClockCard = (req, res) => {
    let id = makeUuid()
    const body = req.body
    const query = 'SELECT * FROM clocklist WHERE datetime=? AND userid = ?'
    db.query(query, [req.body.datetime, req.body.userid], (err, result) => {
        // console.log(query, 'query')
        if (err) return res.cc(err);
        if (result.length > 0) {
            res.send({
                status: 201,
                data: 'ok',
                message: '你已经打过卡了！'
            })
        } else {
            const sqlint = 'INSERT INTO clocklist SET ?'
            db.query(sqlint,
                {
                    id: id,
                    datetime: body.datetime,
                    userid: body.userid,
                }, (err, result) => {
                    if (err) return res.cc(err)
                    if (!result.affectedRows) return res.cc('打卡失败！')
                    res.send({
                        status: 200,
                        data: 'ok',
                        message: '打卡成功！'
                    })
                })
        }
    })
}
