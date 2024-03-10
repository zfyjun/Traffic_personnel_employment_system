package com.example.springboot.controller.dto;

import com.example.springboot.entity.Menu;
import lombok.Data;

import java.util.List;

/*
* 接受前端登录请求的参数
* */
@Data
public class UserDto {
    private String id;
    private String username;
    private String password;
    private String role;
    private String token;
    private List<Menu> menus;
}
