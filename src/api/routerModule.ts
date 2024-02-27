import { get, post } from "@/utils/request";

export const getList = () => get("/api/getList", null);
export const getRouterListByNameUrl = (obj: any) =>
  get("/api/getRouterListByNameUrl", obj);
export const getRouterListByParams = (obj: any) =>
  get("/api/getRouterListByParams", obj);
