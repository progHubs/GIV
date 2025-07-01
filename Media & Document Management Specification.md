# 📁 Media & Document Management Specification

## 🧭 Overview
The Media & Document Management module is responsible for handling all static files such as images, videos, and PDFs, including official reports and brochures. It provides both backend APIs and structured logic for secure upload, multilingual metadata support, and file association with entities such as programs, posts, events, and campaigns.

## 📌 Objectives
- Allow Admin and Editor users to upload and manage media and document files.
- Provide secure storage and retrieval for files with role-based access.
- Enable file linkage to related events, programs, or blog posts.
- Support multilingual metadata with `translation_group_id`.
- Facilitate filtering by type, language, category, and entity association.

---

## 🗂️ Database Tables

### 1. `media`
This aligns with the official schema:

| Field                 | Type                                          | Description                                |
|----------------------|-----------------------------------------------|--------------------------------------------|
| id                   | BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT    | Unique media file ID                       |
| media_type           | ENUM('image', 'video', 'pdf') NOT NULL        | File type category                         |
| title                | VARCHAR(255)                                  | Optional title                             |
| description          | TEXT                                          | Optional media description                 |
| file_url             | VARCHAR(512) NOT NULL                         | File download/view URL                     |
| related_event_id     | BIGINT UNSIGNED                               | FK to `events(id)`                         |
| related_program_id   | BIGINT UNSIGNED                               | FK to `programs(id)`                       |
| uploaded_by          | BIGINT UNSIGNED                               | FK to `users(id)`                          |
| language             | ENUM('en', 'am') DEFAULT 'en'                 | Language for metadata                      |
| translation_group_id | VARCHAR(36)                                   | For linking translations                   |
| uploaded_at          | TIMESTAMP DEFAULT CURRENT_TIMESTAMP           | Upload timestamp                           |

### 2. `documents`
Fully matches your schema:

| Field                 | Type                                          | Description                                |
|----------------------|-----------------------------------------------|--------------------------------------------|
| id                   | BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT    | Unique document ID                         |
| title                | VARCHAR(255) NOT NULL                         | Document title                             |
| description          | TEXT                                          | Document description                       |
| category             | VARCHAR(50)                                   | Document category (e.g., reports)          |
| file_url             | VARCHAR(512) NOT NULL                         | File access URL                            |
| file_size            | BIGINT UNSIGNED                               | File size in bytes                         |
| file_type            | VARCHAR(50)                                   | File MIME type                             |
| uploaded_by          | BIGINT UNSIGNED                               | FK to `users(id)`                          |
| language             | ENUM('en', 'am') DEFAULT 'en'                 | Language of the document                   |
| translation_group_id | VARCHAR(36)                                   | Multilingual grouping                      |
| is_public            | BOOLEAN DEFAULT FALSE                         | Visibility flag                            |
| download_count       | INT UNSIGNED DEFAULT 0                        | Number of downloads                        |
| uploaded_at          | TIMESTAMP DEFAULT CURRENT_TIMESTAMP           | Upload time                                |
| updated_at           | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last modified timestamp   |

---

## 🧱 API Endpoints

### 📤 Media Upload
- **POST** `/api/v1/media`
- Requires role: Admin, Editor
- **Request (multipart/form-data):**
  - `file` (image, video, or PDF)
  - `title`, `description`, `language`, `translation_group_id` (optional)
  - `related_event_id`, `related_program_id` (optional)

### 📥 List Media
- **GET** `/api/v1/media`
- Query params: `media_type`, `language`, `related_program_id`, `related_event_id`, `search`

### 🔗 Attach Media to Entity (Generic)
- **POST** `/api/v1/media/attach`
```json
{
  "media_id": 42,
  "entity_type": "event|program|post|campaign",
  "entity_id": 1001
}
```

### 📄 Document Upload
- **POST** `/api/v1/documents`
- Similar to media upload with title, description, category, etc.

### 📚 List Documents
- **GET** `/api/v1/documents`
- Filters: `language`, `category`, `is_public`

### 🔍 Search
- **GET** `/api/v1/media/search?q=keyword`
- **GET** `/api/v1/documents/search?q=annual`

---

## 🔐 Validation & Security
- File restrictions:
  - Images: `.jpg`, `.png`, `.jpeg`
  - Videos: `.mp4`, `.mov`
  - Documents: `.pdf`, `.docx`, `.pptx`
- Size limits:
  - Images/docs: ≤ 5MB
  - Videos: ≤ 50MB
- RBAC protection: Only Admins/Editors can upload
- File scan support via ClamAV (optional)
- MIME type and extension cross-checking

---

## 🌍 Multilingual Support
- Use of `translation_group_id` and `language` in both tables
- Querying endpoints should allow language filtering
- Admin UI may present related translations in tabs or toggles

---

## 🔄 Entity Linking Table (Optional)

| Field        | Type                         | Description                             |
|--------------|------------------------------|-----------------------------------------|
| id           | BIGINT UNSIGNED PK           | Link ID                                 |
| media_id     | BIGINT UNSIGNED              | Media file ID                           |
| entity_type  | ENUM('event', 'program', etc)| Type of related entity                  |
| entity_id    | BIGINT UNSIGNED              | ID of the linked entity                 |
| created_at   | TIMESTAMP                    | Link created                            |

---

## 🧪 Testing Requirements
- Unit tests for uploads and listing
- Integration for associations and multilingual fetch
- Security and access control scenarios
- MIME-type mismatch simulation

---

## 🛠️ Tools & Libraries
- `Multer` (upload)
- `AWS S3` or `uploads/` (local fallback)
- `Prisma`
- `Joi` validation
- `JWT`, `RBAC` middleware
- `Winston`, `Sentry` (logging & error monitoring)

---

## 📌 Deliverables
- Compliant CRUD API for `media` and `documents`
- Filter and language-aware file listing
- Entity linking system
- Swagger API documentation
- Full test suite >90% coverage

---
