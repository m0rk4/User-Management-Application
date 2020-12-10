package by.mark.masteringspring.service;

import by.mark.masteringspring.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class SessionService implements LogoutHandler, ApplicationListener<AuthenticationSuccessEvent> {

    private final UserService userService;
    private final SessionRegistry sessionRegistry;

    @Autowired
    public SessionService(UserService userService) {
        this.userService = userService;
        this.sessionRegistry = new SessionRegistryImpl();
    }

    public void deleteSessions(Iterable<User> users) {
        users.forEach(u -> {
            for (Object obj : sessionRegistry.getAllPrincipals())
                if (((UserDetails) obj).getUsername().equals(u.getUsername()))
                    sessionRegistry.removeSessionInformation(u.getUsername());
        });
    }

    public boolean sessionContainsUserInRequest(HttpServletRequest request) {
        for (Object obj : sessionRegistry.getAllPrincipals())
            if (((UserDetails) obj).getUsername().equals(request.getUserPrincipal().getName()))
                return true;
        return false;
    }

    @Override
    public void logout(HttpServletRequest req, HttpServletResponse resp, Authentication auth) {
        sessionRegistry.removeSessionInformation(auth.getName());
    }

    @Override
    public void onApplicationEvent(AuthenticationSuccessEvent authSuccessEvent) {
        sessionRegistry.registerNewSession(authSuccessEvent.getAuthentication().getName(),
                authSuccessEvent.getAuthentication().getPrincipal());
        userService.updateLastLoginDate(
                ((UserDetails) (authSuccessEvent.getAuthentication().getPrincipal()))
                        .getUsername());
    }

}
