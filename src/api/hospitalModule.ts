import { get, post } from "@/utils/request";

export const getHospitalListByHName = (obj: any) =>
  get("/api/getHospitalListByHName", obj);
export const getHospitalDetail = (obj: any) =>
  get("/api/getHospitalDetail", obj);
export const updateHospital = (body: any) => post("/api/updateHospital", body);
