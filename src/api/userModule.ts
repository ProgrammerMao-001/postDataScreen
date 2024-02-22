import { get, post } from "@/utils/request";

export const getPicCode = () => get("api/getPicCode", null);
export const login = (body: any) => post("api/login", body);
export const register = (body: any) => post("api/register", body);
export const deleteUser = (obj: any) => get("api/deleteUser", obj);
export const updateUser = (body: any) => post("api/updateUser", body);
export const getUserByUserName = (obj: any) =>
  get("api/getUserByUserName", obj);
export const getUserDetail = (obj: any) => get("api/getUserDetail", obj);
