package com.example.springboot.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.mapper.FileMapper;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;

import com.example.springboot.service.IUserFileService;
import com.example.springboot.entity.UserFile;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author baomidou
 * @since 2023-02-07
 */
@RestController
@RequestMapping("/userFile")
public class UserFileController {

    @Resource
    private IUserFileService userFileService;

    @Resource
    private FileMapper fileMapper;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody UserFile userFile) {
        userFileService.saveOrUpdate(userFile);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        userFileService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        userFileService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(userFileService.list());
    }

    @GetMapping("/file")
    public Result findFile() {
//        return Result.success(userFileService.list());
        return Result.success(fileMapper.selectList(null));
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(userFileService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<UserFile> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(userFileService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

