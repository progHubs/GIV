# 📊 Database Schema Overview

This document outlines the main tables and their attributes used in the system. It’s written in plain language to help you understand what each field represents.

---

## 👤 Users

Stores all user account information.

- `id` – Unique user identifier  
- `full_name` – Full name of the user  
- `email` – Email address  
- `phone` – Phone number  
- `password_hash` – Encrypted password  
- `role` – Role of the user (admin or user)  
- `is_donor` – Whether the user is a donor  
- `is_volunteer` – Whether the user is a volunteer  
- `profile_image_url` – Profile picture link  
- `language_preference` – Preferred language (en or am)  
- `email_verified` – Whether the email is verified  
- `created_at`, `updated_at`, `deleted_at` – Record timestamps  

---

## 🤝 Volunteer Profiles

Details for users who are registered as volunteers.

- `user_id` – Linked user account  
- `area_of_expertise` – Main skill or expertise  
- `location` – City or region  
- `availability` – Days/times available for volunteering  
- `motivation` – Why the user wants to volunteer  
- `total_hours` – Total volunteer hours  
- `certificate_url` – Volunteer certificate link  
- `registered_events_count` – Number of events joined  
- `training_completed` – If training is completed  
- `background_check_status` – Status of background check  
- `emergency_contact_name` – Emergency contact person  
- `emergency_contact_phone` – Emergency contact number  
- `rating` – Volunteer performance rating  
- `created_at`, `updated_at` – Timestamps  

---

## 💰 Donor Profiles

Information for users who donate.

- `user_id` – Linked user account  
- `is_recurring_donor` – Whether donations are recurring  
- `preferred_payment_method` – Usual payment type  
- `total_donated` – Total amount donated  
- `donation_frequency` – Frequency of donations  
- `tax_receipt_email` – Email for tax receipts  
- `is_anonymous` – If the donor prefers to stay anonymous  
- `last_donation_date` – Date of last donation  
- `donation_tier` – Donor level (bronze, silver, etc.)  
- `created_at`, `updated_at` – Timestamps  

---

## 📢 Campaigns

Fundraising campaign information.

- `id` – Campaign identifier  
- `title` – Name of the campaign  
- `slug` – URL-friendly version of title  
- `description` – Campaign details  
- `goal_amount` – Fundraising target  
- `current_amount` – Amount raised so far  
- `start_date`, `end_date` – Campaign period  
- `is_active` – Whether the campaign is live  
- `is_featured` – Highlighted campaign  
- `is_completed` – Whether the goal is met  
- `category` – Campaign type  
- `progress_bar_color` – UI progress color  
- `image_url`, `video_url` – Media for campaign  
- `donor_count` – Number of donors  
- `success_stories` – Related success stories  
- `created_by` – Admin who created it  
- `language`, `translation_group_id` – Multilingual support  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🎁 Donations

Tracks donations made to campaigns.

- `id` – Donation ID  
- `donor_id` – Linked donor  
- `campaign_id` – Campaign supported  
- `amount` – Donation amount  
- `currency` – Currency used  
- `donation_type` – Type (one-time, recurring, etc.)  
- `payment_method` – Method used  
- `payment_status` – Current status  
- `transaction_id` – Payment transaction ID  
- `receipt_url` – Link to receipt  
- `is_acknowledged` – If acknowledged  
- `is_tax_deductible` – Tax benefit status  
- `is_anonymous` – If anonymous  
- `notes` – Additional notes  
- `donated_at`, `created_at`, `updated_at` – Timestamps  

---

## 📆 Events

Details of events organized.

- `id` – Event ID  
- `title`, `slug` – Name and URL ID  
- `description` – Event details  
- `event_date`, `event_time`, `timezone` – Timing  
- `location`, `latitude`, `longitude` – Where it happens  
- `category` – Event type  
- `capacity` – Max participants  
- `registered_count` – Current participants  
- `status` – Event status (upcoming, ongoing, etc.)  
- `registration_deadline` – Last date to register  
- `registration_link` – Sign-up link  
- `map_embed_url` – Map location  
- `agenda`, `speaker_info`, `requirements` – Event specifics  
- `ticket_price`, `ticket_link` – Ticket info  
- `is_featured` – Whether it’s highlighted  
- `created_by` – Creator of the event  
- `language`, `translation_group_id` – Multilingual support  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🙋 Event Participants

Tracks who registered and attended events.

- `event_id`, `user_id` – References event and user  
- `role` – Role in event (attendee, volunteer, etc.)  
- `status` – Registration status  
- `hours_contributed` – Time contributed (if any)  
- `feedback`, `rating` – Post-event feedback  
- `registered_at`, `attended_at` – Timestamps  

---

## 🩺 Programs

Lists ongoing or completed programs.

- `id`, `title` – Program details  
- `category` – Program type (e.g., health, youth)  
- `description` – Details of the program  
- `start_date`, `end_date` – Program duration  
- `location` – Where it operates  
- `impact_stats` – Results/metrics  
- `is_featured` – Featured or not  
- `created_by` – Creator admin  
- `language`, `translation_group_id` – Multilingual support  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 📝 Posts

Blog, news, and press posts.

- `id`, `title`, `slug` – Basic info  
- `content` – Post body  
- `post_type` – Type of post  
- `author_id` – Author reference  
- `feature_image` – Image for display  
- `views`, `likes`, `comments_count` – Engagement metrics  
- `is_featured` – Featured flag  
- `tags` – Topics or keywords  
- `language`, `translation_group_id` – Multilingual support  
- `created_at`, `updated_at` – Timestamps  

---

## 💬 Comments

Comments made on posts.

- `id`, `post_id`, `user_id` – Linked post and commenter  
- `content` – Comment text  
- `parent_id` – For replies to comments  
- `is_approved` – If it’s approved for view  
- `created_at`, `updated_at`, `deleted_at` – Timestamps  

---

## 🗂 Media

Images, videos, and documents.

- `id`, `media_type` – Type of media  
- `title`, `description` – Basic info  
- `file_url` – Link to the file  
- `related_event_id`, `related_program_id` – Linked entities  
- `uploaded_by` – Who uploaded it  
- `language`, `translation_group_id` – Multilingual  
- `uploaded_at` – Upload time  

---

## 💬 Testimonials

User feedback and stories.

- `id`, `name`, `role` – Identity info  
- `message` – Testimonial content  
- `image_url` – Optional image  
- `type` – Who gave it (volunteer, partner, etc.)  
- `language`, `translation_group_id` – Multilingual  
- `is_featured` – Highlighted or not  
- `created_at`, `updated_at` – Timestamps  

---

## ❓ FAQs

Frequently Asked Questions.

- `id`, `question`, `answer` – Main info  
- `category` – Grouping tag  
- `language`, `translation_group_id` – Multilingual  
- `is_active`, `sort_order` – Display order  
- `created_at`, `updated_at` – Timestamps  

---

## 🤝 Partners

Organizational collaborators.

- `id`, `name`, `type`, `category` – Basic details  
- `logo_url`, `website`, `contact_email` – Info  
- `quote` – Optional testimonial  
- `language`, `translation_group_id` – Multilingual  
- `is_active` – Whether it's an active partner  
- `partnership_start_date`, `partnership_end_date` – Timeline  
- `created_at`, `updated_at` – Timestamps  

---

## 📩 Contact Messages

Messages sent through the contact form.

- `id`, `name`, `email`, `subject`, `message` – Message content  
- `reason` – Purpose (donation, volunteer, etc.)  
- `status` – Handling status  
- `ip_address`, `user_agent` – Technical info  
- `submitted_at`, `replied_at` – Timestamps  

---

## 📄 Documents

Uploaded files and downloadable documents.

- `id`, `title`, `description`, `file_url` – File info  
- `category`, `file_size`, `file_type` – Metadata  
- `uploaded_by` – Linked uploader  
- `language`, `translation_group_id` – Multilingual  
- `is_public` – Visibility control  
- `download_count` – Downloads  
- `uploaded_at`, `updated_at` – Timestamps  

---

## 📨 Newsletter Subscribers

People subscribed to your newsletter.

- `id`, `email`, `first_name`, `last_name` – Subscriber info  
- `is_active` – If the subscription is active  
- `language_preference` – Preferred language  
- `subscribed_at`, `unsubscribed_at` – Timeline  

---

## 📧 Email Logs

Track emails sent from the platform.

- `id`, `recipient`, `subject`, `template_used` – Basic info  
- `content`, `status`, `error_message` – Delivery info  
- `sent_at`, `opened_at`, `clicked_at` – Tracking  

---

## 👣 Site Interactions

Tracks user activity on the website.

- `id`, `user_id`, `session_id`, `page`, `action` – Activity details  
- `metadata` – Extra data  
- `ip_address`, `user_agent` – Technical info  
- `occurred_at` – When it happened  

---

## 🧠 Skills

Skills available in the platform.

- `id`, `name`, `category`, `description` – Skill details  
- `created_at` – Timestamp  

---

## 👨‍🔧 Volunteer Skills

Links volunteers to skills.

- `volunteer_id`, `skill_id` – Associations  
- `proficiency_level` – Skill level  
- `is_verified` – If verified  
- `created_at` – Timestamp  

---

## 🔒 Revoked Tokens

Blacklisted tokens for secure logout.

- `id`, `token_hash`, `expires_at` – Token info  
- `created_at` – When it was stored
