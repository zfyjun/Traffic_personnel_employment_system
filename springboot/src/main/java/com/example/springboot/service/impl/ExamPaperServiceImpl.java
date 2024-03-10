package com.example.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.springboot.entity.ExamPaper;
import com.example.springboot.mapper.ExamPaperMapper;
import com.example.springboot.service.IExamPaperService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author baomidou
 * @since 2023-01-30
 */
@Service
public class ExamPaperServiceImpl extends ServiceImpl<ExamPaperMapper, ExamPaper> implements IExamPaperService {

    @Override
    public void addPaper(ExamPaper examPaper) {
        //先删除本考试的试卷
        remove(new UpdateWrapper<ExamPaper>().eq("exam_id",examPaper.getExamId()));
        save(examPaper);
    }
}
