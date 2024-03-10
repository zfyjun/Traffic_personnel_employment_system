package com.example.springboot.controller;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.controller.dto.HandPaperDto;
import com.example.springboot.controller.dto.PaperDto;
import com.example.springboot.entity.PaperQuestion;
import com.example.springboot.entity.Question;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.service.IPaperQuestionService;
import com.example.springboot.service.IQuestionService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;

import com.example.springboot.service.IPaperService;
import com.example.springboot.entity.Paper;

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
@RequestMapping("/paper")
public class PaperController {

    @Resource
    private IPaperService paperService;

    @Resource
    private IQuestionService questionService;

    @Resource
    private IPaperQuestionService paperQuestionService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Paper paper) {
        paperService.saveOrUpdate(paper);
        return Result.success();
    }

    @PostMapping("/handPaper")
    public Result takePaper(@RequestBody HandPaperDto paperDto) {
        //删除老的试卷
        UpdateWrapper<PaperQuestion> updateWrapper=new UpdateWrapper<>();
        updateWrapper.eq("paper_id",paperDto.getPaperId());
        paperQuestionService.remove(updateWrapper);

        List<Integer> handleQuestionIds = paperDto.getHandleQuestionIds();
        List<PaperQuestion> list=new ArrayList<>();
        for (Integer handleQuestionId: handleQuestionIds) {
            PaperQuestion paperQuestion = new PaperQuestion();
            paperQuestion.setPaperId(paperDto.getPaperId());
            paperQuestion.setQuestionId(handleQuestionId);
            list.add(paperQuestion);
        }
        paperQuestionService.saveBatch(list);
        return Result.success();
    }

    @PostMapping("/takePaper")
    public Result takePaper(@RequestBody PaperDto paperDto) {

        //删除老的试卷
        UpdateWrapper<PaperQuestion> updateWrapper=new UpdateWrapper<>();
        updateWrapper.eq("paper_id",paperDto.getPaperId());
        paperQuestionService.remove(updateWrapper);


        QueryWrapper<Question> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("course_id",paperDto.getCourseId());
        //根据课程id查出所有该课程的题目，再根据type区分
        List<Question> questionList = questionService.list(queryWrapper);
        List<Question> type1List = questionList.stream().filter(question -> question.getType()==1).collect(Collectors.toList());   //选择
        List<Question> type2List = questionList.stream().filter(question -> question.getType()==2).collect(Collectors.toList());   //判断
        List<Question> type3List = questionList.stream().filter(question -> question.getType()==3).collect(Collectors.toList());   //问答
        if(type1List.size()<paperDto.getType1()){
            throw new ServiceException("-1","选择题数量不足");
        }
        if(type2List.size()<paperDto.getType2()){
            throw new ServiceException("-1","判断题数量不足");
        }
        if(type3List.size()<paperDto.getType3()){
            throw new ServiceException("-1","问答题数量不足");
        }

        //开始随机组卷
        List<PaperQuestion> paperQuestion =getPaperQuestion(type1List.size(),paperDto.getType1(),type1List,paperDto.getPaperId());
        paperQuestion.addAll(getPaperQuestion(type2List.size(),paperDto.getType2(),type2List,paperDto.getPaperId()));
        paperQuestion.addAll(getPaperQuestion(type3List.size(),paperDto.getType3(),type3List,paperDto.getPaperId()));
        paperQuestionService.saveBatch(paperQuestion);


//        paperService.saveOrUpdate(paperDto);
        return Result.success();
    }

    //获取一个试卷和题目关联关系list方法
    private List<PaperQuestion> getPaperQuestion(int questionSize,int paperQuestionSize,List<Question> source,Integer paperId){
        List<Integer> typeRandomList = getEleList(questionSize, paperQuestionSize);
        List<PaperQuestion> list=new ArrayList<>();

//        for (Integer index=0; index< typeRandomList.size();index++){
        for (Integer index : typeRandomList) {
            Question question=source.get(index);
            PaperQuestion paperQuestion = new PaperQuestion();
            paperQuestion.setPaperId(paperId);
            paperQuestion.setQuestionId(question.getId());
            list.add(paperQuestion);
        }
        return list;
    }

    private List<Integer> getEleList(int sourceSize,int resultSize){
        List<Integer> list = CollUtil.newArrayList();
        for (int i=0;i<4;i++) {
            list.add(i);
        }
        return RandomUtil.randomEleList(list,resultSize);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        paperService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        paperService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(paperService.list());
    }

    @GetMapping("/view/{paperId}")
    public Result view(@PathVariable Integer paperId) {

        List<Question> list=paperQuestionService.selectQuestions(paperId);
        return Result.success(list);
    }


    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(paperService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<Paper> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(paperService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

