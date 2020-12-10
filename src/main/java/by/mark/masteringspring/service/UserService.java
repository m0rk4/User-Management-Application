package by.mark.masteringspring.service;

import by.mark.masteringspring.domain.User;
import by.mark.masteringspring.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserService implements UserDetailsService {

    private final UserRepo userRepo;

    @Autowired
    public UserService(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    public Iterable<User> findByIdIn(List<Long> chosenIds) {
        return userRepo.findByIdIn(chosenIds);
    }

    public Iterable<User> findAll() {
        return userRepo.findAll();
    }

    public boolean addUser(User user) {
        User userFromDb = userRepo.findByUsername(user.getUsername());
        if (userFromDb != null) {
            return false;
        }
        user.setEnabled(true);
        userRepo.save(user);
        return true;
    }

    public void changeStatus(Iterable<User> users, boolean enabled) {
        users.forEach(u -> u.setEnabled(enabled));
        userRepo.saveAll(users);
    }

    public void deleteUsersByIdIn(List<Long> chosenIds) {
        userRepo.deleteUsersByIdIn(chosenIds);
    }

    public void updateLastLoginDate(String username) {
        User user = userRepo.findByUsername(username);
        user.setLastLogin(new Date());
        userRepo.save(user);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user != null)
            return user;
        throw new UsernameNotFoundException("User not found!");
    }

}
