import { get, post } from "@/utils/request";

export const upload = (body: any) => post("api/upload", body);
export const getImg = (obj: any) => get("api/getImg", obj);
