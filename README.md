# 📊 Database Schema Overview

This document outlines the main tables and their attributes used in the system. It’s written in plain language to help you understand what each field represents.

---

## 👤 Users

Stores all user account information.

- `id` – Unique user identifier  
- `full_name` – Full name of the user (e.g., "Abebe Bekele")  
- `email` – Email address (e.g., "abebe@example.com")  
- `phone` – Phone number (e.g., "+251911000000")  
- `password_hash` – Encrypted password  
- `role` – Role of the user (e.g., "admin", "user")  
- `is_donor` – Whether the user is a donor (true/false)  
- `is_volunteer` – Whether the user is a volunteer (true/false)  
- `profile_image_url` – Profile picture link  
- `language_preference` – Preferred language (e.g., "en", "am")  
- `email_verified` – Whether the email is verified  
- `created_at`, `updated_at`, `deleted_at` – Record timestamps  

---

## 🤝 Volunteer Profiles

Details for users who are registered as volunteers.

- `user_id` – Linked user account  
- `area_of_expertise` – Main skill or expertise (e.g., "Medical", "Education")  
- `location` – City or region (e.g., "Addis Ababa")  
- `availability` – Days/times available (e.g., `["Monday", "Wednesday", "Saturday"]`)  
- `motivation` – Why the user wants to volunteer  
- `total_hours` – Total hours volunteered (e.g., 85)  
- `certificate_url` – Volunteer certificate link  
- `registered_events_count` – Number of events joined (e.g., 4)  
- `training_completed` – If training is completed (true/false)  
- `background_check_status` – Status (e.g., "approved", "pending", "rejected")  
- `emergency_contact_name` – Emergency contact person (e.g., "Mulu Teshome")  
- `emergency_contact_phone` – Emergency contact number (e.g., "+251922000000")  
- `rating` – Volunteer rating (e.g., 4.5)  
- `created_at`, `updated_at` – Timestamps  

---

## 💰 Donor Profiles

Information for users who donate.

- `user_id` – Linked user account  
- `is_recurring_donor` – Whether donations are recurring (true/false)  
- `preferred_payment_method` – e.g., "Credit Card", "Chapa", "Bank Transfer"  
- `total_donated` – e.g., 1350.00  
- `donation_frequency` – e.g., "monthly", "quarterly", "yearly"  
- `tax_receipt_email` – Email for receipts  
- `is_anonymous` – Whether the donor is anonymous  
- `last_donation_date` – e.g., "2025-07-01"  
- `donation_tier` – e.g., "bronze", "silver", "gold", "platinum"  
- `created_at`, `updated_at` – Timestamps  

---

## 📢 Campaigns

Fundraising campaign information.

- `id` – Campaign identifier  
- `title` – Name (e.g., "Back to School Fundraiser")  
- `slug` – URL-friendly title (e.g., "back-to-school-fundraiser")  
- `description` – Campaign details  
- `goal_amount` – e.g., 50000.00  
- `current_amount` – e.g., 27500.00  
- `start_date`, `end_date` – Campaign duration  
- `is_active` – Whether it’s running (true/false)  
- `is_featured` – Displayed prominently (true/false)  
- `is_completed` – If the goal has been met  
- `category` – e.g., "Education", "Health", "Emergency"  
- `progress_bar_color` – e.g., "green", "blue", "orange"  
- `image_url`, `video_url` – Media links  
- `donor_count` – Number of unique donors (e.g., 120)  
- `success_stories` – JSON data of stories/testimonials  
- `created_by` – ID of user who created  
- `language`, `translation_group_id` – For multilingual content  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🎁 Donations

Tracks donations made to campaigns.

- `id` – Donation ID  
- `donor_id` – Linked donor  
- `campaign_id` – Linked campaign  
- `amount` – e.g., 150.00  
- `currency` – e.g., "USD", "ETB"  
- `donation_type` – e.g., "one_time", "recurring", "in_kind"  
- `payment_method` – e.g., "Chapa", "PayPal"  
- `payment_status` – e.g., "pending", "completed", "failed"  
- `transaction_id` – Unique reference for payment  
- `receipt_url` – Link to receipt  
- `is_acknowledged` – Whether it was acknowledged  
- `is_tax_deductible` – true/false  
- `is_anonymous` – true/false  
- `notes` – Any message from the donor  
- `donated_at`, `created_at`, `updated_at` – Timestamps  

---

## 📆 Events

Details of events organized.

- `id` – Event ID  
- `title`, `slug` – e.g., "Health Camp", "health-camp-2025"  
- `description` – What the event is about  
- `event_date`, `event_time`, `timezone` – When it happens  
- `location` – e.g., "Bahir Dar, Ethiopia"  
- `latitude`, `longitude` – GPS coordinates  
- `category` – e.g., "Medical Outreach", "Youth Program"  
- `capacity` – e.g., 100  
- `registered_count` – Current number of participants  
- `status` – e.g., "upcoming", "ongoing", "completed"  
- `registration_deadline` – Last date to register  
- `registration_link` – Sign-up page  
- `map_embed_url` – Google Maps iframe  
- `agenda`, `speaker_info`, `requirements` – Event content  
- `ticket_price`, `ticket_link` – Paid event info  
- `is_featured` – true/false  
- `created_by` – Creator ID  
- `language`, `translation_group_id` – For multilingual  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🙋 Event Participants

Tracks who joined an event.

- `event_id`, `user_id` – References  
- `role` – e.g., "attendee", "volunteer", "organizer"  
- `status` – e.g., "registered", "confirmed", "attended", "no_show"  
- `hours_contributed` – e.g., 5.5  
- `feedback`, `rating` – Feedback or star rating (1 to 5)  
- `registered_at`, `attended_at` – Timestamps  

---

## 🩺 Programs

Lists structured development programs.

- `id`, `title` – e.g., "Malaria Prevention 2025"  
- `category` – e.g., "medical_outreach", "youth_development"  
- `description` – Program details  
- `start_date`, `end_date` – Duration  
- `location` – e.g., "Jimma, Ethiopia"  
- `impact_stats` – Metrics of success  
- `is_featured` – true/false  
- `created_by` – Creator ID  
- `language`, `translation_group_id` – Multilingual  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 📝 Posts

News, blog, and press updates.

- `id`, `title`, `slug` – e.g., "Why Mental Health Matters", "mental-health-awareness"  
- `content` – Full text  
- `post_type` – e.g., "blog", "news", "press_release"  
- `author_id` – Writer ID  
- `feature_image` – Visual content  
- `views`, `likes`, `comments_count` – Metrics  
- `is_featured` – Highlighted on homepage  
- `tags` – e.g., "health, youth, mental"  
- `language`, `translation_group_id` – Multilingual  
- `created_at`, `updated_at` – Timestamps  

---

## 💬 Comments

User interactions on posts.

- `id`, `post_id`, `user_id` – References  
- `content` – Comment text  
- `parent_id` – For threaded replies  
- `is_approved` – Whether it's visible publicly  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🗂 Media

All uploaded media assets.

- `id`, `media_type` – e.g., "image", "video", "pdf"  
- `title`, `description` – Info  
- `file_url` – Download/view link  
- `related_event_id`, `related_program_id` – Linked  
- `uploaded_by` – User ID  
- `language`, `translation_group_id` – Multilingual  
- `uploaded_at` – Timestamp  

---

## 💬 Testimonials

Personal stories and reviews.

- `id`, `name`, `role` – e.g., "Selam Alemu", "Youth Leader"  
- `message` – Their message  
- `image_url` – Their photo  
- `type` – e.g., "volunteer", "beneficiary", "partner"  
- `language`, `translation_group_id` – Multilingual  
- `is_featured` – Shown prominently  
- `created_at`, `updated_at` – Timestamps  

---

## ❓ FAQs

Commonly asked questions.

- `id`, `question`, `answer` – FAQ content  
- `category` – e.g., "donations", "volunteering"  
- `language`, `translation_group_id` – Multilingual  
- `is_active`, `sort_order` – Display priority  
- `created_at`, `updated_at` – Timestamps  

---

## 🤝 Partners

Organizations working with the platform.

- `id`, `name`, `type`, `category` – e.g., "UNICEF", "ngo", "health"  
- `logo_url`, `website`, `contact_email` – Details  
- `quote` – From the partner  
- `language`, `translation_group_id` – Multilingual  
- `is_active` – Active status  
- `partnership_start_date`, `partnership_end_date` – Timeline  
- `created_at`, `updated_at` – Timestamps  

---

## 📩 Contact Messages

Inquiries received via contact form.

- `id`, `name`, `email`, `subject`, `message` – Form inputs  
- `reason` – e.g., "general", "volunteering", "donations"  
- `status` – e.g., "new", "replied", "closed"  
- `ip_address`, `user_agent` – Technical info  
- `submitted_at`, `replied_at` – Timestamps  

---

## 📄 Documents

Uploaded documents available for download.

- `id`, `title`, `description`, `file_url` – Document info  
- `category`, `file_size`, `file_type` – e.g., "policy", 2MB, "pdf"  
- `uploaded_by` – Who uploaded  
- `language`, `translation_group_id` – Multilingual  
- `is_public` – Visibility setting  
- `download_count` – Number of downloads  
- `uploaded_at`, `updated_at` – Timestamps  

---

## 📨 Newsletter Subscribers

Newsletter list management.

- `id`, `email`, `first_name`, `last_name` – Contact info  
- `is_active` – Active subscription status  
- `language_preference` – e.g., "en", "am"  
- `subscribed_at`, `unsubscribed_at` – Timestamps  

---

## 📧 Email Logs

Tracks email history.

- `id`, `recipient`, `subject`, `template_used` – Email content  
- `content`, `status` – Delivery info (e.g., "sent", "bounced")  
- `error_message` – If failed  
- `sent_at`, `opened_at`, `clicked_at` – Email engagement  

---

## 👣 Site Interactions

User behavior tracking.

- `id`, `user_id`, `session_id`, `page`, `action` – What the user did  
- `metadata` – Extra tracking info  
- `ip_address`, `user_agent` – Device/network  
- `occurred_at` – Timestamp  

---

## 🧠 Skills

Platform-supported skill types.

- `id`, `name` – e.g., "First Aid", "Digital Marketing"  
- `category`, `description` – Skill grouping  
- `created_at` – Timestamp  

---

## 👨‍🔧 Volunteer Skills

Links between volunteers and their skills.

- `volunteer_id`, `skill_id` – References  
- `proficiency_level` – e.g., "beginner", "intermediate", "expert"  
- `is_verified` – Verified skill (true/false)  
- `created_at` – Timestamp  

---

## 🔒 Revoked Tokens

Tracks JWT logout tokens.

- `id`, `token_hash`, `expires_at` – Token details  
- `created_at` – When it was added
