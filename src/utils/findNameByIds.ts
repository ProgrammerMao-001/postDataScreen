export default function findNamesByIds(treeData: any, ids: any) {
  const foundNames: any = [];
  function searchTree(node: any) {
    // 节点的唯一标识【node/id/...】
    if (ids.includes(node.code)) {
      // 节点名称【name】
      foundNames.push(node.name);
    }
    // 具有子节点的key【children/subLevelModelList】
    if (node.subLevelModelList && Array.isArray(node.subLevelModelList)) {
      for (const child of node.subLevelModelList) {
        searchTree(child);
      }
    }
  }
  treeData.forEach(searchTree);
  return foundNames;
}
