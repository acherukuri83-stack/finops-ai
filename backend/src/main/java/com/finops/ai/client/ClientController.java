package com.finops.ai.client;
import java.util.*; import org.springframework.jdbc.core.JdbcTemplate; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/clients")
public class ClientController { private final JdbcTemplate jdbc; public ClientController(JdbcTemplate jdbc){this.jdbc=jdbc;}
@GetMapping public List<Map<String,Object>> all(){return jdbc.queryForList("select * from client order by client_id");}
@GetMapping("/{id}") public Map<String,Object> one(@PathVariable String id){return jdbc.queryForMap("select * from client where client_id=?",id);} }
