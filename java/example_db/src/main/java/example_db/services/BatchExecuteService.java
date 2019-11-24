package example_db.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.Locale;
import com.github.javafaker.service.FakeValuesService;
import com.github.javafaker.service.RandomService;

import example_db.entities.Person;

@Service
public class BatchExecuteService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private PersonService personService;

    private FakeValuesService fakeValuesService = new FakeValuesService(new Locale("en-US"), new RandomService());

    @Autowired
    BatchExecuteService(PersonService personService) {
        this.personService = personService;
    }

    //every 4 seconds
    @Scheduled(fixedDelay = 4000)
    public void execute() {
        System.out.println("test");
        Person person = new Person();
        person.setFirstName(fakeValuesService.regexify("[a-z]{8}"));
        person.setPersonId( Integer.parseInt(fakeValuesService.regexify("[0-9]{5}")) );
        personService.addPerson(person);
        System.out.println("test complete");
//        System.exit(2);
        //List<Map<String, Object>> list = jdbcTemplate.queryForList(tlogQuery);

//        list.forEach(row -> {
//            LOGGER.info(String.valueOf(row));
//        });
//        if (list.size() > 0) {
//            postToSlackService.postOnSlack(TokenService.token, new StringBuilder(list.toString()));
//        }
    }

}
