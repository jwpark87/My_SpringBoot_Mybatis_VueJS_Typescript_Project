<template>
  <div>
    <v-card>
      <v-alert
        border="bottom"
        colored-border
        color="success"
        icon="mdi-format-list-checkbox"
        dense
        class="mb-0"
      >
        코드 관리 - Detail
      </v-alert>
      <v-card-text class="py-1">
        <v-data-table
          must-sort
          fixed-header
          v-model="selected"
          :loading="loading"
          :headers="headers"
          :items="filteredItems"
          :sort-by="sortBy"
          :sort-desc="sortDesc"
          item-key="code"
          single-select
          show-select
          dense
          :height="327"
          :footer-props="envs.FOOTER_PROPS_100"
        >
          <template v-slot:top>
            <button-set
              :disabled="!parentItem.codeGroup"
              add-button
              delete-button
              reload-button
              :delete-disabled="!selected || selected.length === 0"
              @click:add="
                () => {
                  mode = '추가';
                  editItem = { codeGroup: parentItem.codeGroup };
                  dialog = true;
                }
              "
              @click:delete="
                () => {
                  editItem = selected[0];
                  $refs.refEditDialog.delete();
                }
              "
              @click:reload="getList"
            />
          </template>
          <template v-slot:header>
            <data-table-filter
              :filter-header="headers"
              :filtered-items.sync="filteredItems"
              :original-items="items"
            />
          </template>
          <template v-slot:item.code="{ item }">
            <a
              :style="{ 'font-weight': 'bold' }"
              @click="
                () => {
                  mode = '수정';
                  editItem = Object.assign({}, item);
                  dialog = true;
                }
              "
            >
              {{ item.code }}
            </a>
          </template>
          <template v-slot:item.available="{ item }">
            <span style="display: inline-flex;">
              <v-checkbox
                readonly
                :input-value="item.available"
                :ripple="false"
                dense
                hide-details
                class="mt-0"
              />
            </span>
          </template>
          <template v-slot:item.authority="{ item }" v-if="AUTHORITY">
            {{ item.authority | getCodeText(AUTHORITY) }}
          </template>
          <template v-slot:item.updatedBy="{ item }">
            {{ item.updatedBy | formatEmpNm }}
          </template>
          <template v-slot:item.updated="{ item }">
            {{ item.updated | formatDatetime }}
          </template>
        </v-data-table>
        <code-edit-dialog
          ref="refEditDialog"
          :edit-item="editItem"
          :dialog.sync="dialog"
          :mode="mode"
          @finished="getList"
        />
      </v-card-text>
    </v-card>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from 'vue-property-decorator';
import {
  DataTableHeader,
  SelectItem,
  TableCodeGroupVO,
  TableCodeVO,
} from '@/common/types';
import { getCodeListApi, getListApi } from '@/utils/apis';
import envs from '@/constants/envs';
import ButtonSet from '@/components/speeddial/ButtonSet.vue';
import CodeEditDialog from '@/views/admin/code/components/CodeEditDialog.vue';
import DataTableFilter from '@/components/datatable/DataTableFilter.vue';

@Component({
  name: 'CodeList',
  components: {
    DataTableFilter,
    CodeEditDialog,
    ButtonSet,
  },
})
export default class extends Vue {
  @Prop({ required: true }) readonly parentItem!: TableCodeGroupVO;

  readonly envs: typeof envs = envs;

  AUTHORITY: SelectItem[] | null = null;
  mode: string | null = null;

  loading: boolean = false;
  sortBy: string[] = ['displayOrder'];
  sortDesc: boolean[] = [false];
  items: TableCodeVO[] = [];
  filteredItems: TableCodeVO[] = [];
  editItem: TableCodeVO = {};
  selected: TableCodeVO[] = [];
  dialog: boolean = false;
  headers: DataTableHeader[] = [
    {
      text: `상세 코드`,
      align: `start`,
      value: `code`,
    },
    {
      text: `상세 코드명`,
      align: `start`,
      value: `name`,
    },
    {
      text: `사용 가능`,
      align: `center`,
      value: `available`,
      filterType: 'switch',
      width: 100,
    },
    {
      text: `출력 순서`,
      align: `end`,
      value: `displayOrder`,
      width: 100,
    },
    {
      text: `권한(~부터 볼수 있음)`,
      align: `start`,
      value: `authority`,
      filterType: 'select',
      filterSelectItem: [],
    },
    {
      text: `작업 일시`,
      align: `center`,
      value: `updated`,
      filterable: false,
      width: 160,
    },
    {
      text: `작업자`,
      align: `start`,
      value: `updatedBy`,
      filterable: false,
      width: 100,
    },
  ];

  async mounted() {
    this.headers[4].filterSelectItem = this.AUTHORITY = await getCodeListApi(
      'AUTHORITY',
    );
  }

  @Watch('parentItem')
  watchParentItem(val: TableCodeGroupVO): void {
    this.items = [];
    if (val && val.codeGroup) {
      this.getList();
    }
  }

  async getList() {
    this.selected = [];
    this.items = [];
    this.loading = true;
    const response = await getListApi<TableCodeVO[]>(
      `admin/codes/${this.parentItem.codeGroup}`,
    );
    this.loading = false;
    this.items = response.data || [];
  }
}
</script>