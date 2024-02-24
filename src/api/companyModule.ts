import { get, post } from "@/utils/request";

export const addCompany = (body: any) => post("api/addCompany", body);
export const deleteCompany = (obj: any) => get("api/deleteCompany", obj);
export const updateCompany = (body: any) => post("/api/updateCompany", body);
// @ts-ignore
export const getCompanyDetail = (obj: any) => get("api/getCompanyDetail", obj);
export const getCompanyList = (obj: any) => get("api/getCompanyList", obj);
export const getCompanyListByPrams = (obj: any) =>
  get("api/getCompanyListByPrams", obj);
