package com.example.springboot.controller.dto;

import lombok.Data;

import java.util.List;

@Data
public class HandPaperDto {
    private List<Integer> handleQuestionIds; //
    private Integer paperId; //试卷id
}
