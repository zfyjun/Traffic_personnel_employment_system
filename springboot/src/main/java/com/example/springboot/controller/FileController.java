package com.example.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.net.URLEncoder;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Files;
import com.example.springboot.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

/*
* 文件上传相关接口
* */
@RestController
@RequestMapping("/file")
public class FileController {

    @Value("${files.upload.path}")
    private String fileUploadPath;

    @Resource
    private FileMapper fileMapper;

    /*
    * 文件上传接口
    * 前端传过来的文件
    * */
    @PostMapping("/upload")
    public String upload(@RequestParam MultipartFile file) throws IOException {
        String originalFilename =file.getOriginalFilename();
        String type= FileUtil.extName(originalFilename);
        long size =file.getSize();
        //先存到磁盘
        File uploadParentFile = new File(fileUploadPath);
        //判断配置的文件目录是否存在
        if(!uploadParentFile.exists()){
            uploadParentFile.mkdir();
        }
        String uuid =IdUtil.fastSimpleUUID();
        String fileUuid=uuid+ StrUtil.DOT+type;
        String md5,url;

        File uploadFile=new File(fileUploadPath+fileUuid);

        if(uploadFile.exists()){
            //获取文件的md5
            md5= SecureUtil.md5(uploadFile);

            //从数据库查询是否存在相同的记录
            Files dbFiles=getFileByMd5(md5);

            if(dbFiles!=null){
                url=dbFiles.getUrl();
            }else {
                //获取的文件存储到磁盘文件
                file.transferTo(uploadFile);
                url="http://localhost:9090/file/"+fileUuid;
            }

        }else{
            //获取的文件存储到磁盘文件
            file.transferTo(uploadFile);
            md5=SecureUtil.md5(uploadFile);
            url="http://localhost:9090/file/"+fileUuid;
        }

        //存储数据库
        Files saveFile=new Files();
        saveFile.setName(originalFilename);
        saveFile.setType(type);
        saveFile.setSize(size/1024);
        saveFile.setUrl(url);
        saveFile.setMd5(md5);
        fileMapper.insert(saveFile);
        return url;
    }

    @GetMapping("/{fileUuid}")
    public void download(@PathVariable String fileUuid, HttpServletResponse response) throws IOException {
        File uploadFile =new File(fileUploadPath + fileUuid);
        ServletOutputStream os = response.getOutputStream();
        URLEncoder urlEncoder=new URLEncoder();
        response.addHeader("Content-Disposition","attachment;filename=" + urlEncoder.encode(fileUuid, StandardCharsets.UTF_8));
        response.setContentType("application/octet-stream");
        os.write(FileUtil.readBytes(uploadFile));
        os.flush();
        os.close();

    }

    private Files getFileByMd5(String md5){
        QueryWrapper<Files> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("md5",md5);
        List<Files> filesList=fileMapper.selectList(queryWrapper);
        return filesList.size()==0?null:filesList.get(0);
    }

    //新增或更新
    @PostMapping("/update")
    public Result update(@RequestBody Files files){
        return Result.success(fileMapper.updateById(files));
    }

    @GetMapping("/detail/{id}")
    public Result getById(@PathVariable Integer id) {
        return Result.success(fileMapper.selectById(id));
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        Files files=fileMapper.selectById(id);
        files.setIsDelete(true);
        return Result.success(fileMapper.updateById(files));
    }

    /*
    * 分页查询接口
    * */
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String name) {
        QueryWrapper<Files> queryWrapper=new QueryWrapper<>();
        //查询未删除记录
        queryWrapper.eq("is_Delete",false);
        queryWrapper.like("name",name);
        return Result.success(fileMapper.selectPage(new Page<>(pageNum, pageSize),queryWrapper));
    }

}
