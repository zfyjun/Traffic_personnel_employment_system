package com.example.springboot.service;

import com.example.springboot.entity.ExamPaper;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author baomidou
 * @since 2023-01-30
 */
public interface IExamPaperService extends IService<ExamPaper> {

    void addPaper(ExamPaper examPaper);
}
