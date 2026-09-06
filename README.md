# FinOps AI — Phase 1 Starter

A completely fictional financial-operations platform for demonstrating an eventual enterprise AI architecture. Phase 1 intentionally contains **no LLM, RAG, MCP, or agents**. It establishes the system of record and known failure scenarios that later AI components must discover rather than invent.

## Architecture
Angular → Spring Boot REST API → PostgreSQL

Knowledge documents are stored under `knowledge/` for Phase 2 ingestion.

## Run backend + database
```bash
docker compose up --build
```
Backend: http://localhost:8080

Try:
```bash
curl http://localhost:8080/api/trades/T100245/investigation
curl http://localhost:8080/api/settlements?status=FAILED
curl http://localhost:8080/api/wires/WIRE88721
```

Expected T100245 root cause: account SSI participant `1234` differs from counterparty participant `5678`.

## Run Angular UI
```bash
cd frontend
npm install
npm start
```
Open http://localhost:4200 and select **Investigate T100245**.

## Core endpoints
- `GET /api/trades`
- `GET /api/trades/{id}`
- `GET /api/trades/{id}/settlement`
- `GET /api/trades/{id}/investigation`
- `GET /api/settlements?status=FAILED`
- `GET /api/wires`
- `GET /api/wires/{id}`
- `GET /api/accounts/{id}`
- `GET /api/accounts/{id}/wires`
- `GET /api/incidents`

## Next: Phase 2
1. Add pgvector.
2. Chunk and embed `knowledge/` documents.
3. Add LLM-powered question answering.
4. Require citations/evidence for conclusions.
5. Evaluate answers against `simulated-data/scenarios.md`.
