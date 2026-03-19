import sqlite3
import datetime
import os
import subprocess
import requests
import json

class ZephyrProtocol:
    def __init__(self, db_name="elyra_chat.db"):
        self.base_path = os.path.expanduser("~/Elyra")
        self.db_path = os.path.join(self.base_path, "core", db_name)
        # PARCHE MULTIHILO APLICADO:
        self.conn = sqlite3.connect(self.db_path, check_same_thread=False)
        self.cursor = self.conn.cursor()
        self.setup_db()
        self.ollama_url = "http://localhost:11434/api/generate"
        self.model = "zephyr-v3:latest"

    def setup_db(self):
        self.cursor.execute('CREATE TABLE IF NOT EXISTS history (id INTEGER PRIMARY KEY AUTOINCREMENT, sender TEXT, message TEXT, timestamp TEXT)')
        self.conn.commit()

    def save_message(self, sender, message):
        stamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.cursor.execute("INSERT INTO history (sender, message, timestamp) VALUES (?, ?, ?)", (sender, message, stamp))
        self.conn.commit()

    def get_system_status(self):
        try:
            ram = subprocess.check_output("free -h | grep Mem | awk '{print $3 \" / \" $2}'", shell=True).decode("utf-8").strip()
            cpu = subprocess.check_output("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4\"%\"}'", shell=True).decode("utf-8").strip()
            return f"--- ELYRA STATUS ---\nRAM: {ram}\nCPU: {cpu}\nIA: {self.model}\nEstado: Lista."
        except:
            return "Error en sensores."

    def get_ollama_response(self, prompt):
        payload = {
            "model": self.model,
            "prompt": f"Zephyr: {prompt}",
            "stream": False,
            "options": {
                "num_thread": 8,
                "num_predict": 80,
                "temperature": 0.6
            }
        }
        try:
            r = requests.post(self.ollama_url, json=payload, timeout=20)
            return r.json().get('response', '...')
        except:
            return "Ollama offline."

    def process_command(self, text):
        self.save_message("Mehmet", text)
        msg = text.strip().lower()
        if msg == "/status":
            response = self.get_system_status()
        else:
            response = self.get_ollama_response(text)
        self.save_message("Zephyr", response)
        return response

if __name__ == "__main__":
    pass
