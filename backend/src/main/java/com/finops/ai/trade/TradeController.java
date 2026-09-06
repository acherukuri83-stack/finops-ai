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
  @GetMapping("/{id}/affirmation") public Map<String,Object> affirmation(@PathVariable String id){return jdbc.queryForMap("select * from affirmation where trade_id=?",id);}
  @GetMapping("/{id}/logs") public List<Map<String,Object>> logs(@PathVariable String id){return jdbc.queryForList("select * from system_log where trade_id=? order by event_time",id);}

  @GetMapping("/{id}/investigation") public Map<String,Object> investigation(@PathVariable String id){
    var trade=one(id);
    var settlement=settlement(id);
    var accountId=String.valueOf(trade.get("account_id"));
    var counterpartyId=String.valueOf(trade.get("counterparty_id"));
    var securityId=String.valueOf(trade.get("security"));

    var account=jdbc.queryForMap("select * from account where account_id=?",accountId);
    var currentSsi=jdbc.queryForMap("select * from standing_settlement_instruction where account_id=? and status='ACTIVE'",accountId);
    var ssiHistory=jdbc.queryForList("select * from standing_settlement_instruction where account_id=? order by version",accountId);
    var affirmation=jdbc.queryForMap("select * from affirmation where trade_id=?",id);
    var counterpartySsi=jdbc.queryForMap("select * from counterparty_ssi where counterparty_id=? and our_account_id=? and status='ACTIVE'",counterpartyId,accountId);
    var restrictions=jdbc.queryForList("select * from account_restriction where account_id=? and active=true",accountId);
    var positions=jdbc.queryForList("select * from position where account_id=? and security_id=? order by as_of desc",accountId,securityId);
    var security=jdbc.queryForMap("select * from security_reference where security_id=?",securityId);
    var logs=jdbc.queryForList("select * from system_log where trade_id=? order by event_time",id);
    var similarIncidents=jdbc.queryForList("select * from incident where category='SETTLEMENT' and lower(title) like '%ssi%' order by incident_id");

    var result=new LinkedHashMap<String,Object>();
    result.put("trade",trade);
    result.put("settlement",settlement);
    result.put("account",account);
    result.put("currentSsi",currentSsi);
    result.put("ssiHistory",ssiHistory);
    result.put("affirmation",affirmation);
    result.put("counterpartySsi",counterpartySsi);
    result.put("activeRestrictions",restrictions);
    result.put("positions",positions);
    result.put("securityReference",security);
    result.put("logs",logs);
    result.put("similarIncidents",similarIncidents);
    result.put("ssiMatch",Objects.equals(String.valueOf(currentSsi.get("participant_id")),String.valueOf(affirmation.get("counterparty_dtc"))));
    result.put("positionSufficient",positions.isEmpty() ? null : ((Number)positions.get(0).get("quantity")).doubleValue() >= ((Number)trade.get("quantity")).doubleValue());
    return result;
  }
}
