<template>
  <div style="padding: 10px">
    <div v-for="item in videos" :key="item.id" style="margin: 10px 0; padding: 10px 0; color: #666; border-bottom: 1px dashed #ccc">
      <el-card>
        <span style="font-size: 18px; cursor: pointer" class="item" @click="detail(item.id)">{{ item.name }}</span>
        <span style="float: right; font-size: 12px; margin-top: 10px">文件大小：{{ item.size }} kb</span>
        <div v-for="item1 in filestate">
          <div style="padding-left: 900px" v-if="item1.fileId===item.id&&item1.state==='已学习'">
            <i class="el-icon-success"  style="padding-left: 15px ;font-size: larger;color: #42b983" ></i>
          </div>
          <div style="padding-left: 900px" v-if="item1.fileId===item.id&&item1.state==='未学习'">
            <i class="el-icon-error"  style="padding-left: 15px ;font-size: larger; color: crimson" ></i>
          </div>
        </div>



      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: "Video",
  data() {
    return {
      videos: [],
      filestate:[],

    }
  },
  created() {
    this.request("/echarts/file/front/all").then(res => {
      // console.log(res.data)
      this.videos = res.data.filter(v => v.type === 'mp4')
      console.log(this.videos)
    })

    this.request.get("/userFile").then(res => {
      // console.log(res.data)
      this.filestate = res.data.filter(v => v.fileType === 'mp4')
      console.log(this.filestate)
    })

    // if(this.filestate.fileId===this.videos.id){
    //   if(this.filestate.state==='未学习'){
    //     this.filestate.icon="el-icon-success"
    //   }else{
    //     this.filestate.icon='el-icon-error'
    //   }
    // }
  },
  methods: {
    detail(id) {
      this.$router.push({path: "/front/videoDetail", query: {id: id}})
    }
  }
}
</script>

<style>
.item:hover{
  color: #3a8ee6;
  background: none;
}
</style>
