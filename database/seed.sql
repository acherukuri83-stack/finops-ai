INSERT INTO client VALUES
('HF101','Alpha Ridge Capital','HEDGE_FUND','ACTIVE','MEDIUM'),
('HF202','Northstar Macro Fund','HEDGE_FUND','ACTIVE','HIGH'),
('AM303','Blue Harbor Asset Management','ASSET_MANAGER','ACTIVE','LOW');

INSERT INTO account VALUES
('ACC-88213','HF101','PRIME_BROKERAGE','USD','ACTIVE'),
('ACC20002','HF202','PRIME_BROKERAGE','USD','RESTRICTED'),
('ACC30003','AM303','CUSTODY','USD','ACTIVE');

INSERT INTO counterparty VALUES
('CP-017','North Bridge Securities','ACTIVE','cp017-ops@example.test'),
('CP-021','Summit Clearing','ACTIVE','cp021-ops@example.test');

INSERT INTO security_reference VALUES
('AAPL','Apple Inc.','ACTIVE',TRUE),
('MSFT','Microsoft Corp.','ACTIVE',TRUE),
('NVDA','NVIDIA Corp.','ACTIVE',TRUE),
('IBM','IBM Corp.','ACTIVE',TRUE),
('BADSEC','Invalid synthetic security','INVALID',FALSE);

INSERT INTO standing_settlement_instruction VALUES
('SSI-88213-V2','ACC-88213',2,'US','USD','DTC','5678','INACTIVE','2025-11-02','2026-08-28','ops.alee','2025-11-02 09:10:00'),
('SSI-88213-V3','ACC-88213',3,'US','USD','DTC','1234','ACTIVE','2026-08-28',NULL,'ops.jsmith','2026-08-28 10:14:00'),
('SSI2002','ACC20002',1,'US','USD','DTC','2222','ACTIVE','2026-01-01',NULL,'ops.system','2026-01-01 08:00:00'),
('SSI3003','ACC30003',1,'US','USD','DTC','3333','ACTIVE','2026-01-01',NULL,'ops.system','2026-01-01 08:00:00');

INSERT INTO counterparty_ssi VALUES
('CPSSI-017-1','CP-017','ACC-88213','DTC','5678','2025-11-02','2027-01-01','ACTIVE'),
('CPSSI-021-1','CP-021','ACC30003','DTC','3333','2026-01-01','2027-01-01','ACTIVE');

INSERT INTO trade VALUES
('T100245','HF101','ACC-88213','CP-017','AAPL','BUY',25000,225.50,'2026-09-03','2026-09-04','FAILED'),
('T100246','HF202','ACC20002','CP-021','MSFT','SELL',15000,410.10,'2026-09-03','2026-09-04','FAILED'),
('T100247','HF101','ACC-88213','CP-017','BADSEC','BUY',1000,100.00,'2026-09-03','2026-09-04','FAILED'),
('T100248','AM303','ACC30003','CP-021','NVDA','SELL',50000,175.25,'2026-09-03','2026-09-04','FAILED'),
('T100249','HF101','ACC-88213','CP-017','IBM','BUY',5000,210.00,'2026-09-03','2026-09-04','SETTLED');

INSERT INTO settlement VALUES
('SET50001','T100245','FAILED','COUNTERPARTY_SSI_MISMATCH','Counterparty affirmation used a stale SSI','5678',1,'2026-09-04 06:02:00'),
('SET50002','T100246','FAILED','ACCOUNT_RESTRICTED','Account is restricted for settlement','2222',1,'2026-09-04 06:04:00'),
('SET50003','T100247','FAILED','INVALID_SECURITY','Security identifier is not eligible for settlement','1234',1,'2026-09-04 06:06:00'),
('SET50004','T100248','FAILED','INSUFFICIENT_POSITION','Insufficient position to complete delivery','3333',1,'2026-09-04 06:08:00'),
('SET50005','T100249','SETTLED',NULL,NULL,'1234',1,'2026-09-04 06:10:00');

INSERT INTO affirmation VALUES
('AFF-100245','T100245',TRUE,'CP-017','5678','2026-09-03 16:40:00'),
('AFF-100246','T100246',TRUE,'CP-021','2222','2026-09-03 15:10:00'),
('AFF-100247','T100247',TRUE,'CP-017','1234','2026-09-03 15:20:00'),
('AFF-100248','T100248',TRUE,'CP-021','3333','2026-09-03 15:30:00');

INSERT INTO account_restriction VALUES
('RES-20002-1','ACC20002','OUTBOUND_SETTLEMENT_BLOCK',TRUE,'2026-09-01 08:00:00',NULL,'Compliance restriction'),
('RES-88213-HIST','ACC-88213','REVIEW_ONLY',FALSE,'2026-07-01 08:00:00','2026-07-02 12:00:00','Historical closed restriction');

INSERT INTO position VALUES
('POS-88213-AAPL','ACC-88213','AAPL',50000,'2026-09-04 05:55:00'),
('POS-30003-NVDA','ACC30003','NVDA',10000,'2026-09-04 05:55:00'),
('POS-88213-IBM','ACC-88213','IBM',20000,'2026-09-04 05:55:00');

INSERT INTO system_log VALUES
('LOG-100245-1','settlement-engine','ERROR','2026-09-04 06:02:00','T100245','SET-T100245-1','T100245 DTC mismatch: instruction 1234 vs affirmation 5678'),
('LOG-100245-2','settlement-engine','INFO','2026-09-04 06:02:01','T100245','SET-T100245-1','Settlement attempt stopped before submission due to SSI validation failure'),
('LOG-100246-1','settlement-engine','ERROR','2026-09-04 06:04:00','T100246','SET-T100246-1','Account ACC20002 is restricted for outbound settlement'),
('LOG-100248-1','position-service','ERROR','2026-09-04 06:08:00','T100248','SET-T100248-1','Insufficient NVDA position: required 50000 available 10000');

INSERT INTO wire VALUES
('WIRE88721','ACC-88213',2500000,'USD','2026-09-04 16:47:00','16:30','REJECTED','MISSED_CUTOFF'),
('WIRE88722','ACC20002',500000,'USD','2026-09-04 14:20:00','16:30','REJECTED','ACCOUNT_RESTRICTED'),
('WIRE88723','ACC-88213',125000,'USD','2026-09-04 11:05:00','16:30','REJECTED','INVALID_INSTRUCTION'),
('WIRE88724','ACC30003',750000,'USD','2026-09-04 10:15:00','16:30','APPROVED',NULL);

INSERT INTO incident VALUES
('INC-1001','SETTLEMENT','Counterparty stale SSI after recent account SSI change','A counterparty affirmed a trade using the prior DTC participant after our valid SSI had changed.','Operations confirmed the current SSI, requested counterparty re-affirmation using the current instruction, then resubmitted after corrected affirmation. Our SSI was not reverted.','RESOLVED'),
('INC1002','SETTLEMENT','Settlement failed due to account restriction','The client account was restricted at the time of settlement.','Restriction was reviewed and cleared before resubmission.','RESOLVED'),
('INC1003','REFERENCE_DATA','Invalid security blocked settlement','Security identifier was missing or ineligible in reference data.','Reference data was corrected before reprocessing.','RESOLVED'),
('INC1004','WIRE','Wire missed processing cutoff','Wire was approved after the daily processing cutoff.','Wire was queued for the next business day.','RESOLVED'),
('INC1005','WIRE','Wire blocked by restricted account','Outbound wire attempted from a restricted account.','Operations reviewed the restriction before retrying.','RESOLVED');
