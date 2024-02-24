import { get, post } from "@/utils/request";

export const addDict = (body: any) => post("api/addDict", body);
export const deleteDict = (obj: any) => get("api/deleteDict", obj);
export const updateDict = (body: any) => post("/api/updateDict", body);
export const getDictDetail = (obj: any) => get("api/getDictDetail", obj);
export const getDictList = (obj: any) => get("api/getDictList", obj);
export const getDictListByPrams = (obj: any) =>
  get("api/getDictListByPrams", obj);
