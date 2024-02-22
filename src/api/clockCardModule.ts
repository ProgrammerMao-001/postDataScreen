import { get, post } from "@/utils/request";

export const getClockCardList = (obj: any) => get("/api/getClockCardList", obj);
export const addClockCard = (body: any) => post("/api/addClockCard", body);
