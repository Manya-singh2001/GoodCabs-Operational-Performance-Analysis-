# 🚖 GoodCabs Operational Performance Analysis  
### *A Data-Driven Evaluation of Growth, Efficiency & Customer Experience in Tier-II City Mobility Markets*

![Power BI](https://img.shields.io/badge/Tool-Power%20BI-yellow?logo=powerbi)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue?logo=mysql)
![DAX](https://img.shields.io/badge/Language-DAX-orange)
![Analytics](https://img.shields.io/badge/Focus-Business%20Intelligence-brightgreen)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

## 🏢 Company Background  

**GoodCabs**, founded in **2023**, is a growing cab service provider focusing on **India’s tier-II cities** — an underserved but rapidly expanding market. The company’s mission is to **empower local drivers**, create **sustainable urban mobility ecosystems**, and deliver a **seamless travel experience** for passengers.  

Operating across **10 cities**, GoodCabs aims to balance **affordability**, **driver income growth**, and **passenger satisfaction** through data-driven decision-making.  

---

## 🔎 Problem Statement  

After two years of operations, GoodCabs has not yet achieved its **market penetration targets** for 2024.  
While brand presence has strengthened, **key operational KPIs** — including repeat passenger rates and target achievement ratios — indicate untapped potential and underlying inefficiencies.  

This analysis seeks to:  
- Identify **underperforming cities and KPIs** across trip, revenue, and satisfaction metrics.  
- Diagnose **operational bottlenecks** and behavioral trends in new vs. repeat passengers.  
- Provide **data-driven recommendations** to optimize growth, retention, and resource allocation.  

---

## 🎯 Project Objectives  

The overarching objective of this project is to establish an **Operational Intelligence Framework** for GoodCabs using Power BI and MySQL.  
The framework aligns business outcomes to measurable KPIs and OKRs under three strategic pillars:

| Pillar | Objective (OKR) | Key Metrics (KPIs) |
|--------|-----------------|--------------------|
| **Growth** | Increase trip volume and new passenger acquisition | Total Trips, Total Revenue, Target Achievement % |
| **Customer Experience** | Improve passenger satisfaction & engagement | Avg. Passenger Rating, Repeat Passenger Rate (RPR) |
| **Efficiency & Retention** | Strengthen repeat ridership and operational yield | Avg. Fare per Trip, Avg. Distance, Fare Efficiency Ratio |

---

## 🌟 North Star Metric  

> **Repeat Passenger Rate (RPR)** — The single most critical measure of sustainable growth.  
A rising RPR signifies enhanced passenger trust, operational consistency, and long-term profitability.

---

## 🧠 Business Intelligence Framework  

The analytical model is built around three performance layers:  

1. **Executive View** – Company-wide KPIs and OKRs tracking total revenue, trip volume, and rating targets.  
2. **City View** – Regional performance benchmarking to identify high-performing and lagging cities.  
3. **Passenger View** – Behavioral insights into passenger satisfaction, loyalty, and trip distribution.  

---

## 🛠️ Tools & Technologies  

| Tool | Function |
|------|-----------|
| **MySQL** | Data extraction, transformation, and business query resolution |
| **Power BI (DAX)** | KPI creation, dashboard visualization, and performance tracking |
| **Microsoft Excel** | Target setting and alignment of performance goals |
| **Figma** | Dashboard layout and presentation polish |

---

## 🧩 Semantic Model  

A well-structured **semantic model** was built in **Power BI** to establish relationships across all fact and dimension tables.  
This model integrates key business entities — such as cities, trips, passengers, and targets — to deliver a unified analytical layer.  

It supports:
- Cross-filtering between **monthly**, **city**, and **passenger-level metrics**.  
- Efficient **DAX-based measure computation** for dynamic KPI tracking.  
- Scalable architecture that enhances both **data integrity** and **query performance**.  

<p align="center">
  <img src="https://github.com/Manya-singh2001/GoodCabs-Operational-Performance-Analysis-/blob/main/Resources/BI%20Dashboard/Semantic%20model%20.png" alt="GoodCabs Semantic Model" width="80%">
</p>

---

## 💻 Business Problems Solved Using MySQL  

To support the analytical layer, **six business problems** were solved using optimized SQL queries.  
These queries provided measurable business insights, feeding directly into Power BI dashboards.[here](https://github.com/Manya-singh2001/GoodCabs-Operational-Performance-Analysis-/blob/main/Ad-hoc%20Business_requests.sql)

---

### 1️⃣ **City-Level Fare and Trip Summary Report**
**Goal:** Assess each city’s operational efficiency and contribution to total trip volume.  
**Insights Generated:**  
- Ranked cities based on **trip count and fare efficiency**.  
- Identified pricing gaps using **average fare per km** and **average fare per trip**.  
- Quantified each city’s **percentage contribution** to the overall network activity.

---

### 2️⃣ **Monthly City-Level Trips Target Performance**
**Goal:** Evaluate how each city performed against monthly trip targets.  
**Insights Generated:**  
- Classified cities as **Above Target** or **Below Target**.  
- Measured **percentage variance** between actual and target trips.  
- Helped management focus on **underperforming locations**.

---

### 3️⃣ **City-Level Repeat Passenger Trip Frequency Report**
**Goal:** Understand passenger loyalty by tracking repeat trip frequencies (2–10 rides).  
**Insights Generated:**  
- Segmented **repeat passengers** by number of trips.  
- Identified high-loyalty cities with **frequent returning users**.  
- Provided retention insights for **city-specific engagement strategies**.

---

### 4️⃣ **Identify Cities with Highest and Lowest New Passengers**
**Goal:** Rank cities by new passenger acquisition to gauge growth.  
**Insights Generated:**  
- Highlighted **Top 3** and **Bottom 3** cities by new passenger count.  
- Provided a view into **marketing success** and **penetration inefficiencies**.  
- Guided future resource and **campaign allocation** decisions.

---

### 5️⃣ **Identify Month with Highest Revenue for Each City**
**Goal:** Detect seasonal trends and revenue concentration across months.  
**Insights Generated:**  
- Identified **peak months** for revenue in each city.  
- Calculated each month’s **percentage contribution** to city revenue.  
- Supported **demand forecasting and seasonal strategy planning**.

---

### 6️⃣ **Repeat Passenger Rate (RPR) Analysis**
**Goal:** Track repeat passenger behavior at monthly and city-wide levels.  
**Insights Generated:**  
- Calculated **monthly and aggregate RPR** for each city.  
- Revealed **top-performing cities** for retention and loyalty.  
- Directly powered the project’s **North Star Metric** dashboard component.

---

## 📊 Dashboard Suite  

The Power BI solution consists of **three interconnected dashboards**, each designed for distinct business users:  

### 1️⃣ **Executive Dashboard** – *Strategic KPI Overview*  
- Tracks **total revenue (₹108.2M)**, **total trips (425.9K)**, and **RPR performance (61.31K repeat users)**.  
- Highlights **target achievement %** and **weekday vs. weekend revenue contributions**.  
- Monitors alignment with company OKRs at the executive level.  

![Executive Dashboard](https://github.com/Manya-singh2001/GoodCabs-Operational-Performance-Analysis-/blob/main/Resources/BI%20Dashboard/Executive%20Dashboard%20.png)

---

### 2️⃣ **City Dashboard** – *Regional Operational Insights*  
- Evaluates **city-wise revenue contribution** and **trip performance variance**.  
- Analyzes **repeat passenger engagement** and **target fulfillment rates**.  
- Highlights **Jaipur, Kochi, and Chandigarh** as top-performing cities by revenue.  

![City Dashboard](https://github.com/Manya-singh2001/GoodCabs-Operational-Performance-Analysis-/blob/main/Resources/BI%20Dashboard/City%20Dashboard%20.png)

---

### 3️⃣ **Passenger Dashboard** – *Experience & Loyalty Analytics*  
- Focuses on **Average Passenger Rating**, **Repeat Passenger Rate**, and **Trip Frequency Trends**.  
- Benchmarks **passenger satisfaction** across tourist and business cities.  
- Supports strategy formation for **loyalty program design**.  

![Passenger Dashboard](https://github.com/Manya-singh2001/GoodCabs-Operational-Performance-Analysis-/blob/main/Resources/BI%20Dashboard/Passenger%20Dashboard%20.png)

---

## 💡 Key Insights  

### 📈 **Growth & Revenue**
- **Jaipur (₹37.2M)**, **Kochi (₹17.0M)**, and **Chandigarh (₹11.0M)** are top revenue cities.  
- **February** contributed the highest monthly share (18.36%) to total revenue.  

### 👥 **Customer Engagement**
- **Tourist cities (Jaipur, Mysore)** have the highest average ratings (>8.5).  
- **Business cities (Surat, Lucknow)** underperform in satisfaction (<6.5).  

### 🔁 **Retention & Loyalty**
- **Surat (43%)** and **Lucknow (37%)** show strong repeat engagement.  
- **Mysore (11%)** and **Jaipur (17%)** lag — high dependency on new passengers.  

### 💰 **Efficiency Metrics**
- **Jaipur**: Highest fare per trip (₹484) due to longer trip distances (~30 km).  
- **Surat**: Lowest fare (₹117) but high repeat rate — indicating **price-driven loyalty**.  

---

## 🧩 Strategic Recommendations  

| Focus Area | Recommendation | Expected Outcome |
|-------------|----------------|------------------|
| **Passenger Experience** | Introduce feedback-driven driver training & loyalty rewards | ↑ Ratings, ↑ Retention |
| **Targeted Marketing** | Launch seasonal campaigns during low-demand months | ↑ Trip volume, ↓ idle hours |
| **City Partnerships** | Collaborate with hotels, IT parks, and event organizers | ↑ Passenger acquisition |
| **Pricing Strategy** | Introduce dynamic pricing in tourist-heavy regions | ↑ Revenue per km |
| **Sustainability Initiative** | Deploy EV fleets in long-distance cities | ↓ Fuel costs, ↑ Brand perception |

---

## 👩‍💼 Author  

**Manya Singh**  
*Data Analyst | Business Intelligence | SQL | Power BI | Data Storytelling*  
📍 India  
🔗 [LinkedIn Profile (https://www.linkedin.com/in/manya-singh-a6406b253/)](#)  
📧 [Email](manyasinghsingh16699@gmail.com)
