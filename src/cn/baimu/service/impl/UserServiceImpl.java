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
    public void add(User user) throws Exception {
        userMapper.add(user);
    }

    @Override
    public void delete(User user) throws Exception {
        userMapper.delete(user);
    }

    @Override
    public List<User> findAll() throws Exception {
        return userMapper.findAll();
    }

    @Override
    public User findByUsername(String username) throws Exception {
        return userMapper.findByUsername(username);
    }

    @Override
    public User login(String username, String password) {
        try {
            User existingUser = findByUsername(username);
            if (existingUser != null && existingUser.getPassword().equals(password)) {
                return existingUser;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
