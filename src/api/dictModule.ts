import { get, post } from "@/utils/request";

export const addDict = (body: any) => post("api/addDict", body);
export const deleteDict = (obj: any) => get("api/deleteDict", obj);
export const updateDict = (body: any) => post("/api/updateDict", body);
export const getDictListByName = (obj: any) =>
  get("/api/getDictListByName", obj);
export const getDictDetail = (obj: any) => get("/api/getDictDetail", obj);
