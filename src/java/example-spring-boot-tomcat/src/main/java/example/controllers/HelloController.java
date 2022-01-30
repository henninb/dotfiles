package example.controllers;

import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
//import org.springframework.validation.annotation.Validated;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.validation.ConstraintViolationException;
import javax.validation.constraints.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@Validated
public class HelloController {
    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public ResponseEntity<String> getStuff() {
        return ResponseEntity.ok("hello");
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = {ConstraintViolationException.class, NumberFormatException.class, MethodArgumentTypeMismatchException.class})
    public Map<String, String> badNews( Throwable throwable )  {
        Map<String, String> stuff = new HashMap<>();
        stuff.put("blah", throwable.getClass().getSimpleName());

        return stuff;
    }

    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(value = {Exception.class})
    public Map<String, String> badNews1( Throwable throwable )  {
        Map<String, String> stuff = new HashMap<>();
        stuff.put("blah", throwable.getClass().getSimpleName());

        return stuff;
    }
}
