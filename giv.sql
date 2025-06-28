-- Create database with proper character set and collation
CREATE DATABASE IF NOT EXISTS giv_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE giv_db;

-- Users table
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'volunteer', 'donor', 'editor') NOT NULL,
    profile_image_url VARCHAR(512),
    language_preference ENUM('en', 'am') DEFAULT 'en',
    email_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB;

-- Volunteer profiles table
CREATE TABLE volunteer_profiles (
    user_id BIGINT UNSIGNED PRIMARY KEY,
    area_of_expertise VARCHAR(100),
    location VARCHAR(255),
    availability JSON,
    motivation TEXT,
    total_hours INT UNSIGNED DEFAULT 0,
    certificate_url VARCHAR(512),
    registered_events_count INT UNSIGNED DEFAULT 0,
    training_completed BOOLEAN DEFAULT FALSE,
    background_check_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    rating DECIMAL(3,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_location (location),
    INDEX idx_background_check (background_check_status)
) ENGINE=InnoDB;

-- Donor profiles table
CREATE TABLE donor_profiles (
    user_id BIGINT UNSIGNED PRIMARY KEY,
    is_recurring_donor BOOLEAN DEFAULT FALSE,
    preferred_payment_method VARCHAR(50),
    total_donated DECIMAL(15,2) DEFAULT 0.00,
    donation_frequency ENUM('monthly', 'quarterly', 'yearly'),
    tax_receipt_email VARCHAR(255),
    is_anonymous BOOLEAN DEFAULT FALSE,
    last_donation_date TIMESTAMP NULL,
    donation_tier ENUM('bronze', 'silver', 'gold', 'platinum'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_donation_tier (donation_tier),
    INDEX idx_recurring_donor (is_recurring_donor)
) ENGINE=InnoDB;

-- Campaigns table
CREATE TABLE campaigns (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    goal_amount DECIMAL(15,2) NOT NULL,
    current_amount DECIMAL(15,2) DEFAULT 0.00,
    start_date DATE NOT NULL,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    category VARCHAR(50),
    progress_bar_color VARCHAR(20),
    image_url VARCHAR(512),
    video_url VARCHAR(512),
    donor_count INT UNSIGNED DEFAULT 0,
    success_stories JSON,
    created_by BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (created_by) REFERENCES users(id),
    INDEX idx_slug (slug),
    INDEX idx_category (category),
    INDEX idx_active_featured (is_active, is_featured)
) ENGINE=InnoDB;

-- Donations table
CREATE TABLE donations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    donor_id BIGINT UNSIGNED NOT NULL,
    campaign_id BIGINT UNSIGNED NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    donation_type ENUM('one_time', 'recurring', 'in_kind') NOT NULL,
    payment_method VARCHAR(50),
    payment_status ENUM('pending', 'completed', 'failed') NOT NULL,
    transaction_id VARCHAR(100) UNIQUE,
    receipt_url VARCHAR(512),
    is_acknowledged BOOLEAN DEFAULT FALSE,
    is_tax_deductible BOOLEAN DEFAULT TRUE,
    is_anonymous BOOLEAN DEFAULT FALSE,
    notes TEXT,
    donated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (donor_id) REFERENCES donor_profiles(user_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id),
    INDEX idx_donation_date (donated_at),
    INDEX idx_payment_status (payment_status)
) ENGINE=InnoDB;

-- Events table
CREATE TABLE events (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    timezone VARCHAR(50) DEFAULT 'UTC',
    location VARCHAR(255),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    category VARCHAR(50),
    capacity INT UNSIGNED,
    registered_count INT UNSIGNED DEFAULT 0,
    status ENUM('upcoming', 'ongoing', 'completed', 'cancelled') DEFAULT 'upcoming',
    registration_deadline TIMESTAMP,
    registration_link VARCHAR(512),
    map_embed_url VARCHAR(512),
    agenda TEXT,
    speaker_info JSON,
    requirements TEXT,
    ticket_price DECIMAL(10,2),
    ticket_link VARCHAR(512),
    is_featured BOOLEAN DEFAULT FALSE,
    created_by BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (created_by) REFERENCES users(id),
    INDEX idx_slug (slug),
    INDEX idx_event_date (event_date),
    INDEX idx_status (status),
    SPATIAL INDEX idx_location (latitude, longitude)
) ENGINE=InnoDB;

-- Event participants table
CREATE TABLE event_participants (
    event_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED,
    role ENUM('volunteer', 'attendee', 'organizer') NOT NULL,
    status ENUM('registered', 'confirmed', 'attended', 'no_show') DEFAULT 'registered',
    hours_contributed DECIMAL(5,2),
    feedback TEXT,
    rating TINYINT UNSIGNED CHECK (rating BETWEEN 1 AND 5),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attended_at TIMESTAMP NULL,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- Programs table
CREATE TABLE programs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category ENUM('medical_outreach', 'mental_health', 'youth_development', 'disease_prevention'),
    description TEXT,
    start_date DATE,
    end_date DATE,
    location VARCHAR(255),
    impact_stats JSON,
    is_featured BOOLEAN DEFAULT FALSE,
    created_by BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (created_by) REFERENCES users(id),
    INDEX idx_category (category),
    INDEX idx_date_range (start_date, end_date)
) ENGINE=InnoDB;

-- Posts table
CREATE TABLE posts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    content TEXT,
    post_type ENUM('blog', 'news', 'press_release') NOT NULL,
    author_id BIGINT UNSIGNED,
    feature_image VARCHAR(512),
    language ENUM('en', 'am') DEFAULT 'en',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id),
    INDEX idx_slug (slug),
    INDEX idx_post_type (post_type),
    FULLTEXT INDEX idx_content (title, content)
) ENGINE=InnoDB;

-- Media table
CREATE TABLE media (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    media_type ENUM('image', 'video', 'pdf') NOT NULL,
    title VARCHAR(255),
    description TEXT,
    file_url VARCHAR(512) NOT NULL,
    related_event_id BIGINT UNSIGNED,
    related_program_id BIGINT UNSIGNED,
    uploaded_by BIGINT UNSIGNED,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (related_event_id) REFERENCES events(id) ON DELETE SET NULL,
    FOREIGN KEY (related_program_id) REFERENCES programs(id) ON DELETE SET NULL,
    FOREIGN KEY (uploaded_by) REFERENCES users(id),
    INDEX idx_media_type (media_type)
) ENGINE=InnoDB;

-- Skills table
CREATE TABLE skills (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category)
) ENGINE=InnoDB;

-- Volunteer skills table
CREATE TABLE volunteer_skills (
    volunteer_id BIGINT UNSIGNED,
    skill_id BIGINT UNSIGNED,
    proficiency_level ENUM('beginner', 'intermediate', 'expert') NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (volunteer_id, skill_id),
    FOREIGN KEY (volunteer_id) REFERENCES volunteer_profiles(user_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    INDEX idx_proficiency (proficiency_level)
) ENGINE=InnoDB;

-- Add triggers for UUID generation
DELIMITER //

CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Repeat for other tables that need UUID generation
CREATE TRIGGER before_insert_campaigns
BEFORE INSERT ON campaigns
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Add more similar triggers for other tables

DELIMITER ;
