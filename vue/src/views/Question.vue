<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="name"></el-input>
<!--      <el-input style="width: 200px" placeholder="请输入邮箱" suffix-icon="el-icon-message" class="ml-5" v-model="email"></el-input>-->
<!--      <el-input style="width: 200px" placeholder="请输入地址" suffix-icon="el-icon-position" class="ml-5" v-model="address"></el-input>-->
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这些数据吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
<!--      <el-upload action="http://localhost:9090/user/import" :show-file-list="false" accept="xlsx" :on-success="handleExcelImportSuccess" style="display: inline-block">-->
<!--        <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>-->
<!--      </el-upload>-->
<!--      <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button>-->
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="name" label="题目"></el-table-column>
      <el-table-column label="课程名称">
        <template v-slot="scope">
          <span v-if="courses&&courses.length">{{courses.find(v=>v.id===scope.row.courseId).name}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="type" label="题目类型">
        <template v-slot="scope">
          <span v-if="scope.row.type===1">选择题</span>
          <span v-if="scope.row.type===2">判断题</span>
          <span v-if="scope.row.type===3">问答题</span>
        </template>
      </el-table-column>
      <el-table-column prop="a" label="选项A" ></el-table-column>
      <el-table-column prop="b" label="选项B" ></el-table-column>
      <el-table-column prop="c" label="选项C" ></el-table-column>
      <el-table-column prop="d" label="选项D" ></el-table-column>
      <el-table-column prop="score" label="分数"></el-table-column>
      <el-table-column prop="answer" label="答案"></el-table-column>
      <el-table-column prop="detail" label="解析"></el-table-column>
      <el-table-column prop="userId" label="作者id"></el-table-column>
      <el-table-column prop="time" label="创建时间"></el-table-column>
      <el-table-column label="操作"  width="280" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
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

    <el-dialog title="题目信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="题目类型">
          <el-select clearable v-model="form.type" placeholder="请选择">
            <el-option v-for="item in [{name:'选择题',value:1},{name:'判断题',value:2},{name:'问答题',value:3}]"
                       :key="item.value" :label="item.name" :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="课程">
          <el-select clearable v-model="form.courseId" placeholder="请选择">
            <el-option v-for="item in courses"
                       :key="item.id" :label="item.name" :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="题目">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="选项A" v-if="form.type===1">
          <el-input v-model="form.a" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="选项B" v-if="form.type===1">
          <el-input v-model="form.b" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="选项C" v-if="form.type===1">
          <el-input v-model="form.c" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="选项D" v-if="form.type===1">
          <el-input v-model="form.d" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="分数">
          <el-input v-model="form.score" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="答案" v-if="form.type===1">
          <el-radio v-model="form.answer" label="A">A</el-radio>
          <el-radio v-model="form.answer" label="B">B</el-radio>
          <el-radio v-model="form.answer" label="C">C</el-radio>
          <el-radio v-model="form.answer" label="D">D</el-radio>
        </el-form-item>
        <el-form-item label="答案" v-if="form.type===2">
          <el-radio v-model="form.answer" label="是">是</el-radio>
          <el-radio v-model="form.answer" label="否">否</el-radio>
        </el-form-item>
        <el-form-item label="答案" v-if="form.type===3">
          <el-input type="textarea" v-model="form.answer" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="解析">
          <el-input v-model="form.detail" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
export default {
  name: "Question",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: "",
      form: {},
      dialogFormVisible: false,
      menuDialogVis: false,
      multipleSelection: [],
      courses:[]
    }
  },
  created() {
    this.load()

    this.request.get("/course").then(res=>{
      this.courses=res.data
    })
  },
  methods: {
    load() {
      this.request.get("/question/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/question/ids").then(r => {
        this.ids = r.data
      })
    },

    save() {
      this.request.post("/question", this.form).then(res => {
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
      this.request.delete("/question/" + id).then(res => {
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
      this.request.post("/question/del/batch", ids).then(res => {
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
    //
    async selectMenu(role) {


      this.roleId = role.id
      this.roleFlag = role.flag

      // 请求菜单数据
      this.request.get("/menu").then(res => {
        this.menuData = res.data

        // 把后台返回的菜单数据处理成 id数组
        this.expends = this.menuData.map(v => v.id)
      })

      this.request.get("/role/roleMenu/" + this.roleId).then(res => {
        this.checks = res.data

        this.request.get("/menu/ids").then(r=>{
          const ids=r.data
          ids.forEach(id=>{
            if(!this.checks.includes(id)){
              this.$refs.tree.setChecked(id,false)
            }
          })
        })

        // this.ids.forEach(id => {
        //   if (!this.checks.includes(id)) {
        //     // 可能会报错：Uncaught (in promise) TypeError: Cannot read properties of undefined (reading 'setChecked')
        //     this.$nextTick(() => {
        //       this.$refs.tree.setChecked(id, false)
        //     })
        //   }
        // })

        this.menuDialogVis = true
      })


    },
    saveRoleMenu() {
      this.request.post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys()).then(res => {
        if (res.code === '200') {
          this.$message.success("绑定成功")
          this.menuDialogVis = false

          // 操作管理员角色后需要重新登录
          if (this.roleFlag === 'ROLE_ROOT') {
            // this.$store.commit("logout")
            this.$router.push("/login")
          }

        } else {
          this.$message.error(res.msg)
        }
      })
    },


  }
}
</script>


<style>
.headerBg {
  background: #eee!important;
}
</style>
