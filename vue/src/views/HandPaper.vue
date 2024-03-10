<template>
  <div>
    <el-table :data="paper" border stripe :header-cell-class-name="'headerBg'">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="题目ID" width="80"></el-table-column>
      <el-table-column prop="name" label="题目名称"></el-table-column>
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
      <el-table-column prop="score" label="标准分数"></el-table-column>
      <el-table-column prop="answer" label="标准答案"></el-table-column>
      <el-table-column prop="studentAnswer" label="学生答案"></el-table-column>
      <el-table-column prop="detail" label="解析"></el-table-column>
      <el-table-column prop="studentScope" label="得分">
        <template v-slot="scope">
          <el-input v-model="scope.row.studentScore"></el-input>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 20px 0">
      <el-button type="primary" @click="submitScore">提 交</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "HandPaper",
  data(){
    return{
      sp: this.$route.query.sp,
      paper:[],
    }
  },
  created() {
    this.request.get("/studentPaper/"+this.sp).then(res=>{
      this.paper=JSON.parse(res.data.paper)
      if(this.paper&&this.paper.length){
        this.paper.forEach(item=>{
          if(item.answer===item.studentAnswer){
            item.stdentScore=item.score
          }
        })
      }
    })
  },
  methods:{
    submitScore(){
      let sum=0
      this.paper.forEach(item=>{
        if(item.studentScore==null){
          item.studentScore=0
        }
        sum+=parseInt(item.studentScore)
      })
      this.request.post("/studentPaper/",{id:this.sp,score:sum}).then(res=>{
        this.$message.success("打分成功")
        this.$router.push('/studentPaper')
      })
    },
  },
}
</script>

<style scoped>

</style>