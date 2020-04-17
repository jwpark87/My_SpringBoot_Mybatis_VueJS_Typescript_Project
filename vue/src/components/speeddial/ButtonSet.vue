<template>
  <div>
    <v-speed-dial
      id="buttonSet"
      v-model="fab"
      absolute
      top
      right
      direction="left"
      open-on-hover
      transition="scale-transition"
    >
      <template v-slot:activator>
        <v-btn v-model="fab" color="button-default" dark fab small>
          <v-icon color="black" v-if="fab">mdi-close</v-icon>
          <v-icon v-else>mdi-function</v-icon>
        </v-btn>
      </template>
      <v-tooltip top v-if="reloadButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="button-reload"
            @click="clickReload"
            :disabled="disabled || reloadDisabled"
            v-on="on"
          >
            <v-icon>mdi-reload</v-icon>
          </v-btn>
        </template>
        <span> {{ reloadText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="saveButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="primary"
            @click="clickSave"
            :disabled="disabled || saveDisabled"
            v-on="on"
          >
            <v-icon>mdi-content-save</v-icon>
          </v-btn>
        </template>
        <span> {{ saveText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="killButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="indigo"
            @click="clickKill"
            :disabled="disabled || killDisabled"
            v-on="on"
          >
            <v-icon>mdi-content-cut</v-icon>
          </v-btn>
        </template>
        <span> {{ killText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="conditionButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="warning"
            @click="clickCondition"
            :disabled="disabled || conditionDisabled"
            v-on="on"
          >
            <v-icon>mdi-filter-plus-outline</v-icon>
          </v-btn>
        </template>
        <span> {{ conditionText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="graphButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="secondary"
            @click="clickGraph"
            :disabled="disabled || graphDisabled"
            v-on="on"
          >
            <v-icon>mdi-chart-bar</v-icon>
          </v-btn>
        </template>
        <span> {{ graphText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="excelButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="button-add"
            @click="clickExcel"
            :disabled="disabled || excelDisabled"
            v-on="on"
          >
            <v-icon>mdi-file-excel-outline</v-icon>
          </v-btn>
        </template>
        <span> {{ excelText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="deleteButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="button-delete"
            @click="clickDelete"
            :disabled="disabled || deleteDisabled"
            v-on="on"
          >
            <v-icon>mdi-delete</v-icon>
          </v-btn>
        </template>
        <span> {{ deleteText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="addButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="button-add"
            @click="clickAdd"
            :disabled="disabled || addDisabled"
            v-on="on"
          >
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </template>
        <span> {{ addText }} </span>
      </v-tooltip>
      <v-tooltip top v-if="inquiryButton">
        <template v-slot:activator="{ on }">
          <v-btn
            fab
            dark
            x-small
            color="button-default"
            @click="clickInquiry"
            :disabled="disabled || inquiryDisabled"
            v-on="on"
          >
            <v-icon>mdi-magnify</v-icon>
          </v-btn>
        </template>
        <span> {{ inquiryText }} </span>
      </v-tooltip>
    </v-speed-dial>
  </div>
</template>

<script lang="ts">
import { Component, Emit, Prop, Vue } from 'vue-property-decorator';

@Component({ name: 'ButtonSet' })
export default class extends Vue {
  @Prop({ type: Boolean, default: false }) readonly disabled!: boolean;
  @Prop({ type: Boolean, default: false }) readonly addButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly addDisabled!: boolean;
  @Prop({ type: String, default: '추가' }) readonly addText!: string;
  @Prop({ type: Boolean, default: false }) readonly conditionButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly conditionDisabled!: boolean;
  @Prop({ type: String, default: '조건 추가' }) readonly conditionText!: string;
  @Prop({ type: Boolean, default: false }) readonly deleteButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly deleteDisabled!: boolean;
  @Prop({ type: String, default: '삭제' }) readonly deleteText!: string;
  @Prop({ type: Boolean, default: false }) readonly excelButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly excelDisabled!: boolean;
  @Prop({ type: String, default: 'Excel' }) readonly excelText!: string;
  @Prop({ type: Boolean, default: false }) readonly graphButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly graphDisabled!: boolean;
  @Prop({ type: String, default: 'graph 보기' }) readonly graphText!: string;
  @Prop({ type: Boolean, default: false }) readonly inquiryButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly inquiryDisabled!: boolean;
  @Prop({ type: String, default: '조회' }) readonly inquiryText!: string;
  @Prop({ type: Boolean, default: false }) readonly killButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly killDisabled!: boolean;
  @Prop({ type: String, default: '세션 삭제요청' }) readonly killText!: string;
  @Prop({ type: Boolean, default: false }) readonly reloadButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly reloadDisabled!: boolean;
  @Prop({ type: String, default: '새로고침' }) readonly reloadText!: string;
  @Prop({ type: Boolean, default: false }) readonly saveButton!: boolean;
  @Prop({ type: Boolean, default: false }) readonly saveDisabled!: boolean;
  @Prop({ type: String, default: '저장' }) readonly saveText!: string;

  fab: boolean = false;

  @Emit('click:add') clickAdd() {}
  @Emit('click:condition') clickCondition() {}
  @Emit('click:delete') clickDelete() {}
  @Emit('click:excel') clickExcel() {}
  @Emit('click:graph') clickGraph() {}
  @Emit('click:inquiry') clickInquiry() {}
  @Emit('click:kill') clickKill() {}
  @Emit('click:reload') clickReload() {}
  @Emit('click:save') clickSave() {}
}
</script>