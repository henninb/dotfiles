package example_json.services;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.ObjectMapper;
import example_json.pojo.Site;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.net.URL;

@Service
public class JobSchedulerService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private static ObjectMapper objectMapper = new ObjectMapper();

    @Scheduled(fixedDelay = 1000 * 20)
    public void execute() {
        LOGGER.info("execute started");

        Site[] sites = new Site[]{};

        try {
            File file = getFileFromResources("confirmation-schedule.json");
            sites = objectMapper.readValue(file, Site[].class);
            for (Site site: sites) {
                LOGGER.info(site.toString());
            }
        }
        catch(JsonParseException jpe) {
            LOGGER.error("failed to parse:" + jpe.getMessage());
        }
        catch(IOException ioe) {
            LOGGER.error("IO error:" + ioe.getMessage());
        }

        LOGGER.info("execute ended");
    }

    private File getFileFromResources(String fileName) {

        ClassLoader classLoader = getClass().getClassLoader();

        URL resource = classLoader.getResource(fileName);
        if (resource == null) {
            throw new IllegalArgumentException("file is not found!");
        } else {
            return new File(resource.getFile());
        }
    }
}
