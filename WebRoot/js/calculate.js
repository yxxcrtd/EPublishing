/**
 * 计算两个浮点数相除
 * @param {Number} arg1
 * @param {Number} arg2
 * @return {Number}
 */
function divide(arg1, arg2) {
    var t1 = 0, t2 = 0, r1, r2;
    try {t1 = arg1.toString().split(".")[1].length;} catch (e) {}
    try {t2 = arg2.toString().split(".")[1].length;} catch (e) {}
    with (Math) {
        r1 = Number(arg1.toString().replace(".", ""));
        r2 = Number(arg2.toString().replace(".", ""));
        return (r1 / r2) * pow(10, t2 - t1);
    }
}  // end divide
 
/**
 * 计算两个浮点数相乘
 * @param {Number} arg1
 * @param {Number} arg2
 * @return {Number}
 */
function multiply(arg1, arg2) {
    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
    try { m += s1.split(".")[1].length; } catch (e) {}
    try { m += s2.split(".")[1].length; } catch (e) {}
     return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
}  //end multiply
 
/**
 * 计算两个浮点数相加
 * @param {Number} arg1
 * @param {Number} arg2
 * @return {Number}
 */
function add(arg1, arg2) {
    var r1, r2, m, c;
    try {r1 = arg1.toString().split(".")[1].length;} catch (e) {r1 = 0;}
    try {r2 = arg2.toString().split(".")[1].length;} catch (e) {r2 = 0;}
    c = Math.abs(r1 - r2);
    m = Math.pow(10, Math.max(r1, r2));
    if (c > 0) {
        var cm = Math.pow(10, c);
        if (r1 > r2) {
            arg1 = Number(arg1.toString().replace(".", ""));
            arg2 = Number(arg2.toString().replace(".", "")) * cm;
        } else {
            arg1 = Number(arg1.toString().replace(".", "")) * cm;
            arg2 = Number(arg2.toString().replace(".", ""));
        }
    } else {
        arg1 = Number(arg1.toString().replace(".", ""));
        arg2 = Number(arg2.toString().replace(".", ""));
    }
    return (arg1 + arg2) / m;
}  //end add
     
/**
 * 计算两个浮点数相减
 * @param {Number} arg1
 * @param {Number} arg2
 * @return {Number}
 */
function subtract(arg1, arg2) {
    var r1, r2, m, n;
    try {r1 = arg1.toString().split(".")[1].length;} catch (e) {r1 = 0;}
    try {r2 = arg2.toString().split(".")[1].length;} catch (e) {r2 = 0;}
    m = Math.pow(10, Math.max(r1, r2));
    // 动态控制精度长度
    n = (r1 >= r2) ? r1 : r2;
    return ((arg1 * m - arg2 * m) / m).toFixed(n);
}   //end subtract