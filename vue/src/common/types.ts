export interface DataTableHeader {
  text: string;
  value: string;
  align?: 'start' | 'center' | 'end';
  sortable?: boolean | null;
  filterable?: boolean | null;
  divider?: boolean | null;
  class?: string | string[];
  width?: string | number;
  filter?: (value: any, search: string, item: any) => boolean;
  sort?: (a: any, b: any) => number;
  // 아래는 filter 를 위한 property 추가
  filterType?: 'input' | 'select' | 'switch';
  filterSelectItem?: SelectItem[] | null;
}

export interface Pagination {
  page: number | null;
  sortBy: string[] | null;
  sortDesc: boolean[] | null;
  itemsPerPage: number | null; // -1 for All
}

export interface DrawerItem {
  title: string;
  icon?: string | null;
  to?: string | null;
  type?: string | null;
  group?: string | null;
  checked?: boolean | null;
  children?: DrawerItem[];
}

export interface SelectItem {
  value: string;
  text: string;
}

export interface TableSampleMemberMstVO {
  id?: string | null;
  password?: string | null;
  name?: string | null;
  loginFailCnt?: number | null;
  expired?: Date | null;
  isClosed?: boolean | null;
  token?: string | null;
  created?: Date | null;
  createdBy?: string | null;
  updated?: Date | null;
  updatedBy?: string | null;
}

export interface TableSampleMenuMstVO {
  id?: number | null;
  name?: string | null;
  type?: string | null;
  parentId?: number | null;
  isUsing?: boolean | null;
  power?: number | null;
  displayOrder?: number | null;
  url?: string | null;
  remark1?: string | null;
  created?: Date | null;
  createdBy?: string | null;
  updated?: Date | null;
  updatedBy?: string | null;
}

export interface TableSampleCodeMstVO {
  groupCode?: string | null;
  name?: string | null;
  remark1?: string | null;
  created?: Date | null;
  createdBy?: string | null;
  updated?: Date | null;
  updatedBy?: string | null;
}

export interface TableSampleCodeDetVO {
  groupCode?: string | null;
  code?: string | null;
  name?: string | null;
  isUsing?: boolean | null;
  displayOrder?: number | null;
  remark1?: string | null;
  created?: Date | null;
  createdBy?: string | null;
  updated?: Date | null;
  updatedBy?: string | null;
}
