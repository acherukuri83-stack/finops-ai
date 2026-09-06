INSERT INTO client VALUES
('HF101','Alpha Ridge Capital','HEDGE_FUND','ACTIVE','MEDIUM'),
('HF202','Northstar Macro Fund','HEDGE_FUND','ACTIVE','HIGH'),
('AM303','Blue Harbor Asset Management','ASSET_MANAGER','ACTIVE','LOW');

INSERT INTO account VALUES
('ACC10001','HF101','PRIME_BROKERAGE','USD','ACTIVE'),
('ACC20002','HF202','PRIME_BROKERAGE','USD','RESTRICTED'),
('ACC30003','AM303','CUSTODY','USD','ACTIVE');

INSERT INTO standing_settlement_instruction VALUES
('SSI1001','ACC10001','US','USD','DTC','1234','ACTIVE','2026-01-01'),
('SSI2002','ACC20002','US','USD','DTC','2222','ACTIVE','2026-01-01'),
('SSI3003','ACC30003','US','USD','DTC','3333','ACTIVE','2026-01-01');

INSERT INTO trade VALUES
('T100245','HF101','ACC10001','AAPL','BUY',25000,225.50,'2026-09-03','2026-09-04','FAILED'),
('T100246','HF202','ACC20002','MSFT','SELL',15000,410.10,'2026-09-03','2026-09-04','FAILED'),
('T100247','HF101','ACC10001','BADSEC','BUY',1000,100.00,'2026-09-03','2026-09-04','FAILED'),
('T100248','AM303','ACC30003','NVDA','SELL',50000,175.25,'2026-09-03','2026-09-04','FAILED'),
('T100249','HF101','ACC10001','IBM','BUY',5000,210.00,'2026-09-03','2026-09-04','SETTLED');

INSERT INTO settlement VALUES
('SET50001','T100245','FAILED','COUNTERPARTY_SSI_MISMATCH','Counterparty SSI does not match account SSI','5678'),
('SET50002','T100246','FAILED','ACCOUNT_RESTRICTED','Account is restricted for settlement','2222'),
('SET50003','T100247','FAILED','INVALID_SECURITY','Security identifier is not recognized','1234'),
('SET50004','T100248','FAILED','INSUFFICIENT_POSITION','Insufficient position to complete delivery','3333'),
('SET50005','T100249','SETTLED',NULL,NULL,'1234');

INSERT INTO wire VALUES
('WIRE88721','ACC10001',2500000,'USD','2026-09-04 16:47:00','16:30','REJECTED','MISSED_CUTOFF'),
('WIRE88722','ACC20002',500000,'USD','2026-09-04 14:20:00','16:30','REJECTED','ACCOUNT_RESTRICTED'),
('WIRE88723','ACC10001',125000,'USD','2026-09-04 11:05:00','16:30','REJECTED','INVALID_INSTRUCTION'),
('WIRE88724','ACC30003',750000,'USD','2026-09-04 10:15:00','16:30','APPROVED',NULL);

INSERT INTO incident VALUES
('INC1001','SETTLEMENT','Settlement failure caused by SSI mismatch','Counterparty settlement instructions differed from the account SSI.','Operations verified the correct SSI, updated the instruction after approval, and resubmitted the trade.','RESOLVED'),
('INC1002','SETTLEMENT','Settlement failed due to account restriction','The client account was restricted at the time of settlement.','Restriction was reviewed and cleared before resubmission.','RESOLVED'),
('INC1003','REFERENCE_DATA','Invalid security blocked settlement','Security identifier was missing from reference data.','Reference data was corrected and the trade was reprocessed.','RESOLVED'),
('INC1004','WIRE','Wire missed processing cutoff','Wire was approved after the daily processing cutoff.','Wire was queued for the next business day.','RESOLVED'),
('INC1005','WIRE','Wire blocked by restricted account','Outbound wire attempted from a restricted account.','Operations reviewed the restriction before retrying.','RESOLVED');
