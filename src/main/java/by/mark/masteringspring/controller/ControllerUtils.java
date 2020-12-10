package by.mark.masteringspring.controller;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ControllerUtils {

    static List<Long> getCheckedIdsFromForm(Map<String, String> form) {
        return form.entrySet().stream()
                .filter(e -> e.getValue().equals("on") && !
                        e.getKey().equals("checkAll"))
                .map(e -> Long.parseLong(e.getKey()))
                .collect(Collectors.toList());
    }

    static Map<String, String> getErrors(BindingResult bindingResult) {
        return bindingResult.getFieldErrors().stream()
                .collect(Collectors.toMap(
                        fieldError -> fieldError.getField() + "Error",
                        FieldError::getDefaultMessage)
                );
    }
}
