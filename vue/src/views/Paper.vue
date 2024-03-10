<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="name"></el-input>
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
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="name" label="名称"></el-table-column>
      <el-table-column prop="scope" label="总分"></el-table-column>
<!--      <el-table-column prop="duration" label="时长"></el-table-column>-->
      <el-table-column label="课程名称">
        <template slot-scope="scope">
          <span v-if="courses&&courses.length">{{courses.find(v=>v.id===scope.row.courseId).name}}</span>
        </template>
      </el-table-column>

      <el-table-column label="试卷">
        <template slot-scope="scope">
          <el-button type="primary" @click="viewPaper(scope.row.id)">查看试卷</el-button>
        </template>
      </el-table-column>

      <el-table-column label="操作"  width="380" align="center">
        <template slot-scope="scope">
          <!--          <el-button type="info" @click="selectMenu(scope.row)">分配菜单 <i class="el-icon-menu"></i></el-button>-->
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-button type="success" @click="takePaper(scope.row.id,scope.row.courseId)">自动组卷 <i class="el-icon-document"></i></el-button>
          <el-button type="success" @click="handlePaper(scope.row.id,scope.row.courseId)">手动组卷 <i class="el-icon-document"></i></el-button>


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

    <el-dialog title="查看试卷" :visible.sync="dialogFormVisible2" width="60%" >
      <el-card>
        <div v-for="(item,index) in questions" :key="item.id" style="margin: 10px 0">
          <div style="margin: 10px 0; font-size: 20px">
            <span style="font-size: 14px" v-if="item.type===1">(选择题)</span>
            <span style="font-size: 14px" v-if="item.type===2">(判断题)</span>
            <span style="font-size: 14px" v-if="item.type===3">(问答题)</span>
            <span>{{index+1}}.</span>{{item.name}}
          </div>
          <div v-if="item.type===1" style="margin: 10px">
            <span style="margin-right: 20px">A.{{item.a}}</span>
            <span style="margin-right: 20px">B.{{item.b}}</span>
            <span style="margin-right: 20px">C.{{item.c}}</span>
            <span style="margin-right: 20px">D.{{item.d}}</span>
          </div>
          <div style="margin: 10px">
            答案：{{item.answer}}
          </div>
          <div style="margin: 10px">
            解析：{{item.detail}}
          </div>
        </div>
      </el-card>
    </el-dialog>

    <el-dialog title="手动组卷" :visible.sync="dialogFormVisible3" width="55%" >
      <div style="width: 90%; padding-left:120px">
<!--        <el-form-item label="题目类型">-->
<!--          <el-select clearable v-model="type" placeholder="请选择题目类型" @change="selectQuestion">-->
<!--            <el-option v-for="item in [{name:'选择题',value:1},{name:'判断题',value:2},{name:'问答题',value:3}]"-->
<!--                       :key="item.value" :label="item.name" :value="item.value"-->
<!--            >-->
<!--            </el-option>-->
<!--          </el-select>-->
<!--        </el-form-item>-->
        <el-transfer filter-placeholder="请选择类型：1选择，2判断，3问答" filterable :filter-method="filterMethod"
                     v-model="form2.handleQuestionIds" :data="paperQuestions" :props="{key:'id',label:'name'}"></el-transfer>


      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible3 = false">取 消</el-button>
        <el-button type="primary" @click="generateHandPaper">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="自动组卷" :visible.sync="dialogFormVisible1" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="选择题">
          <el-input v-model="form1.type1" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="判断题">
          <el-input v-model="form1.type2" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="问答题">
          <el-input v-model="form1.type3" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible1 = false">取 消</el-button>
        <el-button type="primary" @click="generatePaper">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="课程">
          <el-select clearable v-model="form.courseId" placeholder="请选择">
            <el-option v-for="item in courses"
                       :key="item.id" :label="item.name" :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="时长">
          <el-input v-model="form.duration" autocomplete="off"></el-input>
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
  name: "Paper",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: "",
      form: {},
      form1: {},
      form2: {},
      dialogFormVisible: false,
      dialogFormVisible1: false,
      dialogFormVisible2:false,
      dialogFormVisible3:false,
      menuDialogVis: false,
      multipleSelection: [],
      courses:[],
      questions:[],
      courseId: null,
      type:null,
      paperQuestions:[],
      paperQuestionsOrigin:[],

    }
  },
  created() {
    this.load()

    // this.request.get("/paper").then(res=>{
    //   this.courses=res.data
    // })
  },
  methods: {
    filterMethod(query,item){
      return !query || query==item.type;
    },
    // selectQuestion(){
    //   this.paperQuestions=this.paperQuestionsOrigin.filter(v=>v.type===this.type)
    // },
    handlePaper(paperId,courseId){
      this.request.get("/question").then(res=>{
        this.paperQuestions=res.data.filter(v=>v.courseId===courseId)
        this.paperQuestionsOrigin=JSON.parse(JSON.stringify(this.paperQuestions))
        this.type=null
      })


      this.form2={ handleQuestionIds:[],paperId:paperId}
      this.dialogFormVisible3=true
    },
    viewPaper(paperId){
      this.request.get("/paper/view/"+paperId).then(res=>{
        this.questions=res.data
        this.dialogFormVisible2=true
      })
    },
    takePaper(paperId,courseId){
      this.form1={type1:4,type2:4,type3:2,paperId:paperId,courseId:courseId}
      this.dialogFormVisible1=true
    },
    load() {
      this.request.get("/paper/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/course").then(res=>{
        this.courses=res.data
      })


    },
    generatePaper(){
      this.request.post("/paper/takePaper", this.form1).then(res =>{
        if (res.code === '200') {
          this.$message.success("自动组卷成功")
          this.dialogFormVisible1 = false
          // this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    generateHandPaper(){
      this.request.post("/paper/handPaper", this.form2).then(res =>{
        if (res.code === '200') {
          this.$message.success("手动组卷成功")
          this.dialogFormVisible3 = false
          // this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    save() {
      this.request.post("/paper", this.form).then(res => {
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
      this.request.delete("/paper/" + id).then(res => {
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
      this.request.post("/paper/del/batch", ids).then(res => {
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
