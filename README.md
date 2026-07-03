# IT Workforce Readiness Simulator: Telemetry Data Pipeline

## 🚀 Project Overview
This repository contains an object-oriented Python log generator that simulates high-velocity user telemetry data from an enterprise-level IT workforce readiness simulator. The script generates synthetic behavioral and system error logs to mimic real-world platform performance, which are subsequently ingested into a cloud data warehouse for bottleneck and triage analysis.

The core objective of this project is to model, track, and diagnose user drop-off patterns, specifically investigating an operational bottleneck where technical glitches heavily impact user retention.

---

## 🛠️ Tech Stack & Architecture
* **Data Generation:** Python 3 (Object-Oriented Programming, NumPy/Pandas)
* **Data Modeling & Storage:** Snowflake Cloud Data Warehouse
* **Data Visualization:** Business Intelligence (BI) Dashboard Analytics

---

## 📊 Relational Database Schema (ERD)
The pipeline ingestion architecture utilizes a Star-like Schema optimized for rapid query analytical processing, dividing the generated telemetry into a core Dimension table and a transactional Fact table:

* **`PLAYER_DIM` (Dimension):** Contains immutable trainee attributes (`PLAYER_ID`, `SIGNUP_DATE`, `COHORT`, `ACCOUNT_TIER`).
* **`GAME_LOGS` (Fact Telemetry):** Captures high-frequency time-series system logs (`LOG_ID`, `PLAYER_ID`, `TIMESTAMP`, `LEVEL_REACHED`, `COMPLETION_VELOCITY_SEC`, `ERRORS_ENCOUNTERED`, `STATUS`).

*Relationship: 1-to-Many ($1 \rightarrow \infty$) connected via `PLAYER_ID`.*

---

## 🔧 Script Functionality & Weighted Logic
The Python data engine generates complex, interrelated datasets rather than standard randomized rows:
1. **User Growth Modeling:** Simulates realistic user sign-ups and distributes trainees across distinct training cohorts and operational account tiers.
2. **Behavioral Simulation:** Evaluates individual trainee progression through 5 sequential difficulty levels.
3. **Injected Failure Logic:** Employs weighted probability distributions to inject a severe spike in system errors (`ERRORS_ENCOUNTERED`) and processing latency (`COMPLETION_VELOCITY_SEC`) specifically at **Level 4** to test downstream analytics triage workflows.

---

## 📥 Getting Started & Output
To run the telemetry generator locally:

```bash
python telemetry_generator.py
