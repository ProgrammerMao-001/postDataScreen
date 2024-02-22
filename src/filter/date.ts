import Dayjs from "dayjs";

export function formatDate(date: any, formate: string) {
  return Dayjs(date).format(formate);
}

export default { formatDate };
