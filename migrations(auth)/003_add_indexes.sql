CREATE INDEX idx_users_uuid ON users(uuid);
CREATE INDEX idx_users_username ON users(username);

CREATE INDEX idx_sessions_user_uuid ON user_sessions(user_uuid);
CREATE INDEX idx_sessions_expires ON user_sessions(expires_at);

CREATE INDEX idx_audit_user_uuid ON audit_logs(user_uuid);
CREATE INDEX idx_audit_created_at ON audit_logs(created_at);

CREATE INDEX idx_metrics_name_created_at ON system_metrics(metric_name, created_at);
