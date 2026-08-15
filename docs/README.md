# TransitOps Documentation Hub

Welcome to the central technical and product documentation repository for **TransitOps – Smart Transport Operations Platform**.

This documentation suite is organized systematically to provide complete clarity for product management, software engineering, architecture, database design, and UI/UX design/wireframing (Stitch / Figma alignment).

---

## 📚 Documentation Index

| Document | Description | Key Audience |
|---|---|---|
| [PRD.md](PRD.md) | **Product Requirements Document**: Vision, problem statement, personas, epics, business rules, and acceptance criteria | Product Managers, Stakeholders, Developers |
| [02_SRS.md](02_SRS.md) | **Software Requirements Specification**: IEEE 830-compliant functional & non-functional requirements, validation rules, business logic | Developers, QA Engineers, Architects |
| [03_User_Roles_and_Permissions.md](03_User_Roles_and_Permissions.md) | **User Personas & RBAC Matrix**: 5 Role specifications, permission tables, operational boundaries | Security, Product, Developers |
| [04_System_Architecture_and_Design.md](04_System_Architecture_and_Design.md) | **Architecture & System Design**: ASP.NET Core 10 Clean Architecture, component diagrams, technology stack | Architects, Backend Engineers |
| [05_Database_Schema_and_ERD.md](05_Database_Schema_and_ERD.md) | **Database Schema & ERD**: Tables, field definitions, indexes, relationships, data dictionary | Data Engineers, Backend Engineers |
| [06_Workflows_and_State_Machines.md](06_Workflows_and_State_Machines.md) | **Workflows & State Machines**: Sequence diagrams & state transitions for Trips, Maintenance, and Costs | Developers, Business Analysts |
| [07_UI_UX_Wireframe_Spec.md](07_UI_UX_Wireframe_Spec.md) | **UI/UX Screen Specs & Design Tokens**: Screen-by-screen wireframe layouts, component specs, design tokens for Stitch alignment | UI/UX Designers, Frontend Engineers |
| [08_Design_Inspiration_and_Styleguide.md](08_Design_Inspiration_and_Styleguide.md) | **Design Inspiration & Minimal Styleguide**: Curated reference websites (Linear, Stripe, Samsara, Vercel) & minimal white color tokens | Designers, Frontend Engineers |
| [09_Stitch_Wireframe_Prompt_HomePage.md](09_Stitch_Wireframe_Prompt_HomePage.md) | **Stitch Design Prompt & Layout Specification**: Ready-to-use high-fidelity prompt for generating the Operations Dashboard in Stitch | UI/UX Designers |

---

## 🎯 Quick Reference: Mandatory Business Rules
1. **Unique Vehicle Registration**: Every vehicle registration plate must be strictly unique.
2. **Dispatch Vehicle Pool**: Vehicles marked as `Retired` or `InShop` must **never** appear in trip assignment dropdowns.
3. **Driver Compliance**: Drivers with expired driving licenses or `Suspended`/`OffDuty` status cannot be assigned to trips.
4. **No Double Booking**: A vehicle or driver currently `OnTrip` cannot be assigned to another trip.
5. **Payload Limit Validation**: $\text{Cargo Weight} \le \text{Vehicle Maximum Load Capacity}$.
6. **Automatic Dispatch Transition**: Dispatching a trip switches both Vehicle and Driver status to `OnTrip`.
7. **Automatic Completion Transition**: Completing a trip restores Vehicle and Driver status to `Available`, updates Odometer, and logs fuel.
8. **Automatic Cancellation Reversal**: Cancelling a dispatched trip immediately restores Vehicle and Driver to `Available`.
9. **Maintenance Status Lock**: Creating an active maintenance log automatically switches Vehicle status to `InShop` and removes it from dispatch.
10. **Maintenance Resolution**: Completing maintenance restores Vehicle status to `Available` (unless `Retired`).
