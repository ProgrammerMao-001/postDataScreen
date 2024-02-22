/**
 * 计算指定的时间距离今天的天数
 * needDay所需的格式 '年-月-日 时:分:秒'
 */
export default function getDay(needDay: any) {
  var day =
      Math.floor(new Date().getTime() / 1000) -
      new Date(needDay).getTime() / 1000,
    day2 = Math.floor(day / (24 * 3600)),
    day3 = day2 * 24 * 3600,
    day4 = day - day3,
    day5 = Math.floor(day4 / 3600),
    day6 = day4 - day5 * 3600,
    day7 = Math.floor(day6 / 60),
    day8 = day6 - day7 * 60;
  // return (`${day2} 天 ${day5} 小时 ${day7} 分钟 ${day8} 秒`);
  return day2; // 计算出来的天数
}
