import { get, post } from "@/utils/request";

export const getRoleListByName = (obj: any) =>
  get("/api/getRoleListByName", obj);
