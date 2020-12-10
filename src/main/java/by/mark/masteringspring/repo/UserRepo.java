package by.mark.masteringspring.repo;

import by.mark.masteringspring.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Collection;

public interface UserRepo extends CrudRepository<User, Long> {

    User findByUsername(String username);
    Iterable<User> findByIdIn(Collection<Long> id);
    void deleteUsersByIdIn(Collection<Long> id);
}
