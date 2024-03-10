package com.example.springboot.controller;


import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.utils.TokenUtils;
import io.swagger.models.auth.In;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;

import com.example.springboot.service.IExamPaperService;
import com.example.springboot.entity.ExamPaper;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author baomidou
 * @since 2023-01-30
 */
@RestController
@RequestMapping("/examPaper")
public class ExamPaperController {

    @Resource
    private IExamPaperService examPaperService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody ExamPaper examPaper) {
        examPaperService.addPaper(examPaper);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        examPaperService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        examPaperService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping("/exam/{examId}")
    public Result findByExam(@PathVariable Integer examId) {
        return Result.success(examPaperService.getOne(new QueryWrapper<ExamPaper>().eq("exam_id",examId)));
    }

    @GetMapping
    public Result findAll() {
        return Result.success(examPaperService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(examPaperService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<ExamPaper> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(examPaperService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

