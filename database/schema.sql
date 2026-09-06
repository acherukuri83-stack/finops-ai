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

CREATE TABLE trade (
  trade_id VARCHAR(20) PRIMARY KEY,
  client_id VARCHAR(20) REFERENCES client(client_id),
  account_id VARCHAR(20) REFERENCES account(account_id),
  security VARCHAR(30) NOT NULL,
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
  counterparty_participant_id VARCHAR(30)
);

CREATE TABLE standing_settlement_instruction (
  ssi_id VARCHAR(20) PRIMARY KEY,
  account_id VARCHAR(20) REFERENCES account(account_id),
  market VARCHAR(20) NOT NULL,
  currency VARCHAR(10) NOT NULL,
  depository VARCHAR(30) NOT NULL,
  participant_id VARCHAR(30) NOT NULL,
  status VARCHAR(20) NOT NULL,
  effective_date DATE NOT NULL
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
