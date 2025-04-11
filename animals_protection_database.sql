use test;

-- User Table
CREATE TABLE IF NOT EXISTS user
(
    id            BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'User ID',
    username      VARCHAR(50)                                         NOT NULL UNIQUE COMMENT 'Username',
    password_hash VARCHAR(255)                                        NOT NULL COMMENT 'Password Hash',
    email         VARCHAR(100) COMMENT 'Email Address',
    role          ENUM ('STUDENT', 'TEACHER', 'CONTRIBUTOR', 'ADMIN') NOT NULL COMMENT 'User Role',
    status        TINYINT  DEFAULT 1 COMMENT 'Account Status (1=Active, 0=Disabled)',
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time'
);

-- User Profile Table
CREATE TABLE user_profile
(
    user_id    BIGINT PRIMARY KEY COMMENT 'User ID',
    full_name  VARCHAR(100) COMMENT 'Full Name',
    age        INT COMMENT 'Age',
    gender     ENUM ('M', 'F', 'OTHER') COMMENT 'Gender',
    bio        TEXT COMMENT 'Biography',
    avatar_url VARCHAR(255) COMMENT 'Avatar URL',
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Organization Table
CREATE TABLE organization
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Organization ID',
    uuno        VARCHAR(100) NOT NULL COMMENT 'Organization Unique Code',
    name        VARCHAR(100) NOT NULL COMMENT 'Organization Name',
    description TEXT COMMENT 'Organization Description',
    region      VARCHAR(100) COMMENT 'Region',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time'
);

-- User and Organization Mapping Table
CREATE TABLE org_member_mapping
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Mapping ID',
    user_id     BIGINT COMMENT 'User ID',
    org_id      BIGINT COMMENT 'Organization ID',
    role_in_org VARCHAR(50) COMMENT 'User Role in Organization',
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (org_id) REFERENCES organization (id)
);

-- User Contributions Table
CREATE TABLE user_contrib
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Contribution ID',
    user_id    BIGINT COMMENT 'User ID',
    title      VARCHAR(100) COMMENT 'Title',
    content    TEXT COMMENT 'Content',
    type       ENUM ('ARTICLE', 'REPORT', 'ESSAY') COMMENT 'Content Type',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Submission Time',
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Contribution Materials Table
CREATE TABLE contrib_material
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Material ID',
    contrib_id BIGINT COMMENT 'Contribution ID',
    file_url   VARCHAR(255) COMMENT 'File URL',
    file_type  VARCHAR(50) COMMENT 'File Type',
    FOREIGN KEY (contrib_id) REFERENCES user_contrib (id)
);

-- Article Comments Table
CREATE TABLE article_comment
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Comment ID',
    article_id BIGINT COMMENT 'Article ID',
    user_id    BIGINT COMMENT 'Commenter ID',
    content    TEXT COMMENT 'Comment Content',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Comment Time',
    FOREIGN KEY (article_id) REFERENCES user_contrib (id),
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Article Tags Table
CREATE TABLE article_tag
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Tag ID',
    contrib_id BIGINT COMMENT 'Contribution ID',
    tag        VARCHAR(50) COMMENT 'Tag Content',
    FOREIGN KEY (contrib_id) REFERENCES user_contrib (id)
);

-- User Canvas Table
CREATE TABLE canvas
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Canvas ID',
    user_id     BIGINT COMMENT 'User ID',
    title       VARCHAR(100) COMMENT 'Canvas Title',
    description TEXT COMMENT 'Canvas Description',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Canvas Materials Table
CREATE TABLE canvas_material
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Material ID',
    canvas_id   BIGINT COMMENT 'Canvas ID',
    file_url    VARCHAR(255) COMMENT 'Material URL',
    description TEXT COMMENT 'Material Description',
    FOREIGN KEY (canvas_id) REFERENCES canvas (id)
);

-- Canvas Sharing Table
CREATE TABLE canvas_share
(
    id               BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Share ID',
    canvas_id        BIGINT COMMENT 'Canvas ID',
    shared_with_user BIGINT COMMENT 'Shared User ID',
    permission       ENUM ('VIEW', 'COMMENT') COMMENT 'Permission',
    shared_at        DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Share Time',
    FOREIGN KEY (canvas_id) REFERENCES canvas (id),
    FOREIGN KEY (shared_with_user) REFERENCES user (id)
);

-- Audit Log Table
CREATE TABLE audit_log
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Log ID',
    user_id     BIGINT COMMENT 'User ID',
    action      VARCHAR(255) COMMENT 'Action Description',
    ip_address  VARCHAR(45) COMMENT 'IP Address',
    device_info TEXT COMMENT 'Device Info',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Record Time',
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Dashboard Configuration Table
CREATE TABLE dashboard
(
    id           BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Dashboard ID',
    user_id      BIGINT COMMENT 'User ID',
    config_json  TEXT COMMENT 'Configuration (JSON)',
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Last Update Time',
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Dashboard Metrics Sampling Table
CREATE TABLE dashboard_metric
(
    id           BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Metric ID',
    dashboard_id BIGINT COMMENT 'Dashboard ID',
    metric_key   VARCHAR(100) COMMENT 'Metric Key',
    metric_value DOUBLE COMMENT 'Metric Value',
    timestamp    DATETIME COMMENT 'Sampling Time',
    FOREIGN KEY (dashboard_id) REFERENCES dashboard (id)
);

-- Endangered Species Table
CREATE TABLE endangered_species
(
    id                    INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Endangered Species Unique ID',
    species_name          VARCHAR(255) NOT NULL COMMENT 'Species Name',
    scientific_name       VARCHAR(255) NOT NULL COMMENT 'Scientific Name',
    status                ENUM ('Critical', 'Endangered', 'Vulnerable', 'Near Threatened', 'Least Concern') NOT NULL COMMENT 'Protection Status',
    habitat               TEXT COMMENT 'Habitat',
    population_estimate   INT COMMENT 'Estimated Population',
    distribution          TEXT COMMENT 'Distribution Area',
    conservation_measures TEXT COMMENT 'Conservation Measures',
    photo_url             VARCHAR(255) COMMENT 'Species Photo URL',
    description           TEXT COMMENT 'Species Description',
    last_observed         DATE COMMENT 'Last Observed Date',
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Record Creation Time',
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Updated Time'
) COMMENT = 'Endangered Species Archive Table';

-- Community Contributions Table
CREATE TABLE community_contributions
(
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Contribution Record Unique ID',
    community_id      INT NOT NULL COMMENT 'Community ID, Foreign Key to Community Table',
    species_id        INT NOT NULL COMMENT 'Species ID, Foreign Key to Endangered Species Table',
    contribution_type ENUM ('Article', 'Sightings', 'Fundraising', 'Research') NOT NULL COMMENT 'Contribution Type',
    description       TEXT COMMENT 'Contribution Description',
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
    FOREIGN KEY (species_id) REFERENCES endangered_species (id)
) COMMENT = 'Community Contributions Table';

-- Activity Table
CREATE TABLE activity
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Activity ID',
    species_id  INT NOT NULL COMMENT 'Associated Species ID',
    title       VARCHAR(100) COMMENT 'Activity Title',
    description TEXT COMMENT 'Activity Description',
    type        ENUM ('CLASS', 'OUTDOOR', 'ONLINE') COMMENT 'Activity Type',
    start_time  DATETIME COMMENT 'Start Time',
    end_time    DATETIME COMMENT 'End Time',
    created_by  BIGINT COMMENT 'Creator ID',
    FOREIGN KEY (created_by) REFERENCES user (id),
    FOREIGN KEY (species_id) REFERENCES endangered_species (id)
);

-- Activity Enrollment Table
CREATE TABLE activity_enroll
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Enrollment Record ID',
    activity_id BIGINT COMMENT 'Activity ID',
    user_id     BIGINT COMMENT 'User ID',
    status      ENUM ('PENDING', 'APPROVED', 'REJECTED') COMMENT 'Enrollment Status',
    enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Enrollment Time',
    FOREIGN KEY (activity_id) REFERENCES activity (id),
    FOREIGN KEY (user_id) REFERENCES user (id)
);

-- Activity Log Table
CREATE TABLE activity_log
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Log ID',
    activity_id BIGINT COMMENT 'Activity ID',
    user_id     BIGINT COMMENT 'User ID',
    action      VARCHAR(100) COMMENT 'User Action',
    logged_at   DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Log Time',
    FOREIGN KEY (activity_id) REFERENCES activity (id),
    FOREIGN KEY (user_id) REFERENCES user (id)
);
