// 用于配置对应路由
let express = require('express')
let router = express.Router()

let userModule = require('./API/userModule')
let roleModule = require('./API/roleModule')
let routerModule = require('./API/routerModule')
let uploadModule = require('./API/uploadModule')
let dictModule = require('./API/dictModule')

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

/* 字典模块 */
router.get('/getDictList', dictModule.getDictList)
router.get('/getDictListByPrams', dictModule.getDictListByPrams)
router.post('/addDict', dictModule.addDict)
router.post('/updateDict', dictModule.updateDict)
router.get('/getDictDetail', dictModule.getDictDetail)
router.get('/deleteDict', dictModule.deleteDict)
/* 字典模块 */

module.exports = router
