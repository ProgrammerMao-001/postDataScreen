import { get, post } from "@/utils/request";

export const addPost = (body: any) => post("api/addPost", body);
export const deletePost = (obj: any) => get("api/deletePost", obj);
export const updatePost = (body: any) => post("/api/updatePost", body);
// @ts-ignore
export const getPostDetail = (obj: any) => get("api/getPostDetail", obj);
export const getPostList = (obj: any) => get("api/getPostList", obj);
export const getPostListByPrams = (obj: any) =>
  get("api/getPostListByPrams", obj);
