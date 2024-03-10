<template>
  <div>

    <div style="margin: 20px 0;font-size: 20px">考试列表</div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column label="机构名称">
        <template slot-scope="scope">
          <span v-if="exams&&exams.length">{{exams.find(v=>v.id===scope.row.examId)?exams.find(v=>v.id===scope.row.examId).name:''}}</span>
        </template>
      </el-table-column>
      <el-table-column label="学生">
        <template slot-scope="scope">
          <span v-if="users&&users.length">{{users.find(v=>v.id===scope.row.userId)?users.find(v=>v.id===scope.row.userId).username:''}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="state" label="审核状态"></el-table-column>
      <el-table-column label="审核">
        <template v-slot="scope">
          <el-button type="success" @click="changeState(scope.row,'审核通过')">审核通过</el-button>
          <el-button type="danger" @click="changeState(scope.row,'审核不通过')">审核不通过</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作"  width="280" align="center">
        <template slot-scope="scope">
<!--          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>-->
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定删除吗？"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

  </div>
</template>

<script>
export default {
  name: "Sign",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: "",
      form: {},
      multipleSelection: [],
      user:localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{},
      exams:[],
      users:[],
    }
  },
  created() {
    this.load()
  },
  methods: {
    changeState(row,state){
      this.form=JSON.parse(JSON.stringify(row))
      this.form.state=state
      this.save()
    },
    load() {
      this.request.get("/sign/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/sign/ids").then(r => {
        this.ids = r.data
      })

      this.request.get("/exam").then(r => {
        this.exams = r.data
      })

      this.request.get("/user").then(r => {
        this.users = r.data
      })

    },
    save() {
      this.request.post("/sign", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
    },
    del(id) {
      this.request.delete("/sign/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/sign/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },
    reset() {
      this.name = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },


  }
}
</script>


<style>
.headerBg {
  background: #eee!important;
}
</style>
