package com.finops.ai.trade;
import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/trades")
public class TradeController {
  private final JdbcTemplate jdbc;
  public TradeController(JdbcTemplate jdbc){this.jdbc=jdbc;}
  @GetMapping public List<Map<String,Object>> all(){return jdbc.queryForList("select * from trade order by trade_id");}
  @GetMapping("/{id}") public Map<String,Object> one(@PathVariable String id){return jdbc.queryForMap("select * from trade where trade_id=?",id);}
  @GetMapping("/{id}/settlement") public Map<String,Object> settlement(@PathVariable String id){return jdbc.queryForMap("select * from settlement where trade_id=?",id);}
  @GetMapping("/{id}/investigation") public Map<String,Object> investigation(@PathVariable String id){
    var trade=one(id);
    var settlement=settlement(id);
    var account=jdbc.queryForMap("select * from account where account_id=?",trade.get("account_id"));
    var ssi=jdbc.queryForMap("select * from standing_settlement_instruction where account_id=? and status='ACTIVE'",trade.get("account_id"));
    var result=new LinkedHashMap<String,Object>(); result.put("trade",trade); result.put("account",account); result.put("settlement",settlement); result.put("accountSsi",ssi);
    result.put("ssiMatch",Objects.equals(String.valueOf(ssi.get("participant_id")),String.valueOf(settlement.get("counterparty_participant_id"))));
    return result;
  }
}
