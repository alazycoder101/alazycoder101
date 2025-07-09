let name = "Hua Qiang"

function getUsr(userId) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('Ada')
        }, 50)
    })
}
function getUser(userId) {
    return new Promise((resolve, reject) => {
        resolve(userId)
    })
}
console.log('name=', name)
getUsr("ada").then (u => name = u)
getUser("Tda").then (u => name = u)
console.log('name=', name)
setTimeout(() => console.log('name=', name), 40)
setTimeout(() => console.log('name=', name), 60)

function getUser2(userId) {
  return { name: 'Ada'}
}
