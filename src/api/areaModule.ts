import { get, post } from "@/utils/request";

export const getAreaList = (obj: any) => get("/api/getAreaList", obj);
