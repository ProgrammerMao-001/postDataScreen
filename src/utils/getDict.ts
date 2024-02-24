/**
 * 获取数据字典
 * @param: name: 字典名称
 * @return: Promise<any>
 * @time: 2024-02-24 20:50:18
 **/
import { getDictListByPrams } from "@/api/dictModule";

export default async function getDict(name: string) {
  return new Promise((resolve, reject) => {
    getDictListByPrams({ name })
      .then((res: any) => {
        resolve(res);
      })
      .catch((err: any) => {
        reject(err);
      });
  });
}
