// module.exports = function makeToken(length) {
//     let token = 'token-' + Number(Math.random().toString().substr(3, length) + Date.now()).toString(36);
//     return token
// }
//

module.exports = function makeToken() {
    return 'token-' + Number(Math.random().toString().substr(3, 30) + Date.now()).toString(36);
}
