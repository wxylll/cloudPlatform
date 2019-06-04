package cn.baimu.service.impl;

import cn.baimu.mapper.EdgeTerminalMapper;
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
    @Autowired
    private EdgeTerminalMapper edgeTerminalMapper;

    @Override
    public void add(User user) throws Exception {
        userMapper.add(user);
    }

    @Override
    public void delete(User user) throws Exception {
        edgeTerminalMapper.unBound(user.getUid()); //解除用户与管辖范围内边缘端的绑定关系
        userMapper.delete(user); //删除用户
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
            User existingUser = findByUsername(username); //校验用户名
            if (existingUser != null && existingUser.getPassword().equals(password)) { //校验密码
                return existingUser; //校验成功返回用户信息
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User findCrownUser(String position) throws Exception {
        List<User> users = null;
        position = " " + position;
        position = position.substring(0, position.lastIndexOf(" "));
        while (position.trim().length() != 0) {
            users = userMapper.findUserByPosition(position.trim());
            if (users == null || users.size() == 0) { //未找到用户则扩大权限范围继续查找
                position = position.substring(0, position.lastIndexOf(" "));
                users = userMapper.findUserByPosition(position);
            } else if (users.size() > 1){ //符合条件的用户数大于一，则返回权限最小的一个
                return getClosestUser(users);
            } else { //只有一个符合条件的用户则直接返回
                return users.get(0);
            }
        }
        return null;
    }

    /**
     * 获取管辖范围最接近的用户
     * @param users
     * @return
     */
    private User getClosestUser(List<User> users) {
        int max = 0;
        User closestUser = null;
        for (User user : users) {
            int rightScore = user.getJurisdiction().split(" ").length; //获取权限得分（越高权限越低）
            if (rightScore > max) {
                max = rightScore;
                closestUser = user;
            }
        }
        return closestUser; //返回权限最低（范围最近）的用户
    }
}
