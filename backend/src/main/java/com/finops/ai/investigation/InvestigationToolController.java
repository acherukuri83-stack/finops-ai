package com.finops.ai.investigation;

import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/tools")
public class InvestigationToolController {
  private final JdbcTemplate jdbc;
  public InvestigationToolController(JdbcTemplate jdbc){this.jdbc=jdbc;}

  @GetMapping("/accounts/{accountId}/ssi")
  public Map<String,Object> getSsi(@PathVariable String accountId){
    return jdbc.queryForMap("select * from standing_settlement_instruction where account_id=? and status='ACTIVE'",accountId);
  }

  @GetMapping("/accounts/{accountId}/ssi-history")
  public List<Map<String,Object>> getSsiHistory(@PathVariable String accountId){
    return jdbc.queryForList("select * from standing_settlement_instruction where account_id=? order by version",accountId);
  }

  @GetMapping("/counterparties/{counterpartyId}/ssi")
  public List<Map<String,Object>> getCounterpartySsi(@PathVariable String counterpartyId,@RequestParam(required=false) String accountId){
    return accountId==null
      ? jdbc.queryForList("select * from counterparty_ssi where counterparty_id=? order by valid_from",counterpartyId)
      : jdbc.queryForList("select * from counterparty_ssi where counterparty_id=? and our_account_id=? order by valid_from",counterpartyId,accountId);
  }

  @GetMapping("/trades/{tradeId}/affirmation")
  public Map<String,Object> getAffirmation(@PathVariable String tradeId){
    return jdbc.queryForMap("select * from affirmation where trade_id=?",tradeId);
  }

  @GetMapping("/logs")
  public List<Map<String,Object>> searchLogs(@RequestParam(required=false) String tradeId,@RequestParam(required=false) String q){
    if(tradeId!=null && q!=null) return jdbc.queryForList("select * from system_log where trade_id=? and lower(message) like lower(?) order by event_time",tradeId,"%"+q+"%");
    if(tradeId!=null) return jdbc.queryForList("select * from system_log where trade_id=? order by event_time",tradeId);
    if(q!=null) return jdbc.queryForList("select * from system_log where lower(message) like lower(?) order by event_time","%"+q+"%");
    return jdbc.queryForList("select * from system_log order by event_time");
  }

  @GetMapping("/incidents")
  public List<Map<String,Object>> findIncidents(@RequestParam(required=false) String q){
    return q==null
      ? jdbc.queryForList("select * from incident order by incident_id")
      : jdbc.queryForList("select * from incident where lower(title) like lower(?) or lower(description) like lower(?) order by incident_id","%"+q+"%","%"+q+"%");
  }
}
