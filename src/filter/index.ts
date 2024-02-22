import DataFilter from "@/filter/date";

const install = function (Vue: any, opts = {}) {
  Vue.filter("formatDate", DataFilter.formatDate);
};

export default { install };
