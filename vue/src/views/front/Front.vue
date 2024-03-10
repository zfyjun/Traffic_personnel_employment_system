<template>
  <div>
<!--    头部-->
    <div style="display: flex; height: 60px;padding-top: 10px; line-height: 60px; border-bottom: 1px solid #eee">
      <div style="width: 300px; display: flex;padding-left: 30px;">
        <div style="width: 60px">
          <img src="../../assets/logo.png" alt="" style="width: 50px; position: relative; top: 5px; right: 0">
        </div>
        <div style="flex: 1">欢迎来到xx系统</div>
      </div>
      <div style="flex: 1;">
        <el-menu :default-active="'1'" class="el-menu-demo" mode="horizontal" router>
          <el-menu-item index="/front/home">首页</el-menu-item>
          <el-menu-item index="/front/video">
            <el-badge :value="Mnumber">
              <span>视频播放</span>
            </el-badge>
          </el-menu-item>
<!--          <el-menu-item index="/front/article">文章列表</el-menu-item>-->
          <el-menu-item index="/front/exam">
            <el-badge :value="Enumber">
              <span>考试中心</span>
            </el-badge></el-menu-item>
        </el-menu>
      </div>
    </div>

    <div style="width: 1000px; margin: 0 auto;padding-top: 10px">
      <router-view />
    </div>
  </div>
</template>

<script>
export default {
  name: "Front",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      Mnumber:null,
      Enumber:null,
    }
  },
  created() {
    this.request.get("/userFile").then(res => {
      // console.log(res.data)
      this.Mnumber = res.data.filter(v => v.fileType === 'mp4' && v.state ==='未学习').length
      console.log(res.data)
      // console.log("频数量"+this.Mnumber)
    })

    this.request.get("/exam").then(res => {
      this.Enumber = res.data.filter(v => v.state === '未开始' || v.state=== '进行中' ).length
      console.log(this.Enumber)
    })
  },
  methods: {
    load(){

    },
    logout() {
      this.$store.commit("logout")
      this.$message.success("退出成功")
    }
  }
}
</script>

<style>
.item{
  display: inline-block;
  width: 100px;

  text-align: center;
  cursor: pointer
}
.item a {
  color: 	#1E90FF;
}
.item:hover{
  background-color: 	LightPink;
}
</style>
