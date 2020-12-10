package by.mark.masteringspring.controller;

import by.mark.masteringspring.domain.User;
import by.mark.masteringspring.service.SessionService;
import by.mark.masteringspring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/main")
public class UserListController {

    private final UserService userService;
    private final SessionService sessionService;

    @Autowired
    public UserListController(UserService userService, SessionService sessionService) {
        this.userService = userService;
        this.sessionService = sessionService;
    }

    @GetMapping
    public String userList(Model model) {
        Iterable<User> allUsers = userService.findAll();
        model.addAttribute("users", allUsers);
        return "userList";
    }

    @Transactional
    @PostMapping
    public String performOperation(
            HttpServletRequest request,
            @AuthenticationPrincipal User currentUser,
            @RequestParam Map<String, String> form
    ) {

        if (!sessionService.sessionContainsUserInRequest(request)) {
            request.getSession().invalidate();
            return "redirect:/login";
        }

        List<Long> chosenIds = ControllerUtils.getCheckedIdsFromForm(form);
        Iterable<User> chosenUsers = userService.findByIdIn(chosenIds);

        if (form.containsKey("block")) {
            userService.changeStatus(chosenUsers, false);
            sessionService.deleteSessions(chosenUsers);
            if (chosenIds.contains(currentUser.getId())) {
                request.getSession().invalidate();
                return "redirect:/login";
            }
        } else if (form.containsKey("unblock")) {
            userService.changeStatus(chosenUsers, true);
        } else if (form.containsKey("delete")) {
            userService.deleteUsersByIdIn(chosenIds);
            sessionService.deleteSessions(chosenUsers);
            if (chosenIds.contains(currentUser.getId())) {
                request.getSession().invalidate();
                return "redirect:/login";
            }
        }
        return "redirect:/main";
    }


}
