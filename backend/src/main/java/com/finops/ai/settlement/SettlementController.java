package com.finops.ai.settlement;
import java.util.*; import org.springframework.jdbc.core.JdbcTemplate; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/settlements")
public class SettlementController { private final JdbcTemplate jdbc; public SettlementController(JdbcTemplate jdbc){this.jdbc=jdbc;}
@GetMapping public List<Map<String,Object>> all(@RequestParam(required=false) String status){return status==null?jdbc.queryForList("select * from settlement order by settlement_id"):jdbc.queryForList("select * from settlement where status=? order by settlement_id",status);}
@GetMapping("/{id}") public Map<String,Object> one(@PathVariable String id){return jdbc.queryForMap("select * from settlement where settlement_id=?",id);} }
