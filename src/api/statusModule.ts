import { get, post } from "@/utils/request";

export const getStatus = () => get("/api/getStatus", null);
