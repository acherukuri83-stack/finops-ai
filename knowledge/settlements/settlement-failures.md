# Settlement Handbook

## 8.1 Settlement exception triage
For a failed settlement, verify the trade, settlement status, account status, security eligibility, position sufficiency, current settlement instruction, counterparty affirmation, and relevant system logs before proposing remediation.

## 8.4 Counterparty SSI mismatch
A counterparty SSI mismatch occurs when the settlement instruction used by the counterparty does not match our current valid standing settlement instruction.

### Investigation
1. Retrieve the trade and settlement attempt.
2. Confirm the client account has no active restriction preventing settlement.
3. Retrieve the current active account SSI.
4. Retrieve SSI history to determine whether the current instruction changed recently.
5. Retrieve the counterparty affirmation and compare the affirmed depository/participant values with our current SSI.
6. Retrieve the counterparty's recorded SSI for our account.
7. Search settlement-engine logs for corroborating instruction-versus-affirmation evidence.
8. Verify security eligibility and position sufficiency to rule out unrelated blockers.
9. Review similar resolved incidents where useful.

### Policy
**Paragraph 3:** Do not amend the client SSI to match a counterparty affirmation. Confirm which instruction is current; if ours is current, request re-affirmation.

### Resolution
If our current SSI is valid and the counterparty used an older instruction:
- contact counterparty operations and provide the current settlement instruction;
- request corrected affirmation against the current SSI;
- only after corrected affirmation, propose settlement resubmission;
- do not revert our current SSI simply to force a match.

Changes to our SSI and settlement resubmission are controlled actions and require the applicable operations approval.
