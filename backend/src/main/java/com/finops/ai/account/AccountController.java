package com.finops.ai.account;
import java.util.*; import org.springframework.jdbc.core.JdbcTemplate; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/accounts")
public class AccountController { private final JdbcTemplate jdbc; public AccountController(JdbcTemplate jdbc){this.jdbc=jdbc;}
@GetMapping("/{id}") public Map<String,Object> one(@PathVariable String id){return jdbc.queryForMap("select * from account where account_id=?",id);}
@GetMapping("/{id}/wires") public List<Map<String,Object>> wires(@PathVariable String id){return jdbc.queryForList("select * from wire where account_id=? order by wire_id",id);} }
