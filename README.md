Subscripify - A Salesforce Subscription Management Platform
An end-to-end, automated platform for running a subscription box business, built entirely on the Salesforce Platform.

What is Subscripify?
Subscripify is a custom Salesforce application designed to manage the entire operational lifecycle of a subscription box service (e.g., a curated snack box, coffee club, or beauty box). It provides a single, centralized system to handle everything from recurring customer billing to physical inventory management and shipping, along with a self-service portal for subscribers.

Why Was This Built? (The Problem)
Many promising subscription box startups fail when they try to grow. A business that is manageable at 20 subscribers with spreadsheets and manual invoicing becomes chaotic at 200 and impossible at 2000. This "scaling problem" leads to billing errors, shipping delays, and poor customer service.

Subscripify was built to solve this exact problem. It provides the automated, scalable engine that allows a subscription business to grow from a small startup to a large enterprise without being overwhelmed by manual administrative work.

Core Features
🚀 Automated Monthly Billing Engine: A scalable Scheduled Apex job that runs monthly to automatically generate invoices and process payments for all active subscribers.

📦 Real-Time Inventory Management: Tracks the stock levels of all physical products, automatically decrementing quantities as orders are fulfilled to prevent overselling.

🚚 Fulfillment & Shipment Tracking: A clear process flow from a paid invoice to a shipment record, allowing warehouse teams to see a queue of orders ready to be shipped.

💻 Customer Self-Service Portal: Built with Experience Cloud and Lightning Web Components (LWC), this portal allows subscribers to log in and manage their own account, update their shipping/payment info, and pause their subscription.

📊 Business Performance Dashboards: Real-time dashboards and reports to track key industry metrics like Monthly Recurring Revenue (MRR) and Customer Churn Rate.

🔒 Secure by Design: Built with a private sharing model to ensure all customer and financial data is secure and confidential.

Tech Stack
Platform: Salesforce

Backend: Apex (Triggers, Scheduled Jobs, Batch Jobs)

Frontend: Lightning Web Components (LWC), Experience Cloud

Development Model: Salesforce DX (SFDX)

Data Model
The data model is built around a few key custom objects that model the subscription lifecycle.

Contact (Subscriber) → Subscription__c → Invoice__c → Shipment__c

Developed By
AKSHAT SHARMA

