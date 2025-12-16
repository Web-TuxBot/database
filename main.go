package main

import (
	"fmt"
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func openDB(dsn string) *gorm.DB {
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("failed to connect db: %v", err)
	}
	return db
}

func main() {
	authDSN := os.Getenv("AUTH_DB_DSN") // postgres://user:pass@localhost:5432/auth_db?sslmode=disable
	aiDSN := os.Getenv("AI_DB_DSN")     // postgres://user:pass@localhost:5432/ai_db?sslmode=disable

	if authDSN == "" || aiDSN == "" {
		log.Fatal("AUTH_DB_DSN and AI_DB_DSN must be set")
	}

	authDB := openDB(authDSN)
	aiDB := openDB(aiDSN)

	fmt.Println("connected to auth db and ai db")

	
	_ = authDB
	_ = aiDB

	
