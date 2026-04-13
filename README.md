# E-Commerce-Performance-Analysis

🔹 Problem Statement

E-commerce businesses generate large volumes of transactional data, but decision-makers often lack a clear, consolidated view of performance.

The goal of this project was to:

1. Track revenue and growth trends
2. Analyze customer and order behavior
3. Identify key drivers and operational bottlenecks

🔹 Data Source :
Brazilian E-commerce Dataset (Olist)
Includes orders, payments, customers, products, and reviews

🔹 Approach :
1. Data Preparation (SQL) :

a. Created normalized tables for:
  1. Orders
  2. Customers
  3. Payments
  4. Products

b. Built analysis-specific datasets:
  1. Order-level (KPIs)
  2. Customer-level (spend behavior)
  3. Payment-level (transaction insights)

2. Data Modeling (Tableau) :

  a. Used relationships to maintain correct granularity
  b. Avoided duplication across payment and order datasets
  c. Designed datasets aligned with business use cases

3. Dashboard Development :

Built an interactive dashboard featuring:

  1. KPI cards:
    a. Total Revenue
    b. Completed Orders
    c. Average Order Value
    d. Discount %
  2. Time analysis:
    a. Revenue trends
    b. Month-over-Month comparison
  3. Business insights:
    a. Category performance
    b. Regional analysis
    c. Payment behavior

4. Advanced Features
LOD expressions for accurate aggregation
Dynamic time comparisons (CY vs PY, PM)
Conditional formatting (↑ ↓ indicators)
Custom tooltips with contextual insights

5. Executive Story (Tableau Story)

Created a guided report covering:

Revenue performance
Growth trends
Operational efficiency
Customer behavior

🔹 Key Insights :

Revenue showed consistent growth with seasonal peaks
Top categories contributed majority of revenue
Order completion rate declined, indicating operational inefficiencies
Majority of transactions were via credit card

🔹 Impact :

This dashboard enables:

1. Faster decision-making
2. Clear performance tracking
3. Identification of business risks and opportunities

[Link to dashboard](https://public.tableau.com/app/profile/sachingupta/viz/e_comm_dashbaord/Overview)
