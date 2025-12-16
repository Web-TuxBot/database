ALTER TABLE users
  ADD CONSTRAINT fk_users_role
  FOREIGN KEY (role_id) REFERENCES roles(id)
  ON DELETE SET NULL;

-- audit_logs/user_sessions связываем по uuid (логика: если пользователя удалили, логи можно оставить)
ALTER TABLE user_sessions
  ADD CONSTRAINT fk_sessions_user
  FOREIGN KEY (user_uuid) REFERENCES users(uuid)
  ON DELETE CASCADE;

ALTER TABLE audit_logs
  ADD CONSTRAINT fk_audit_user
  FOREIGN KEY (user_uuid) REFERENCES users(uuid)
  ON DELETE SET NULL;
