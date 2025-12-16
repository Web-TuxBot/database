package main

import (
	"time"

	"github.com/google/uuid"
)

type BotModel struct {
	ID        uint64    `gorm:"primaryKey;autoIncrement"`
	Name      string    `gorm:"size:100;not null;uniqueIndex"`
	Provider  string    `gorm:"size:100;not null"`
	Version   string    `gorm:"size:50"`
	MaxTokens *int
	CreatedAt time.Time `gorm:"not null;default:now()"`
}

type Chat struct {
	UUID      uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Title     *string   `gorm:"size:255"`
	AIModelID *uint64   `gorm:"column:ai_model_id"`
	CreatedAt time.Time `gorm:"not null;default:now()"`

	Messages []Message `gorm:"foreignKey:ChatUUID;references:UUID"`
}

type Message struct {
	ID        uint64    `gorm:"primaryKey;autoIncrement"`
	ChatUUID  uuid.UUID `gorm:"type:uuid;not null;index;column:chat_uuid"`
	Role      string    `gorm:"size:50;not null"`
	Content   string    `gorm:"type:text;not null"`
	Tokens    *int
	CreatedAt time.Time `gorm:"not null;default:now()"`
}

type MessageFeedback struct {
	ID        uint64    `gorm:"primaryKey;autoIncrement"`
	MessageID uint64    `gorm:"not null;index"`
	Rating    int       `gorm:"not null"`
	Comment   *string   `gorm:"type:text"`
	CreatedAt time.Time `gorm:"not null;default:now()"`
}

type FeedbackAnalysis struct {
	ID         uint64    `gorm:"primaryKey;autoIncrement"`
	FeedbackID uint64    `gorm:"not null;index"`
	Sentiment  *string   `gorm:"size:50"`
	Tags       []string  `gorm:"type:text[]"`
	Metadata   []byte    `gorm:"type:jsonb"` // можно map[string]any через gorm.io/datatypes
	CreatedAt  time.Time `gorm:"not null;default:now()"`
}

type CommandSuggestion struct {
	ID         uint64    `gorm:"primaryKey;autoIncrement"`
	MessageID  uint64    `gorm:"not null;index"`
	Command    string    `gorm:"type:text;not null"`
	Confidence float64   `gorm:"not null;default:0"`
	CreatedAt  time.Time `gorm:"not null;default:now()"`
}
