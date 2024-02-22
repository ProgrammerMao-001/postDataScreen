import { get, post } from "@/utils/request";

export const getDefiniteList = (obj: any) => get("/api/getDefiniteList", obj);
export const getDefiniteListByName = (obj: any) =>
  get("/api/getDefiniteListByName", obj);
export const addDefinite = (body: any) => post("/api/addDefinite", body);
export const updateDefinite = (body: any) => post("/api/updateDefinite", body);
export const getDefiniteDetail = (obj: any) =>
  get("/api/getDefiniteDetail", obj);
export const deleteDefinite = (obj: any) => get("/api/deleteDefinite", obj);
