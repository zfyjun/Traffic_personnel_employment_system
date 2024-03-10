package com.example.springboot.controller;


import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Exam;
import com.example.springboot.entity.Sign;
import com.example.springboot.entity.User;
import com.example.springboot.service.IExamService;
import com.example.springboot.service.ISignService;
import com.example.springboot.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author baomidou
 * @since 2023-01-30
 */
@RestController
@RequestMapping("/exam")
public class ExamController {

    @Resource
    private IExamService examService;

    @Resource
    private ISignService signService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Exam exam) {
        examService.saveOrUpdate(exam);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        examService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        examService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(examService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(examService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Exam> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");

        Page<Exam> page=examService.page(new Page<>(pageNum,pageSize),queryWrapper);

        for (Exam exam : page.getRecords()) {
            setState(exam);
            examService.updateById(exam);

        }
        return Result.success(page);
    }

    @GetMapping("/page/front")
    public Result findPageFront(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<Exam> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        Page<Exam> page=examService.page(new Page<>(pageNum,pageSize),queryWrapper);

        User currentUser = TokenUtils.getCurrentUser();
        if(currentUser.getRole().equals("ROLE_USER")){
            queryWrapper.eq("user",currentUser.getUsername());
        }
        List<Sign> signList = signService.list(new QueryWrapper<Sign>().eq("user_id", currentUser.getId()));

        for (Exam exam : page.getRecords()) {
            Integer examId = exam.getId();
            exam.setEnable(false);
            signList.stream().filter(sign -> sign.getExamId().equals(examId)).findFirst().ifPresent(sign->{
                exam.setEnable("审核通过".equals(sign.getState()));
            });

            setState(exam);
            examService.updateById(exam);

        }
        return Result.success(page);
    }

    private void setState(Exam exam){
        String time=exam.getTime();
        DateTime dateTime = DateUtil.parse(time,"yyyy-MM-dd HH:mm");
        DateTime now=new DateTime();
        if(DateUtil.compare(dateTime,now)<=0 && DateUtil.compare(DateUtil.offsetMinute(dateTime,exam.getDuration()),now)>=0){
            exam.setState("进行中");
        } else if (DateUtil.compare(dateTime,now)>0) {
            exam.setState("未开始");
        }else {
            exam.setState("已结束");
        }
    }

}

