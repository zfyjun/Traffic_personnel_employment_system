package com.example.springboot.controller;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;

import com.example.springboot.service.IStudentPaperService;
import com.example.springboot.entity.StudentPaper;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author baomidou
 * @since 2023-02-02
 */
@RestController
@RequestMapping("/studentPaper")
public class StudentPaperController {

    @Resource
    private IStudentPaperService studentPaperService;

    private final String now= DateUtil.now();

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody StudentPaper studentPaper) {
        if(studentPaper.getId()==null){

            List<StudentPaper> list = studentPaperService.list(new QueryWrapper<StudentPaper>()
                    .eq("exam_id", studentPaper.getExamId())
                    .eq("user_id", TokenUtils.getCurrentUser().getId()));
            if (CollUtil.isNotEmpty(list)){
                throw new ServiceException("-1","您已提交考卷");
            }

            studentPaper.setTime(DateUtil.now());
            studentPaper.setUserId(TokenUtils.getCurrentUser().getId());
        }
        studentPaperService.saveOrUpdate(studentPaper);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        studentPaperService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        studentPaperService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(studentPaperService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(studentPaperService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<StudentPaper> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(studentPaperService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

