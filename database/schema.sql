CREATE TABLE client (
  client_id VARCHAR(20) PRIMARY KEY,
  client_name VARCHAR(120) NOT NULL,
  client_type VARCHAR(40) NOT NULL,
  status VARCHAR(20) NOT NULL,
  risk_level VARCHAR(20) NOT NULL
);

CREATE TABLE account (
  account_id VARCHAR(20) PRIMARY KEY,
  client_id VARCHAR(20) REFERENCES client(client_id),
  account_type VARCHAR(40) NOT NULL,
  currency VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE counterparty (
  counterparty_id VARCHAR(20) PRIMARY KEY,
  counterparty_name VARCHAR(120) NOT NULL,
  status VARCHAR(20) NOT NULL,
  ops_contact VARCHAR(120)
);

CREATE TABLE security_reference (
  security_id VARCHAR(30) PRIMARY KEY,
  description VARCHAR(120),
  status VARCHAR(20) NOT NULL,
  settlement_eligible BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE trade (
  trade_id VARCHAR(20) PRIMARY KEY,
  client_id VARCHAR(20) REFERENCES client(client_id),
  account_id VARCHAR(20) REFERENCES account(account_id),
  counterparty_id VARCHAR(20) REFERENCES counterparty(counterparty_id),
  security VARCHAR(30) REFERENCES security_reference(security_id),
  side VARCHAR(10) NOT NULL,
  quantity NUMERIC(18,2) NOT NULL,
  price NUMERIC(18,4) NOT NULL,
  trade_date DATE NOT NULL,
  settlement_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE settlement (
  settlement_id VARCHAR(20) PRIMARY KEY,
  trade_id VARCHAR(20) REFERENCES trade(trade_id),
  status VARCHAR(20) NOT NULL,
  failure_code VARCHAR(80),
  failure_description VARCHAR(255),
  counterparty_participant_id VARCHAR(30),
  attempt_count INTEGER NOT NULL DEFAULT 0,
  last_attempt_at TIMESTAMP
);

CREATE TABLE standing_settlement_instruction (
  ssi_id VARCHAR(20) PRIMARY KEY,
  account_id VARCHAR(20) REFERENCES account(account_id),
  version INTEGER NOT NULL,
  market VARCHAR(20) NOT NULL,
  currency VARCHAR(10) NOT NULL,
  depository VARCHAR(30) NOT NULL,
  participant_id VARCHAR(30) NOT NULL,
  status VARCHAR(20) NOT NULL,
  valid_from DATE NOT NULL,
  valid_to DATE,
  updated_by VARCHAR(80),
  updated_at TIMESTAMP
);

CREATE TABLE counterparty_ssi (
  counterparty_ssi_id VARCHAR(20) PRIMARY KEY,
  counterparty_id VARCHAR(20) REFERENCES counterparty(counterparty_id),
  our_account_id VARCHAR(20) REFERENCES account(account_id),
  depository VARCHAR(30) NOT NULL,
  participant_id VARCHAR(30) NOT NULL,
  valid_from DATE NOT NULL,
  valid_to DATE,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE affirmation (
  affirmation_id VARCHAR(20) PRIMARY KEY,
  trade_id VARCHAR(20) REFERENCES trade(trade_id),
  affirmed BOOLEAN NOT NULL,
  counterparty_id VARCHAR(20) REFERENCES counterparty(counterparty_id),
  counterparty_dtc VARCHAR(30),
  affirmed_at TIMESTAMP
);

CREATE TABLE account_restriction (
  restriction_id VARCHAR(20) PRIMARY KEY,
  account_id VARCHAR(20) REFERENCES account(account_id),
  restriction_type VARCHAR(60) NOT NULL,
  active BOOLEAN NOT NULL,
  effective_from TIMESTAMP,
  effective_to TIMESTAMP,
  notes VARCHAR(255)
);

CREATE TABLE position (
  position_id VARCHAR(20) PRIMARY KEY,
  account_id VARCHAR(20) REFERENCES account(account_id),
  security_id VARCHAR(30) REFERENCES security_reference(security_id),
  quantity NUMERIC(18,2) NOT NULL,
  as_of TIMESTAMP NOT NULL
);

CREATE TABLE system_log (
  log_id VARCHAR(30) PRIMARY KEY,
  service_name VARCHAR(80) NOT NULL,
  log_level VARCHAR(20) NOT NULL,
  event_time TIMESTAMP NOT NULL,
  trade_id VARCHAR(20),
  correlation_id VARCHAR(80),
  message TEXT NOT NULL
);

CREATE TABLE wire (
  wire_id VARCHAR(20) PRIMARY KEY,
  account_id VARCHAR(20) REFERENCES account(account_id),
  amount NUMERIC(18,2) NOT NULL,
  currency VARCHAR(10) NOT NULL,
  submitted_at TIMESTAMP NOT NULL,
  approval_cutoff TIME NOT NULL,
  status VARCHAR(20) NOT NULL,
  reason_code VARCHAR(80)
);

CREATE TABLE incident (
  incident_id VARCHAR(20) PRIMARY KEY,
  category VARCHAR(40) NOT NULL,
  title VARCHAR(180) NOT NULL,
  description TEXT NOT NULL,
  resolution TEXT,
  status VARCHAR(20) NOT NULL
);
