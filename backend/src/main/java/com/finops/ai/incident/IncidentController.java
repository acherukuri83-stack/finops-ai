package com.finops.ai.incident;
import java.util.*; import org.springframework.jdbc.core.JdbcTemplate; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/incidents")
public class IncidentController { private final JdbcTemplate jdbc; public IncidentController(JdbcTemplate jdbc){this.jdbc=jdbc;}
@GetMapping public List<Map<String,Object>> all(){return jdbc.queryForList("select * from incident order by incident_id");} }
