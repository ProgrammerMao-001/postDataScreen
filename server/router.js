// 用于配置对应路由
let express = require('express')
let router = express.Router()

let userModule = require('./API/userModule')
let roleModule = require('./API/roleModule')
let routerModule = require('./API/routerModule')
let uploadModule = require('./API/uploadModule')
// let definiteModule = require('./API/definiteModule')

router.get('/', (req, res) => {
    res.send('express启动成功!');
})

/* 登陆注册模块 */
router.get('/getPicCode', userModule.getPicCode)
router.post('/login', userModule.login)
router.post('/register', userModule.register)
router.get('/deleteUser', userModule.deleteUser)
router.post('/updateUser', userModule.updateUser)
router.get('/getUserByUserName', userModule.getUserByUserName)
router.get('/getUserDetail', userModule.getUserDetail)
/* 登陆注册模块 */

/* 角色管理模块（用户权限） */
router.get('/getRoleListByName', roleModule.getRoleListByName)
/* 角色管理模块（用户权限） */

/* 菜单配置模块 */
router.get('/getList', routerModule.getList)
router.get('/getRouterListByNameUrl', routerModule.getRouterListByNameUrl)
/* 菜单配置模块 */

/* 图片上传 */
router.post('/upload', uploadModule.upload)
router.get('/getImg', uploadModule.getImg)
/* 图片上传 */

// /* 确诊人模块 */
// router.get('/getDefiniteList', definiteModule.getDefiniteList)
// router.get('/getDefiniteListByName', definiteModule.getDefiniteListByName)
// router.post('/addDefinite', definiteModule.addDefinite)
// router.post('/updateDefinite', definiteModule.updateDefinite)
// router.get('/getDefiniteDetail', definiteModule.getDefiniteDetail)
// router.get('/deleteDefinite', definiteModule.deleteDefinite)
// /* 确诊人模块 */


module.exports = router
