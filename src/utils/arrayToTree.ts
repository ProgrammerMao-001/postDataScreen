// 数组转树结构
function sortArr(a: any, b: any) {
  return a.orderNum - b.orderNum;
}

export function arrayToTree(
  list: object[],
  callback: any = () => {},
  props = { id: "id", pid: "pid", children: "children" }
) {
  list.sort(sortArr);
  const tree: object[] = [];
  const map: any = {};

  // list = cloneObj(list);

  const listLength = list.length;
  for (let i = 0; i < listLength; i++) {
    const node: any = list[i];
    const nodeId: any = node[props.id];
    map[nodeId] = node;
    callback(node);
  }

  for (let i = 0; i < listLength; i++) {
    const node: any = list[i];
    const nodePid: any = node[props.pid];
    const parentNode: any = map[nodePid];
    if (parentNode) {
      parentNode[props.children] = parentNode[props.children] || [];
      parentNode[props.children].push(node);
    } else {
      tree.push(node);
    }
  }

  return tree;
}

// 遍历树结构
export function ergodicTree(
  tree: object[],
  callback: any = () => {},
  props = { id: "id", pid: "pid", children: "children" }
) {
  function _ergodicTree(
    tree: object[],
    parentIdPath?: any[],
    depth = 0,
    parentIndex?: any[]
  ) {
    const treeLength = tree.length;
    for (let i = 0; i < treeLength; i++) {
      const node: any = tree[i];
      const _idPath: any[] = parentIdPath
        ? [...parentIdPath, node[props.id]]
        : [node[props.id]];
      const _depth: number = depth + 1;
      const _index: any[] = parentIndex ? [...parentIndex, i] : [i];
      node._idPath = _idPath;
      node._depth = _depth;
      node._index = _index;
      callback(node);
      if (node[props.children] && node[props.children] instanceof Array) {
        _ergodicTree(node[props.children], _idPath, _depth, _index);
      }
    }
    return tree;
  }

  _ergodicTree(tree);
  return tree;
}

//获取所有子孙节点 arr为list结构
export function sonsTree(arr: any[], id: string): any[] {
  const temp: any[] = [],
    lev = 0;
  const forFn = function (arr: any[], id: string, lev: number) {
    for (let i = 0; i < arr.length; i++) {
      const item: any = arr[i];
      if (item.pid == id) {
        item.lev = lev;
        temp.push(item);
        forFn(arr, item.id, lev + 1);
      }
    }
  };
  forFn(arr, id, lev);
  return temp;
}

// 获取所有父节点
export function getParent(data2: any, nodeId2: any) {
  let arrRes: any[] = [];
  if (data2.length == 0) {
    if (!!nodeId2) {
      arrRes.unshift(data2);
    }
    return arrRes;
  }
  const rev = (data: any, nodeId: any) => {
    for (let i = 0, length = data.length; i < length; i++) {
      const node = data[i];
      if (node.id == nodeId) {
        arrRes.unshift(node);
        rev(data2, node.pid);
        break;
      } else {
        if (!!node.children) {
          rev(node.children, nodeId);
        }
      }
    }
    return arrRes;
  };
  arrRes = rev(data2, nodeId2);
  const result: any[] = [];
  arrRes.forEach((a: any) => {
    result.push(a.id);
  });
  return result;
}
