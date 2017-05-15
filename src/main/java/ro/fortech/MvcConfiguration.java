package ro.fortech;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by Tamas on 5/11/2017.
 */
@Configuration
public class MvcConfiguration extends WebMvcConfigurerAdapter {

    @Value("${local.files.dir}")
    private String localFilesDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/ext-img/**")
                .addResourceLocations("file:" + localFilesDir)
                .setCachePeriod(0);
    }

}
