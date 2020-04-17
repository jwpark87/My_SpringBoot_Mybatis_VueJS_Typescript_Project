<template>
  <div>
    <v-card-text class="py-1">
      <v-data-table
        must-sort
        fixed-header
        :loading="loading"
        :headers="headers"
        :items="items"
        item-key="id"
        disable-sort
        disable-filtering
        disable-pagination
        dense
        :height="729"
      >
        <template v-slot:top>
          <button-set
            reload-button
            :reload-disabled="!authority"
            @click:reload="getList"
            save-button
            :save-disabled="!authority"
            @click:save="save"
          />
        </template>
        <template v-slot:item.type="{ item }" v-if="MENU_TYPE">
          {{ item.type | getCodeText(MENU_TYPE) }}
        </template>
        <template v-slot:item.name="{ item }">
          <span
            :style="`padding-left: ${
              80 * (item.level - 1)
            }px; display: inline-flex;`"
          >
            <v-checkbox
              v-model="item.checked"
              :label="item.name"
              :prepend-icon="item.icon"
              :readonly="item.id === 1"
              :disabled="
                item.id !== 1 &&
                item.parentId &&
                !items.find((value) => value.id === item.parentId).checked
              "
              :ripple="item.id !== 1"
              dense
              hide-details
              class="mt-0 pa-0"
              @click.passive="setChildrenChecked(item)"
            />
          </span>
        </template>
      </v-data-table>
    </v-card-text>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from 'vue-property-decorator';
import { DataTableHeader, SelectItem, TableMenuVO } from '@/common/types';
import { getCodeListApi, getListApi, putDataApi } from '@/utils/apis';
import envs from '@/constants/envs';
import ButtonSet from '@/components/speeddial/ButtonSet.vue';

interface AdminMenuAuthorityVO extends TableMenuVO {
  checked: boolean;
}

@Component({
  name: 'MenuAuthorityList',
  components: {
    ButtonSet,
  },
})
export default class extends Vue {
  @Prop({ required: true }) readonly authority!: string;

  readonly envs: typeof envs = envs;
  mode: string | null = null;
  items: AdminMenuAuthorityVO[] = [];
  loading: boolean = false;
  dialog: boolean = false;
  MENU_TYPE: SelectItem[] | null = null;

  headers: DataTableHeader[] = [
    {
      text: `타입`,
      align: `center`,
      value: `type`,
      filterType: 'select',
      filterSelectItem: [],
      width: 100,
    },
    {
      text: `메뉴 ID`,
      align: `start`,
      value: `id`,
      width: 100,
    },
    {
      text: `상위 메뉴 ID`,
      align: `start`,
      value: `parentId`,
      width: 100,
    },
    {
      text: `메뉴명`,
      align: `start`,
      value: `name`,
    },
  ];

  async mounted() {
    this.headers[0].filterSelectItem = this.MENU_TYPE = await getCodeListApi(
      `MENU_TYPE`,
    );
  }

  @Watch('authority', { immediate: true })
  watchAuthority(val: string) {
    if (val) {
      this.getList();
    }
  }

  setChildrenChecked(item: AdminMenuAuthorityVO) {
    if (!item.checked) {
      this.items
        .filter((value) => value.parentId === item.id)
        .forEach((value) => {
          value.checked = false;
        });
    }
  }

  async getList() {
    this.items = [];
    this.loading = true;
    const response = await getListApi<AdminMenuAuthorityVO[]>(
      `admin/menuAuthority/${this.authority}`,
    );
    this.loading = false;
    this.items = response.data || [];
  }

  async save() {
    this.loading = true;
    await putDataApi<object>(
      `admin/menuAuthority/`,
      {
        menuIdList: this.items
          .map((value) => (value.checked ? value.id : undefined))
          .filter((value) => value !== undefined)
          .join(','),
      },
      this.authority,
    );
    this.loading = false;
  }
}
</script>