// 用于配置数据库相关信息
let mysql = require('mysql')
// 创建连接池
let db = mysql.createPool({
    host: '127.0.0.1',  //数据库IP地址
    user: 'root', //数据库登录账号
    password: '', //数据库登录密码
    database: 'postdatascreen' //要操作的数据库
})
module.exports = db
