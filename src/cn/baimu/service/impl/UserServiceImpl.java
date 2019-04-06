package cn.baimu.service.impl;

import cn.baimu.mapper.UserMapper;
import cn.baimu.po.User;
import cn.baimu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * UserService实现类
 * @auther wxy
 */
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public void add(User user) {
        userMapper.add(user);
    }

    @Override
    public void delete(User user) {
        userMapper.delete(user);
    }

    @Override
    public List<User> findAll() {
        return userMapper.findAll();
    }

    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public User login(String username, String password) {
        User existingUser = findByUsername(username);
        if (existingUser != null && existingUser.getPassword().equals(password)) {
            return existingUser;
        }
        return null;
    }
}
