function showMemory() {
    const used = process.memoryUsage();
    console.log('------------------------------------');
    for (let key in used) {
        console.log(`${key} ${Math.round(used[key] / 1024 / 1024 * 100) / 100} MB`);
    }
}

const arr = [1, 2, 3, 4, 5, 6, 9, 7, 8, 9, 10];
showMemory();
arr.reverse();
showMemory();

let arr2 = Array(1e6).fill("some string");
showMemory();
arr2.reverse();
showMemory();
