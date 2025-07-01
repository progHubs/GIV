# 📁 Program & Initiative Management Specification

## 🧭 Overview
The Program & Initiative Management module enables the administration, multilingual presentation, and impact reporting of various social programs. Each program entry supports rich descriptions, language variants, media associations, and testimonial linkages. It is designed to power both internal dashboards and the public-facing showcase of GIV Society initiatives.

## 📌 Objectives
- Enable full CRUD lifecycle for programs and initiatives.
- Allow program managers to track impact metrics.
- Integrate with media and testimonials modules.
- Provide multilingual support.
- Expose APIs for public and admin-facing UIs.

---

## 🗂️ Database Tables

### 1. `programs`
| Field                 | Type                                                            | Description                                 |
|----------------------|-----------------------------------------------------------------|---------------------------------------------|
| id                   | BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY                      | Unique program ID                           |
| title                | VARCHAR(255) NOT NULL                                           | Program title                               |
| category             | ENUM('medical_outreach', 'mental_health', 'youth_development', 'disease_prevention') | Program category        |
| description          | TEXT                                                            | Program description                         |
| start_date           | DATE                                                            | Start of the program                         |
| end_date             | DATE                                                            | End of the program                           |
| location             | VARCHAR(255)                                                    | Location of the program                      |
| impact_stats         | JSON                                                            | Structured JSON for metrics/KPIs            |
| is_featured          | BOOLEAN DEFAULT FALSE                                           | Homepage highlight                          |
| created_by           | BIGINT UNSIGNED                                                 | User ID who created it                      |
| language             | ENUM('en', 'am') DEFAULT 'en'                                   | Language version                            |
| translation_group_id | VARCHAR(36)                                                     | Link translations                           |
| created_at           | TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             | Creation time                               |
| updated_at           | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update                                 |
| deleted_at           | TIMESTAMP NULL                                                  | Soft delete                                 |

### 2. `media`
| Field               | Type                              | Description                                  |
|--------------------|-----------------------------------|----------------------------------------------|
| related_program_id | BIGINT UNSIGNED                   | Foreign key for program association          |

### 3. `testimonials`
| Field               | Type                              | Description                                  |
|--------------------|-----------------------------------|----------------------------------------------|
| translation_group_id | VARCHAR(36)                      | For multilingual linkage                     |

---

## 🧱 API Endpoints

### ➕ Create Program
- **POST** `/api/v1/programs`
- Required fields: `title`, `category`, `description`, `start_date`, `end_date`, `location`, `language`
- Optional: `impact_stats`, `is_featured`, `translation_group_id`

### 📝 Update Program
- **PATCH** `/api/v1/programs/:id`
- Partial updates allowed.

### ❌ Soft Delete Program
- **DELETE** `/api/v1/programs/:id`
- Sets `deleted_at` to current timestamp.

### 📄 List Programs
- **GET** `/api/v1/programs`
- Filters: `category`, `language`, `date_range`, `is_featured`

### 🔍 View Program
- **GET** `/api/v1/programs/:id`
- Optional query param to include: `media`, `testimonials`, `translation_group`

### 📊 Program Report
- **GET** `/api/v1/programs/:id/report`
- Returns full data view including KPIs and relationships

---

## 🔄 Relationships & Integrations
- **Media:** Linked via `media.related_program_id`
- **Testimonials:** Query via `GET /api/v1/testimonials?program_id=...` if added to schema
- **Multilingual:** Uses `language` and `translation_group_id` fields, consistent with system-wide multilingual strategy

---

## 🌍 Multilingual Strategy
- Supported via:
  - `language`: content language
  - `translation_group_id`: UUID that links equivalent entries across languages
- Endpoints should allow language fallback or switching
- Admin panel should provide view/edit per language

---

## 🧪 Testing Requirements
- Unit tests: creation, updates, deletes
- Integration tests: media and testimonial linking, report generation
- Security: RBAC for write operations
- Validation: schema rules for dates, enums, and foreign keys

---

## 🛠️ Technologies
- ORM: Prisma
- API framework: Express.js
- Validators: Joi or Zod
- Middleware: JWT auth, Role-based guard, Language detection

---

## 📌 Deliverables
- Complete RESTful CRUD for programs
- Filtering and multilingual support
- Report generator per program
- Program-media-testimonial association endpoints
- Swagger/OpenAPI documentation
- >90% test coverage

---
