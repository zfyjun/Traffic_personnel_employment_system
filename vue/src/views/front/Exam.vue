<template>
<div>
  <div style="border: 1px solid #ccc;padding: 10px; border-radius:10px; margin: 10px 0" v-for="item in tableData" :key="item.id">
    <div style="color: #666; padding: 10px; margin: 10px 0; font-size: 20px">{{item.name}}</div>
    <div style="color: #666; padding: 10px; margin: 10px 0; font-size: 20px">
      <span style="margin-left: 20px">考试时间：{{item.time}}</span>
      <span style="margin-left: 20px">考试状态：{{item.state}}</span>
    </div>
    <div>
      <el-button style="margin-left: 20px" type="primary" @click="sign(item.id)" v-if="item.state==='未开始'">报名</el-button>
      <el-button style="margin-left: 20px" type="primary" @click="doPaper(item.id)" v-if="item.enable && item.state==='进行中'">开始考试</el-button>
    </div>
  </div>
</div>
</template>

<script>
export default {
  name: "Exam",
  created() {
    this.load()
  },
  data(){
    return{
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: "",
      user:localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{},
    }
  },
  methods:{
    doPaper(examId){
      this.$router.push('/front/paper?examId='+examId)
    },
    sign(examId){
      let form={userId:this.user.id,examId:examId}
      console.log(this.user.id)
      this.request.post("/sign", form).then(res => {
        if (res.code === '200') {
          this.$message.success("报名成功")
        } else {
          this.$message.error("报名失败")
        }
      })
    },
    load() {
      this.request.get("/exam/page/front"
          , {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      })
          .then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      // this.request.get("/exam/ids").then(r => {
      //   this.ids = r.data
      // })

      this.request.get("/course").then(res => {
        this.courses = res.data
      })
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
.bgImg {
  /*background: url("") no-repeat;*/
  background-size: 100% 100vh;
}
</style>
