package com.finops.ai.wire;
import java.util.*; import org.springframework.jdbc.core.JdbcTemplate; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/wires")
public class WireController { private final JdbcTemplate jdbc; public WireController(JdbcTemplate jdbc){this.jdbc=jdbc;}
@GetMapping public List<Map<String,Object>> all(){return jdbc.queryForList("select * from wire order by wire_id");}
@GetMapping("/{id}") public Map<String,Object> one(@PathVariable String id){return jdbc.queryForMap("select * from wire where wire_id=?",id);} }
