import tkinter as tk
from tkinter import ttk
from PIL import Image, ImageTk
import os
import threading # Para que no se cuelgue la ventana
from zephyr_core import ZephyrProtocol 

class ZephyrGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Elyra - Zephyr Protocol")
        self.root.geometry("1100x750")
        self.root.configure(bg="#0b141a") 

        self.protocol = ZephyrProtocol()
        self.image_path = os.path.expanduser("~/Elyra/core/Zephyr_rostro.png")

        # --- Layout ---
        self.side_panel = tk.Frame(root, bg="#0b141a", width=400)
        self.side_panel.pack(side="left", fill="y")

        try:
            img = Image.open(self.image_path)
            img.thumbnail((400, 700), Image.Resampling.LANCZOS)
            self.photo = ImageTk.PhotoImage(img)
            self.img_label = tk.Label(self.side_panel, image=self.photo, bg="#0b141a")
            self.img_label.pack(expand=True, padx=10)
        except:
            tk.Label(self.side_panel, text="[Zephyr Rostro]", fg="white", bg="#0b141a").pack(expand=True)

        self.chat_panel = tk.Frame(root, bg="#111b21")
        self.chat_panel.pack(side="right", fill="both", expand=True)

        self.display = tk.Text(self.chat_panel, bg="#0b141a", fg="#e9edef", 
                               font=("Segoe UI", 11), state="disabled", bd=0, padx=20, pady=20)
        self.display.pack(fill="both", expand=True)

        self.entry_frame = tk.Frame(self.chat_panel, bg="#202c33")
        self.entry_frame.pack(fill="x")

        self.entry = tk.Entry(self.entry_frame, bg="#2a3942", fg="white", 
                              font=("Segoe UI", 12), insertbackground="white", bd=0)
        self.entry.pack(padx=20, pady=20, fill="x")
        self.entry.bind("<Return>", self.send_message)
        self.entry.focus_set()

        self.append_text("Zephyr", "Protocolo activo. Estoy despertando a Ollama, la primera respuesta puede tardar unos segundos, Mehmet...")

    def append_text(self, sender, message):
        self.display.config(state="normal")
        tag = "zephyr_msg" if sender == "Zephyr" else "mehmet_msg"
        self.display.tag_config("zephyr_msg", foreground="#00a884", font=("Segoe UI", 11, "bold"))
        self.display.tag_config("mehmet_msg", foreground="#8696a0", font=("Segoe UI", 11, "bold"))
        
        self.display.insert("end", f"{sender}: ", tag)
        self.display.insert("end", f"{message}\n\n")
        self.display.config(state="disabled")
        self.display.see("end")

    def send_message(self, event=None):
        user_text = self.entry.get()
        if user_text.strip():
            self.append_text("Mehmet", user_text)
            self.entry.delete(0, "end")
            
            # Lanzamos el pensamiento de la IA en un hilo separado
            threading.Thread(target=self.get_ai_async, args=(user_text,), daemon=True).start()

    def get_ai_async(self, text):
        # Esta parte corre sin bloquear la ventana
        response = self.protocol.process_command(text)
        # Volvemos al hilo principal para actualizar la GUI
        self.root.after(0, lambda: self.append_text("Zephyr", response))

if __name__ == "__main__":
    root = tk.Tk()
    app = ZephyrGUI(root)
    root.mainloop()
