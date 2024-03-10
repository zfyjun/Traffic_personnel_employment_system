package com.example.springboot.service.impl;

import com.example.springboot.entity.UserFile;
import com.example.springboot.mapper.UserFileMapper;
import com.example.springboot.service.IUserFileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author baomidou
 * @since 2023-02-07
 */
@Service
public class UserFileServiceImpl extends ServiceImpl<UserFileMapper, UserFile> implements IUserFileService {

}
