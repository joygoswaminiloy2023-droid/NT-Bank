# 🏦 NT BANK

NT Bank is a simple banking management system developed using Bash Shell Script and Zenity GUI for Linux/WSL. It provides a graphical interface to perform basic banking operations such as creating accounts, deposits, withdrawals, balance checking, and viewing all accounts.

The project stores all data in a local text file (bank_db.txt) and is designed for learning shell scripting, file handling, and GUI-based application development in Linux environments.

## ✨ Features
- Create new bank account (6-digit validation)  
- Secure 6-digit password system  
- Deposit money into account  
- Withdraw money with balance validation  
- Check account balance  
- View all accounts  
- Simple GUI interface using Zenity  

## 🛠 Technologies Used
- Bash Shell Scripting  
- Zenity (GUI for Linux)  
- File-based storage system  

## 📁 Project Structure
- bank_gui.sh → Main script file  
- bank_db.txt → Database file (auto-created)  

## 🚀 How to Run

### First-time setup + run
sudo apt update && sudo apt install zenity -y && cd ~/NT_bank && chmod +x bank_gui.sh && ./bank_gui.sh

👉 This command installs required dependencies, moves into the project folder, gives permission to execute the script, and runs the application in one step.

### Quick run (after setup)
cd ~/NT_bank && ./bank_gui.sh

## 🎯 Purpose
This project is built for learning purposes to understand shell scripting, GUI integration using Zenity, file handling, and basic banking system logic simulation in Linux environments.

## 👨‍💻 Author
NT Bank Project – Built for educational purposes
