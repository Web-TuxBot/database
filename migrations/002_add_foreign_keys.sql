-- =============================================
-- MIGRATION 002: ADD FOREIGN KEY CONSTRAINTS
-- =============================================

-- Add foreign keys for chats table
ALTER TABLE chats 
ADD CONSTRAINT fk_chats_users 
FOREIGN KEY (user_id) REFERENCES users(id) 
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE chats 
ADD CONSTRAINT fk_chats_bot_models 
FOREIGN KEY (model_id) REFERENCES bot_models(id) 
ON UPDATE CASCADE ON DELETE RESTRICT;

-- Add foreign key for messages table
ALTER TABLE messages 
ADD CONSTRAINT fk_messages_chats 
FOREIGN KEY (chat_id) REFERENCES chats(id) 
ON UPDATE CASCADE ON DELETE CASCADE;

-- Add foreign keys for message_feedbacks table
ALTER TABLE message_feedbacks 
ADD CONSTRAINT fk_feedbacks_messages 
FOREIGN KEY (message_id) REFERENCES messages(id) 
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE message_feedbacks 
ADD CONSTRAINT fk_feedbacks_models 
FOREIGN KEY (model_id) REFERENCES bot_models(id) 
ON UPDATE CASCADE ON DELETE RESTRICT;

-- Add foreign key for user_sessions table
ALTER TABLE user_sessions 
ADD CONSTRAINT fk_sessions_users 
FOREIGN KEY (user_id) REFERENCES users(id) 
ON UPDATE CASCADE ON DELETE CASCADE;

-- Add foreign key for audit_logs table
ALTER TABLE audit_logs 
ADD CONSTRAINT fk_audit_users 
FOREIGN KEY (user_id) REFERENCES users(id) 
ON UPDATE CASCADE ON DELETE SET NULL;

-- Add foreign key for feedback_analysis table
ALTER TABLE feedback_analysis 
ADD CONSTRAINT fk_analysis_feedback 
FOREIGN KEY (feedback_id) REFERENCES message_feedbacks(id) 
ON UPDATE CASCADE ON DELETE CASCADE;

-- Add data validation constraints
ALTER TABLE users ADD CONSTRAINT chk_username_length 
CHECK (LENGTH(username) >= 3 AND LENGTH(username) <= 50);

ALTER TABLE users ADD CONSTRAINT chk_password_hash_length 
CHECK (LENGTH(password_hash) >= 60);

ALTER TABLE chats ADD CONSTRAINT chk_title_length 
CHECK (LENGTH(title) <= 200);