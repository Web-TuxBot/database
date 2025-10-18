-- =============================================
-- MIGRATION 003: ADD INDEXES
-- =============================================

-- Users indexes
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Chats indexes
CREATE INDEX idx_chats_user_id ON chats(user_id);
CREATE INDEX idx_chats_model_id ON chats(model_id);
CREATE INDEX idx_chats_created_at ON chats(created_at);
CREATE INDEX idx_chats_uuid ON chats(uuid);
-- Composite index for common queries
CREATE INDEX idx_chats_user_created ON chats(user_id, created_at DESC);

-- Messages indexes
CREATE INDEX idx_messages_chat_id ON messages(chat_id);
CREATE INDEX idx_messages_created_at ON messages(created_at);
-- Composite index for chat history
CREATE INDEX idx_messages_chat_created ON messages(chat_id, created_at DESC);

-- Message feedbacks indexes
CREATE INDEX idx_message_feedbacks_message_id ON message_feedbacks(message_id);
CREATE INDEX idx_message_feedbacks_model_id ON message_feedbacks(model_id);
CREATE INDEX idx_message_feedbacks_created_at ON message_feedbacks(created_at);
-- Composite index for feedback analysis
CREATE INDEX idx_feedbacks_message_created ON message_feedbacks(message_id, created_at);

-- User sessions indexes
CREATE INDEX idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_user_sessions_expires_at ON user_sessions(expires_at);
CREATE INDEX idx_user_sessions_refresh_token ON user_sessions(refresh_token);
-- Composite index for session cleanup
CREATE INDEX idx_sessions_user_expires ON user_sessions(user_id, expires_at);

-- Audit logs indexes
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_logs_ip_address ON audit_logs(ip_address);
-- Composite index for user activity analysis
CREATE INDEX idx_audit_user_timestamp ON audit_logs(user_id, timestamp DESC);

-- System metrics indexes
CREATE INDEX idx_system_metrics_type ON system_metrics(metric_type);
CREATE INDEX idx_system_metrics_created_at ON system_metrics(created_at);
CREATE INDEX idx_system_metrics_endpoint ON system_metrics(endpoint);
-- Composite index for metrics analysis
CREATE INDEX idx_metrics_type_created ON system_metrics(metric_type, created_at);

-- Command suggestions indexes (new)
CREATE INDEX idx_command_suggestions_usage_count ON command_suggestions(usage_count);

-- Feedback analysis indexes (new)
CREATE INDEX idx_feedback_analysis_feedback_id ON feedback_analysis(feedback_id);
CREATE INDEX idx_feedback_analysis_created_at ON feedback_analysis(created_at);